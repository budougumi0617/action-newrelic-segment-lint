# action-template

[![reviewdog](https://github.com/budougumi0617/action-newrelic-segment-lint/workflows/reviewdog/badge.svg)](https://github.com/budougumi0617/action-newrelic-segment-lint/actions?query=workflow%3Areviewdog)
[![depup](https://github.com/budougumi0617/action-newrelic-segment-lint/workflows/depup/badge.svg)](https://github.com/budougumi0617/action-newrelic-segment-lint/actions?query=workflow%3Adepup)
[![release](https://github.com/budougumi0617/action-newrelic-segment-lint/workflows/release/badge.svg)](https://github.com/budougumi0617/action-newrelic-segment-lint/actions?query=workflow%3Arelease)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/budougumi0617/action-newrelic-segment-lint?logo=github&sort=semver)](https://github.com/budougumi0617/action-newrelic-segment-lint/releases)

[comment]: <> ([![action-bumpr supported]&#40;https://img.shields.io/badge/bumpr-supported-ff69b4?logo=github&link=https://github.com/haya14busa/action-bumpr&#41;]&#40;https://github.com/haya14busa/action-bumpr&#41;)

[comment]: <> (![github-pr-review demo]&#40;https://user-images.githubusercontent.com/3797062/73162963-4b8e2b00-4132-11ea-9a3f-f9c6f624c79f.png&#41;)

[comment]: <> (![github-pr-check demo]&#40;https://user-images.githubusercontent.com/3797062/73163032-70829e00-4132-11ea-8481-f213a37db354.png&#41;)

## Input

<!-- TODO: update -->
```yaml
inputs:
  github_token:
    description: 'GITHUB_TOKEN'
    default: '${{ github.token }}'
  nrseg_flags:
    description: 'nrseg flags. (nrseg inspect <nrseg_flags>)'
    default: ''
  tool_name:
    description: 'Tool name to use for reviewdog reporter'
    default: 'nrseg'
  level:
    description: 'Report level for reviewdog [info,warning,error]'
    default: 'error'
  reporter:
    description: 'Reporter of reviewdog command [github-pr-check,github-check,github-pr-review].'
    default: 'github-pr-check'
  filter_mode:
    description: |
      Filtering mode for the reviewdog command [added,diff_context,file,nofilter].
      Default is added.
    default: 'added'
  fail_on_error:
    description: |
      Exit code for reviewdog when errors are found [true,false]
      Default is `false`.
    default: 'false'
  reviewdog_flags:
    description: 'Additional reviewdog flags'
    default: ''
```

## Usage

```yaml
name: nrseg
on: [pull_request]
jobs:
  linter_name:
    name: runner / nrseg inspect
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: budougumi0617/action-newrelic-segment-lint
        with:
          github_token: ${{ secrets.github_token }}
          nrseg_flags: "-i testing ./src"
          # Change reviewdog reporter if you need [github-pr-check,github-check,github-pr-review].
          reporter: github-pr-review
          # Change reporter level if you need.
          # GitHub Status Check won't become failure with warning.
          level: warning
```

## Development

### Release

#### [haya14busa/action-bumpr](https://github.com/haya14busa/action-bumpr)
You can bump version on merging Pull Requests with specific labels (bump:major,bump:minor,bump:patch).
Pushing tag manually by yourself also work.

#### [haya14busa/action-update-semver](https://github.com/haya14busa/action-update-semver)

This action updates major/minor release tags on a tag push. e.g. Update v1 and v1.2 tag when released v1.2.3.
ref: https://help.github.com/en/articles/about-actions#versioning-your-action

### Lint - reviewdog integration

This reviewdog action template itself is integrated with reviewdog to run lints
which is useful for Docker container based actions.

![reviewdog integration](https://user-images.githubusercontent.com/3797062/72735107-7fbb9600-3bde-11ea-8087-12af76e7ee6f.png)

Supported linters:

- [reviewdog/action-shellcheck](https://github.com/reviewdog/action-shellcheck)
- [reviewdog/action-hadolint](https://github.com/reviewdog/action-hadolint)
- [reviewdog/action-misspell](https://github.com/reviewdog/action-misspell)

### Dependencies Update Automation
This repository uses [reviewdog/action-depup](https://github.com/reviewdog/action-depup) to update
reviewdog version.

