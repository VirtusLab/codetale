# CodeTale GitHub Action

This action provides continuous synchronization of discussions from pull-requests in your GitHub repository with CodeTale plugin. Please refer to [CodeTale documentation](https://virtuslab.github.io/codetale/) for more information on how to use the plugin and how to set up the repository for storing discussions. The plugin is available for [Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=virtuslab.codetale) and [Intellij platform](https://plugins.jetbrains.com/plugin/16895-codetale).

## Arguments

**githubToken**: token of the runner, usually ${{ secrets.GITHUB_TOKEN }} </br>
**branch**: name of the branch the CodeTale data is stored, will be created if not existent </br>
**outputRepository**: (optional) url of the CodeTale data repository, if it's different than the current repository </br>

## Usage

Basic setup, if your CodeTale data is kept in the same repository as your code:
```yaml
name: Codetale comments convertion

on:
  pull_request:
    types: [closed]

jobs:
  convert:
    if: github.event.pull_request.merged == true

    runs-on: ubuntu-latest

    steps:
      - name: Run converter
        uses: VirtusLab/codetale@master
        with:
          githubToken: ${{ secrets.GITHUB_TOKEN }}
          branch: codetale_comments
```

To push converted comments to a repository other than the repository the action is run from, define `outputRepository` option:
```yaml
    steps:
      - name: Run converter
        uses: VirtusLab/codetale@master
        with:
          githubToken: ${{ secrets.GITHUB_TOKEN }}
          branch: codetale_comments
          outputRepository: https://github.com/other/repository
```

# Contact us

Your feedback is highly appreciated and will help us to improve CodeTale.
Please send your questions and suggestions to [codetale@virtuslab.com](mailto:codetale@virtuslab.com).
