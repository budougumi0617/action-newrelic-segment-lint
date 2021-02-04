#!/bin/bash

cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit 1

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" "${REVIEWDOG_VERSION}" 2>&1
echo '::endgroup::'

echo '::group:: Installing nrseg ... https://github.com/budougumi0617/nrseg'
curl -L "$(curl -Ls https://api.github.com/repos/budougumi0617/nrseg/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -o nrseg.zip && unzip nrseg.zip -d "${TEMP_PATH}" && rm nrseg.zip
echo '::endgroup::'

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo '::group:: Running nrseg with reviewdog 🐶 ...'
# shellcheck disable=SC2086
nrseg inspect ${INPUT_NRSEG_FLAGS} \
  | reviewdog -f=golint \
      -name="${INPUT_TOOL_NAME}" \
      -reporter="${INPUT_REPORTER:-github-pr-review}" \
      -filter-mode="${INPUT_FILTER_MODE:-added}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR:-false}" \
      -level="${INPUT_LEVEL}" \
      ${INPUT_REVIEWDOG_FLAGS}
echo '::endgroup::'