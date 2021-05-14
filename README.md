# CodeTale
## Tap into existing knowledge sources

Different companies and teams are using various tools for collaboration and knowledge sharing.
But is there any common one between them, a source which would always be available and, at the same time, is information-rich?
It turns out there is: source control management system.
Nowadays most the teams are using some form of pull request workflow to ensure proper code review and code quality.
From those reviews, we can extract many useful comments and discussions, giving us great insight and additional context for the code.
We just need to process them and find a way to make them much easier to explore.
![1.gif](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/1.gif)

## Documentation living with the code
If we want documentation to be very accessible for every developer, we should provide it as part of the environment they are working in, usually it means some kind of editor or IDE.
We know different people have different preferences and requirements, so CodeTale is going to support multiple tools.
Currently, that means Visual Studio Code, and the whole family of IntelliJ based products, but we are not going to limit ourselves to that.

In those IDEs, we provide an effortless way to find and explore comments and discussions relevant to the viewed code.
Thanks to that developer is always aware of past problems and considerations connected to the code in question.
Furthermore, the implemented system intelligently links comments and discussions with the existing code regardless of new commits, branch changes, or changes in the code.
Because of that developer does not have to track changes through history manually, but is always able to find the relevant part of the information immediately.

![2.gif](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/2.gif)

## Discuss the code with your colleagues online

Exploring potential locked in all the code reviews is great, but sometimes new problems and questions arise which might not have been addressed yet.
In such situations, we want to give developers an option to ask new questions and commenting on existing code with valuable insights.
CodeTale will automatically suggest people who are probably best suited to answer the question and notify about the one that which might concern them.
To view and answer it, developers won’t need to leave their IDE — they can use all the benefits IDE gives them (like code navigation or history preview) to fully understand the question and answer it in the best possible way.

Furthermore, discussions like that, regarding general issues, could be later explored by other developers, so knowledge is not lost and does not have to be rediscovered later.

# Table of Contents

- [Installing and configuring the extension](#installing-and-configuring-the-extension)
    - [Installation](#installation)
    - [Configuration](#configuration)
- [How to use](#how-to-use)
    - [Browsing discussions](#browsing-discussions)
    - [Writing a comment](#writing-a-comment)
    - [Creating a new discussion](#creating-a-new-discussion)
- [Integration with a VCS platform](#integration-with-a-vcs-platform)
    - [Exporting discussions from an existing project](#exporting-discussions-from-an-existing-project)
        - [Using a jar](#using-a-jar)
        - [Examples](#examples)
            - [To store comments in the same repository as the source, but in the different branch](#to-store-comments-in-the-same-repository-as-the-source-but-in-the-different-branch)
            - [To store comments in a different repository than the source](#to-store-comments-in-a-different-repository-than-the-source)
            - [Comments in different from source repo, on different server](#comments-in-different-from-source-repository-on-different-server)
            - [Convert PR from specified range](#convert-pr-from-specified-range)
    - [Setting up CI](#setting-up-ci)
        - [Gitlab CI](#gitlab-ci)
        - [Setup GitHub Actions](#setup-github-actions)
            - [Using Maven package](#using-maven-package)
            - [Using an image](#using-an-image)
- [Contact us](#contact-us)

# Installing and configuring the extension
## Installation

Make sure the project you intend to use CodeTale with has `.git` directory at its root. If you install CodeTale with Visual Studio Code, you will need to have Java installed, in version 8 or higher. Install the extension using your IDE's Marketplace or from a file.

⚠ CodeTale is in an early access phase. Before you can start using it, the extension will ask you to provide a passphrase to unlock further access. Contact us at [codetale@virtuslab.com](mailto:codetale@virtuslab.com) for more information.

## Configuration

At its core CodeTale uses a git repository to host discussions displayed by your code. This could be the same repository you use for versioning your code, or it can a separate repository on the same platform (GitHub, GitLab, BitBucket Cloud or BitBucket Enterprise).
The first time you open a new project, you will be asked to provide information about this repository (see below for details).
You can access and change these setting later by clicking the gear icon on the bottom of the CodeTale panel.

To keep discussions in the same repository as your code, simply create a new branch in your repository and push it to the remote server.
If you choose to host them externally, create a new repository on the same platform as your code repository.
To populate the repository with discussions from pull-requests in your project, refer to Exporting comments from an existing project section below.

![settings](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/settings.png)

**Plugin**

Use these setting to configure how CodeTale looks and behaves.

<table>
  <tr>
    <td>CodeTale</td>
    <td>Turn the plugin on or off</td>
  </tr>
  <tr>
    <td>Gutter icon</td>
    <td>Turn discussions icons on or off</td>
  </tr>
</table>

**Comments repository**

The repository you want CodeTale to read discussions from.

<table>
  <tr>
    <td>Provider</td>
    <td>Platform hosting your discussions</td>
  </tr>
  <tr>
    <td>Host URL</td>
    <td>URL of the Git provider</td>
  </tr>
  <tr>
    <td>Repository owner</td>
    <td>Owner of the discussions repository</td>
  </tr>
  <tr>
    <td>Repository name</td>
    <td>Name of the discussions repository</td>
  </tr>
  <tr>
    <td>Branch</td>
    <td>Branch in the discussions repository to be used</td>
  </tr>
</table>

For example, if you keep your code in repository at the `https://github.com/foo/bar` and you want to keep the discussions in the same repository as your code, in a new branch you named `codetale_comments` then your settings would be:
* Provider - `GitHub`
* Host URL - `https://github.com`
* Repository owner - `foo`
* Repository name - `bar`
* Branch - `codetale_comments`

**Code repository**

The repository you keep your code in.

<table>
  <tr>
    <td>Repository owner</td>
    <td>Owner of the code repository</td>
  </tr>
  <tr>
    <td>Repository name</td>
    <td>Name of the code repository</td>
  </tr>
</table>

# How to use

In IntelliJ IDEA look for "CodeTale" tab in Tool Windows Bar on the right and click it to open the CodeTale panel.

![intellij](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/intellij.png)

In Visual Studio Code you will find it in the bottom right, or you can click the CodeTale logo on the sidepanel on the left to display a button, which will open the extension panel.

![vsc](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/vscode.png)

## Browsing discussions

The extension panel displays comments for the file in focus, following your position in the file.
Only the first comment in the discussion is displayed, when inactive.
Click the cloud button to expand the responses to that discussion, or the  "Reply" button to write your own response.
When you bring a discussion into focus, the corresponding lines of code to  which the discussion refers to will be highlighted.

![browse](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/browse.png)

## Writing a comment

Clicking the "Reply" button brings up an editor field. Tag other developers and use markup, code blocks and emojis to craft your reply and once you are ready click "Submit" to send the comment.

![reply](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/reply.png)

## Creating a new discussion

Whenever you select a snippet of text or code, a cloud button will appear in the bottom left corner of the CodeTale panel. Click it to start a new discussion. Like with a comment, write your question or insight about the code in the editor field and click "Submit" to confirm.

![discussion](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/discussion1.png)
![discussion](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/discussion2.png)

# Integration with a VCS platform
## Exporting discussions from an existing project

To take full advantage of CodeTale's capabilities and view the discussions of the past pull-requests, you will need to export these discussions from the platform of your choice to the branch you chose to host the CodeTale data (see [Configuration](#configuration)). That will bring valuable insight into your usual interaction with your project's codebase.

![pr](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/pr1.png)
![pr](https://raw.githubusercontent.com/VirtusLab/codetale/master/imgs/pr2.png)

To export the discussions from GitHub, GitLab, Bitbucket Cloud or Bitbucket Enterprise you can use CodeTale Converter available for download as a Maven package, or a Docker image.

### Using a jar
```bash
mvn dependency:get -Dartifact=codetale:converter:0.1 -DremoteRepositories=https://gitlab.com/api/v4/projects/26458326/packages/maven
cp ~/.m2/repository/codetale/converter/0.1/converter-0.1.jar .
java -jar converter-0.1.jar [options] inputRepositoryProvider inputRepositoryAddress [outputRepositoryAddress]
```

After running converter local copy of comments would be in `~/.codetale/OUTPUT_REPO_PROVIDER/OUTPUT_REPO_OWNER/REPO_NAME/BRANCH_NAME` i.e.
`~/.codetale/github/yourNick/yourRepo/main`.  
What is important- options must be before trailing arguments.    
Help is printed if incorrect arguments order or number are given. To invoke help directly add option `-h` or `--help`.
### Examples
#### To store comments in the same repository as the source, but in the different branch
```bash
java -jar converter-0.1.jar -t GithubPersonalAccessToken -b codetale_comments github https://github.com/username/repository
```
Important: branch must exist in remote repository before this command is run.
#### To store comments in a different repository than the source
```bash
java -jar converter-0.1.jar -t GithubPersonalAccessToken github https://github.com/username/repository https://github.com/username/repoForComments
```
To specify other branch, please add option -b <branch_name> as in the first example.
#### Comments in a different repository, on a different server
Case when source repository is i.e. on `github.com` and you want to store comments in `gitlab.com`.
```bash
java -jar converter-0.1.jar -i GithubPersonalAccessToken -o GitlabPersonalAccessToken github https://github.com/username/repository https://gitlab.com/username/repoForComments
```
#### Convert PR from a specified range
For converting comments from a specified number range.
Default values for `startPRNumber` (`-s`) is 0 and for `endPRnumber` (`-e`) is number of latest `issue`/`pull request` in repository - also not closed yet.
```bash
java -jar converter-0.1.jar -t GithubPersonalAccessToken -b comments -s 9 -e 19 github https://github.com/username/repository
```

## Setting up CI

For continuous integration of discussions in pull-requests from your VCS platform into CodeTale, you can set up a CI workflow for committing the discussions, once a PR is closed and merged.
This will require generating an access token for the CI runner to commit the discussions into the repository hosting CodeTale data.

Below are attached examples for GitHub Actions and Gitlab CI. General rules of filling that scripts:
- set `SOURCE_REPOSITORY_ADDRESS` to address of source repository in format like: `https://github.com/user/repo_name`
- if you store comments in source repository - set `BRANCH_FOR_COMMENTS` to name of that branch. Create and empty it before.
- if you want to store comments in external repository set `DESTINY_REPOSITORY_ADDRESS` and `BRANCH_FOR_COMMENTS` to address
  of that repository in format like above and branch for comments in that repository, respectively.

### Gitlab CI
Authorization:
- if the same provider hosts your destiny repo, you need to generate a
  [Personal Access Token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
  with full `repo` and `api` scope and add it as [variable](https://docs.gitlab.com/ee/ci/variables/#create-a-custom-variable-in-the-ui).
  After that, please swap `GITLAB_PAT` to name of your variable.
- if your destiny repository is hosted by different provider- you need to generate token for each repository. Instructions for
  [github](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token),
  [gitlab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
  and [bitbucket](https://confluence.atlassian.com/bitbucketserver/personal-access-tokens-939515499.html).
  Tokens for source repository should have `repo` and `api` (if present) scopes, for output `repo` scope is sufficient.
  Once you have them, please add them as [variables](https://docs.gitlab.com/ee/ci/variables/#create-a-custom-variable-in-the-ui).
  After that instead `-t` option in the script below, you need to use `-i` for token for input repository and `-o` for output repository.
  So last line should look like
  `run: java -jar converter-0.1.jar -i $GITLAB_PAT -o $OTHER_PROVIDER_PAT -b BRANCH_FOR_COMMENTS ...`

Example:

```yaml
image: "openkbs/jre-mvn-py3:latest"

cache:
  paths:
    - converter-0.1.jar

convert_comments:
  stage: deploy
  only:
  script:
    - export URL="$CI_API_V4_URL/projects/$CI_PROJECT_ID/repository/commits/$CI_COMMIT_SHA"
    - "export MR_NUMBER='python3 merge_request_number_getter.py $GITLAB_PAT $URL'"
    - "[ ! -f \"converter-0.1.jar\" ] &&
         mvn dependency:get -Dartifact=codetale:converter:0.1 -DremoteRepositories=https://gitlab.com/api/v4/projects/26458326/packages/maven &&
         cp ~/.m2/repository/codetale/converter/0.1/converter-0.1.jar . \n
         echo \"Done\""
    - java -jar converter-0.1.jar -t $GITLAB_PAT -b BRANCH_FOR_COMMENTS -s $PR_NUMBER -e $PR_NUMBER github SOURCE_REPOSITORY_ADDRESS DESTINY_REPOSITORY_ADDRESS_OPTIONAL
```

### Setup GitHub Actions
Authorization:
- if your destiny repository is hosted by the same provider, you need to generate
  [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
  with full `repo` scope and add it as [secret variable](https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets).
  After that, please swap `GITHUB_TOKEN` to name of your variable.
- if your destiny repository is hosted by different provider- you need to generate token for each repository. Instructions for
  [github](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token),
  [gitlab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
  and [bitbucket](https://confluence.atlassian.com/bitbucketserver/personal-access-tokens-939515499.html).
  Tokens for should have `repo` scope.
  Once you have them, please add them as [secret variables](https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets).
  After that instead `-t` option in script below, you need to use `-i` for token for input repository and `-o` for output repository.
  So last line should include
  `-i ${{ secrets.INPUT_REPO_TOKEN_VARIABLE }} -o ${{ secrets.OUTPUT_REPO_TOKEN_VARIABLE }} -b BRANCH_FOR_COMMENTS ...`

#### Using Maven package

Paste and fill below yaml file to file in `.github/workflows` folder in your repository.
Most of the script is ready, please pay attention to the last command.


```yaml
name: CodeTale comments convertion

on:
  pull_request:
    types: [closed]

jobs:
  convert:
    if: github.event.pull_request.merged == true

    runs-on: ubuntu-latest

    steps:
      - name: Set up JDK 11
        uses: actions/setup-java@v1
        with:
          java-version: '11.0.6'
      - name: Cache converter files
        uses: actions/cache@v2
        with:
          path: converter-0.1.jar
          key: ${{ runner.os }}-gradle-0.1-${{ hashFiles('**/*.gradle') }}
          restore-keys: ${{ runner.os }}-gradle-0.1
      - name: Download codetale if needed
        run: "[ ! -f \"converter-0.1.jar\" ] &&
              mvn dependency:get -Dartifact=codetale:converter:0.1 -DremoteRepositories=https://gitlab.com/api/v4/projects/26458326/packages/maven &&
              cp ~/.m2/repository/codetale/converter/0.1/converter-0.1.jar . \n
              echo \"Done\""
      - name: Get PR number
        run: echo "::set-env name=PR_NUMBER::${{ github.event.number }}"
      - name: Run converter
        run: java -jar converter-0.1.jar -t ${{ secrets.GITHUB_TOKEN }} -b BRANCH_FOR_COMMENTS -s ${{ github.event.number }} -e ${{ github.event.number }} github SOURCE_REPOSITORY_ADDRESS DESTINY_REPOSITORY_ADDRESS_OPTIONAL
```

#### Using an image

Paste and fill below yaml file to file in `.github/workflows` folder in your repository.
Most of the script is ready, please pay attention to the last command.


```yaml
name: CodeTale comments convertion

on:
  pull_request:
    types: [closed]

jobs:
  convert:
    if: github.event.pull_request.merged == true

    runs-on: ubuntu-latest

    steps:
      - name: Run converter
        uses: docker://registry.gitlab.com/codetaleintegration/codetale-converter:0.1
        with:
          args: -t ${{ secrets.GITHUB_TOKEN }} -b BRANCH_FOR_COMMENTS -s ${{ github.event.number }} -e ${{ github.event.number }} github SOURCE_REPOSITORY_ADDRESS DESTINY_REPOSITORY_ADDRESS_OPTIONAL
```

# Contact us

Your feedback is highly appreciated and will help us to improve CodeTale.
Please send your questions and suggestions to [codetale@virtuslab.com](mailto:codetale@virtuslab.com).