#!/usr/bin/env bash
set -euo pipefail

# NOTE: this script is meant to be run on the GitLab CI, it depends on GitLab CI variables
# Based on https://github.com/signalfx/splunk-otel-java/blob/c9134906c84e9a32a974dec4b380453fe1757410/scripts/propagate-version.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source-path=SCRIPTDIR
source "${SCRIPT_DIR}/common.sh"

ROOT_DIR="${SCRIPT_DIR}/../"
cd "${ROOT_DIR}"

create_collector_pr() {
  local repo="signalfx/splunk-otel-collector"
  local repo_url="https://srv-gh-o11y-gdi:${GITHUB_TOKEN}@github.com/${repo}.git"
  local branch="create-pull-request/update-nodejs-agent"
  local message="Update splunk-otel-js to latest"

  echo ">>> Cloning the $repo repository ..."
  git clone "$repo_url" collector-mirror
  cd collector-mirror

  setup_branch "$branch" "$repo_url"

  echo ">>> Getting latest splunk-otel-js release ..."
  tag="$(curl "https://api.github.com/repos/signalfx/splunk-otel-js/tags" | jq -r '[.[].name | select(test("v[0-9]+\\.[0-9]+\\.[0-9]+")) ] | sort_by(split(".")) | last')"
  if [[ -n "$tag" ]]; then
    echo ">>> Updating splunk-otel-js version to $tag ..."
    echo "$tag" > instrumentation/packaging/nodejs-agent-release.txt
  else
    echo "ERROR: Failed to get latest release tag from https://github.com/signalfx/splunk-otel-js !" >&2
    exit 1
  fi

  # Only create the PR if there are changes
  if ! git diff --exit-code >/dev/null 2>&1; then
    git commit -S -am "$message"
    git push -f "$repo_url" "$branch"
    echo ">>> Creating the PR ..."
    gh pr create \
      --draft \
      --repo "$repo" \
      --title "$message" \
      --body "$message" \
      --base main \
      --head "$branch"
  fi
}

setup_gpg
import_gpg_secret_key "$GITHUB_BOT_GPG_KEY"
setup_git
create_collector_pr
