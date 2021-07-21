> The `github` context contains information about the workflow run and the event that triggered the run. 

Reference: [`github` context](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#github-context)

I was wondering how the value of the 'github' context changes depending on events, repositories, and branches when running a workflow. :wink:

I think the followings are useful properties:
- `github` (object type)
- `github.event` (object type)
- `github.actor` (string type)
- `github.event_name` (string type)
- `github.ref` (string type)
- `github.head_ref` (string type)
- `github.base_ref` (string type)

The values for each event are as follows.

| Cases | `github.actor` | `github.event_name` |    `github.ref`   | `github.head_ref` | `github.base_ref` |
|:-----:|:--------------:|:-------------------:|:-----------------:|:-----------------:|:-----------------:|
|   1   |   hermitkim1   |         push        |  refs/heads/test  |                   |                   |
|   2   |   hermitkim1   |     pull_request    | refs/pull/2/merge |        test       |        main       |
|   3   |   hermitkim1   | pull_request_target |  refs/heads/main  |        test       |        main       |
|   4   |   hermitkim1   |         push        |  refs/heads/main  |                   |                   |
|   5   |   hermitkim1   |        gollum       |  refs/heads/main  |                   |                   |

NOTE 1 - Cases:
- [Case 1: on `push` to the upstream `feature` branch from the upstream `feature` branch](https://github.com/cloud-barista/cb-coffeehouse/wiki/The-github-context-output-by-cases-for-GitHub-Actions-workflows#case-1-on-push-to-the-upstream-feature-branch-from-the-upstream-feature-branch)
- [Case 2: on `pull_request` to the upstream `main` branch from the upstream `feature` branch](https://github.com/cloud-barista/cb-coffeehouse/wiki/The-github-context-output-by-cases-for-GitHub-Actions-workflows#case-2-on-pull_request-to-the-upstream-main-branch-from-the-upstream-feature-branch)
- [Case 3: on `pull_request_target` to the upstream `main` branch from the upstream `feature` branch](https://github.com/cloud-barista/cb-coffeehouse/wiki/The-github-context-output-by-cases-for-GitHub-Actions-workflows#case-3-on-pull_request_target-to-the-upstream-main-branch-from-the-upstream-feature-branch)
- [Case 4: on `push` by merging to the upstream `main` branch from the upstream `main` branch](https://github.com/cloud-barista/cb-coffeehouse/wiki/The-github-context-output-by-cases-for-GitHub-Actions-workflows#case-4-on-push-by-merging-to-the-upstream-main-branch-from-the-upstream-main-branch)
- [Case 5: on `push` to the upstream `wiki` of `main` from the upstream `wiki` of `main`](https://github.com/cloud-barista/cb-coffeehouse/wiki/The-github-context-output-by-cases-for-GitHub-Actions-workflows#case-5-on-push-to-the-upstream-wiki-of-main-from-the-upstream-wiki-of-main)


Further tests would be needed for the objects types (i.g., `github`, `github.event`) because I could use `github.event.pull_request.author_association`.

**NOTE 2 - The workflow awaiting approval: First-time contributors need a maintainer to approve running workflows.**

With the help of <ins>[ppiyakk2](https://github.com/ppiyakk2), [junhyunk](https://github.com/junhyunk), and [jaeyoung0826](https://github.com/jaeyoung0826)</ins> 👍 , I got the result below.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/125393649-5058a480-e3e3-11eb-966d-384c3a8ea5fd.png" width="65%" height="65%">
</p>

### The `github` context output by cases

A workflow for this test: [show-context.yaml](https://github.com/hermitkim1/test-on-github-actions/blob/main/.github/workflows/show-context.yaml)


#### Case 1: on `push` to the upstream `feature` branch from the upstream `feature` branch
```
github: Object
toJSON(github):
{
  "token": "***",
  "job": "show-context",
  "ref": "refs/heads/test",
  "sha": "43473b4baa8c7550dc589721b30cf80b153bf11a",
  "repository": "hermitkim1/test-on-github-actions",
  "repository_owner": "hermitkim1",
  "repositoryUrl": "git://github.com/hermitkim1/test-on-github-actions.git",
  "run_id": "1014010533",
  "run_number": "13",
  "retention_days": "90",
  "actor": "hermitkim1",
  "workflow": "Show context",
  "head_ref": "",
  "base_ref": "",
  "event_name": "push",
  "event": {
    "after": "43473b4baa8c7550dc589721b30cf80b153bf11a",
    "base_ref": null,
    "before": "1688ef321da6e402c0602f59b18d916e2d3993e2",
    "commits": [
      {
        "author": {
          "email": "hermitkim1@users.noreply.github.com",
          "name": "Yunkon (Alvin) Kim",
          "username": "hermitkim1"
        },
        "committer": {
          "email": "noreply@github.com",
          "name": "GitHub",
          "username": "web-flow"
        },
        "distinct": true,
        "id": "43473b4baa8c7550dc589721b30cf80b153bf11a",
        "message": "Update README.md",
        "timestamp": "2021-07-09T13:46:29+09:00",
        "tree_id": "c46ff5b06f11c20d53b67fc704da2dbd6e793f72",
        "url": "https://github.com/hermitkim1/test-on-github-actions/commit/43473b4baa8c7550dc589721b30cf80b153bf11a"
      }
    ],
    "compare": "https://github.com/hermitkim1/test-on-github-actions/compare/1688ef321da6...43473b4baa8c",
    "created": false,
    "deleted": false,
    "forced": false,
    "head_commit": {
      "author": {
        "email": "hermitkim1@users.noreply.github.com",
        "name": "Yunkon (Alvin) Kim",
        "username": "hermitkim1"
      },
      "committer": {
        "email": "noreply@github.com",
        "name": "GitHub",
        "username": "web-flow"
      },
      "distinct": true,
      "id": "43473b4baa8c7550dc589721b30cf80b153bf11a",
      "message": "Update README.md",
      "timestamp": "2021-07-09T13:46:29+09:00",
      "tree_id": "c46ff5b06f11c20d53b67fc704da2dbd6e793f72",
      "url": "https://github.com/hermitkim1/test-on-github-actions/commit/43473b4baa8c7550dc589721b30cf80b153bf11a"
    },
    "pusher": {
      "email": "hermitkim1@users.noreply.github.com",
      "name": "hermitkim1"
    },
    "ref": "refs/heads/test",
    "repository": {
      "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
      "archived": false,
      "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
      "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
      "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
      "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
      "created_at": 1625665295,
      "default_branch": "main",
      "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
      "description": null,
      "disabled": false,
      "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
      "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
      "fork": false,
      "forks": 0,
      "forks_count": 0,
      "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
      "full_name": "hermitkim1/test-on-github-actions",
      "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
      "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
      "has_downloads": true,
      "has_issues": true,
      "has_pages": false,
      "has_projects": true,
      "has_wiki": true,
      "homepage": null,
      "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
      "html_url": "https://github.com/hermitkim1/test-on-github-actions",
      "id": 383811959,
      "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
      "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
      "language": null,
      "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
      "license": null,
      "master_branch": "main",
      "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
      "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
      "mirror_url": null,
      "name": "test-on-github-actions",
      "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
      "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
      "open_issues": 0,
      "open_issues_count": 0,
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "email": "hermitkim1@users.noreply.github.com",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "name": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      },
      "private": false,
      "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
      "pushed_at": 1625805989,
      "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
      "size": 83,
      "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
      "stargazers": 0,
      "stargazers_count": 0,
      "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
      "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
      "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
      "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
      "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
      "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
      "updated_at": "2021-07-09T04:44:02Z",
      "url": "https://github.com/hermitkim1/test-on-github-actions",
      "watchers": 0,
      "watchers_count": 0
    },
    "sender": {
      "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
      "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
      "followers_url": "https://api.github.com/users/hermitkim1/followers",
      "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
      "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
      "gravatar_id": "",
      "html_url": "https://github.com/hermitkim1",
      "id": 7975459,
      "login": "hermitkim1",
      "node_id": "MDQ6VXNlcjc5NzU0NTk=",
      "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
      "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
      "repos_url": "https://api.github.com/users/hermitkim1/repos",
      "site_admin": false,
      "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
      "type": "User",
      "url": "https://api.github.com/users/hermitkim1"
    }
  },
  "server_url": "https://github.com",
  "api_url": "https://api.github.com",
  "graphql_url": "https://api.github.com/graphql",
  "workspace": "/home/runner/work/test-on-github-actions/test-on-github-actions",
  "action": "__run",
  "event_path": "/home/runner/work/_temp/_github_workflow/event.json",
  "action_repository": "",
  "action_ref": "",
  "path": "/home/runner/work/_temp/_runner_file_commands/add_path_c27e3189-668a-449a-b6fc-429ed8eb73b9",
  "env": "/home/runner/work/_temp/_runner_file_commands/set_env_c27e3189-668a-449a-b6fc-429ed8eb73b9"
}
github.action: __run
github.action_path: 
github.actor: hermitkim1
github.base_ref: 
github.event: Object
github.event_name: push
github.event_path: /home/runner/work/_temp/_github_workflow/event.json
github.head_ref: 
github.job: show-context
github.ref: refs/heads/test
github.repository: hermitkim1/test-on-github-actions
github.repository_owner: hermitkim1
github.run_id: 1014010533
github.run_number: 13
github.sha: 43473b4baa8c7550dc589721b30cf80b153bf11a
github.token: ***
github.workflow: Show context
github.workspace: /home/runner/work/test-on-github-actions/test-on-github-actions
```

#### Case 2: on `pull_request` to the upstream `main` branch from the upstream `feature` branch
```
github: Object
toJSON(github):
{
  "token": "***",
  "job": "show-context",
  "ref": "refs/pull/2/merge",
  "sha": "023d04c1531c18390ff9ddb577366207bddbbd17",
  "repository": "hermitkim1/test-on-github-actions",
  "repository_owner": "hermitkim1",
  "repositoryUrl": "git://github.com/hermitkim1/test-on-github-actions.git",
  "run_id": "1014048828",
  "run_number": "15",
  "retention_days": "90",
  "actor": "hermitkim1",
  "workflow": "Show context",
  "head_ref": "test",
  "base_ref": "main",
  "event_name": "pull_request",
  "event": {
    "action": "opened",
    "number": 2,
    "pull_request": {
      "_links": {
        "comments": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2/comments"
        },
        "commits": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/commits"
        },
        "html": {
          "href": "https://github.com/hermitkim1/test-on-github-actions/pull/2"
        },
        "issue": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2"
        },
        "review_comment": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/comments{/number}"
        },
        "review_comments": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/comments"
        },
        "self": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2"
        },
        "statuses": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/43473b4baa8c7550dc589721b30cf80b153bf11a"
        }
      },
      "active_lock_reason": null,
      "additions": 2,
      "assignee": null,
      "assignees": [],
      "author_association": "OWNER",
      "auto_merge": null,
      "base": {
        "label": "hermitkim1:main",
        "ref": "main",
        "repo": {
          "allow_merge_commit": true,
          "allow_rebase_merge": true,
          "allow_squash_merge": true,
          "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
          "archived": false,
          "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
          "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
          "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
          "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
          "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
          "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
          "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
          "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
          "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
          "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
          "created_at": "2021-07-07T13:41:35Z",
          "default_branch": "main",
          "delete_branch_on_merge": false,
          "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
          "description": null,
          "disabled": false,
          "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
          "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
          "fork": false,
          "forks": 0,
          "forks_count": 0,
          "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
          "full_name": "hermitkim1/test-on-github-actions",
          "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
          "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
          "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
          "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
          "has_downloads": true,
          "has_issues": true,
          "has_pages": false,
          "has_projects": true,
          "has_wiki": true,
          "homepage": null,
          "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
          "html_url": "https://github.com/hermitkim1/test-on-github-actions",
          "id": 383811959,
          "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
          "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
          "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
          "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
          "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
          "language": null,
          "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
          "license": null,
          "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
          "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
          "mirror_url": null,
          "name": "test-on-github-actions",
          "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
          "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
          "open_issues": 1,
          "open_issues_count": 1,
          "owner": {
            "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
            "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
            "followers_url": "https://api.github.com/users/hermitkim1/followers",
            "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
            "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
            "gravatar_id": "",
            "html_url": "https://github.com/hermitkim1",
            "id": 7975459,
            "login": "hermitkim1",
            "node_id": "MDQ6VXNlcjc5NzU0NTk=",
            "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
            "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
            "repos_url": "https://api.github.com/users/hermitkim1/repos",
            "site_admin": false,
            "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
            "type": "User",
            "url": "https://api.github.com/users/hermitkim1"
          },
          "private": false,
          "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
          "pushed_at": "2021-07-09T04:57:24Z",
          "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
          "size": 83,
          "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
          "stargazers_count": 0,
          "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
          "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
          "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
          "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
          "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
          "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
          "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
          "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
          "updated_at": "2021-07-09T04:57:26Z",
          "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
          "watchers": 0,
          "watchers_count": 0
        },
        "sha": "15306570b56586a91acaaa9228c9ea859a1527c1",
        "user": {
          "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
          "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
          "followers_url": "https://api.github.com/users/hermitkim1/followers",
          "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
          "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
          "gravatar_id": "",
          "html_url": "https://github.com/hermitkim1",
          "id": 7975459,
          "login": "hermitkim1",
          "node_id": "MDQ6VXNlcjc5NzU0NTk=",
          "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
          "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
          "repos_url": "https://api.github.com/users/hermitkim1/repos",
          "site_admin": false,
          "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
          "type": "User",
          "url": "https://api.github.com/users/hermitkim1"
        }
      },
      "body": "aaaa",
      "changed_files": 1,
      "closed_at": null,
      "comments": 0,
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2/comments",
      "commits": 1,
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/commits",
      "created_at": "2021-07-09T05:04:54Z",
      "deletions": 0,
      "diff_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2.diff",
      "draft": false,
      "head": {
        "label": "hermitkim1:test",
        "ref": "test",
        "repo": {
          "allow_merge_commit": true,
          "allow_rebase_merge": true,
          "allow_squash_merge": true,
          "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
          "archived": false,
          "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
          "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
          "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
          "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
          "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
          "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
          "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
          "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
          "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
          "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
          "created_at": "2021-07-07T13:41:35Z",
          "default_branch": "main",
          "delete_branch_on_merge": false,
          "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
          "description": null,
          "disabled": false,
          "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
          "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
          "fork": false,
          "forks": 0,
          "forks_count": 0,
          "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
          "full_name": "hermitkim1/test-on-github-actions",
          "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
          "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
          "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
          "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
          "has_downloads": true,
          "has_issues": true,
          "has_pages": false,
          "has_projects": true,
          "has_wiki": true,
          "homepage": null,
          "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
          "html_url": "https://github.com/hermitkim1/test-on-github-actions",
          "id": 383811959,
          "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
          "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
          "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
          "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
          "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
          "language": null,
          "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
          "license": null,
          "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
          "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
          "mirror_url": null,
          "name": "test-on-github-actions",
          "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
          "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
          "open_issues": 1,
          "open_issues_count": 1,
          "owner": {
            "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
            "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
            "followers_url": "https://api.github.com/users/hermitkim1/followers",
            "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
            "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
            "gravatar_id": "",
            "html_url": "https://github.com/hermitkim1",
            "id": 7975459,
            "login": "hermitkim1",
            "node_id": "MDQ6VXNlcjc5NzU0NTk=",
            "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
            "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
            "repos_url": "https://api.github.com/users/hermitkim1/repos",
            "site_admin": false,
            "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
            "type": "User",
            "url": "https://api.github.com/users/hermitkim1"
          },
          "private": false,
          "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
          "pushed_at": "2021-07-09T04:57:24Z",
          "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
          "size": 83,
          "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
          "stargazers_count": 0,
          "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
          "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
          "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
          "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
          "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
          "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
          "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
          "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
          "updated_at": "2021-07-09T04:57:26Z",
          "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
          "watchers": 0,
          "watchers_count": 0
        },
        "sha": "43473b4baa8c7550dc589721b30cf80b153bf11a",
        "user": {
          "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
          "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
          "followers_url": "https://api.github.com/users/hermitkim1/followers",
          "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
          "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
          "gravatar_id": "",
          "html_url": "https://github.com/hermitkim1",
          "id": 7975459,
          "login": "hermitkim1",
          "node_id": "MDQ6VXNlcjc5NzU0NTk=",
          "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
          "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
          "repos_url": "https://api.github.com/users/hermitkim1/repos",
          "site_admin": false,
          "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
          "type": "User",
          "url": "https://api.github.com/users/hermitkim1"
        }
      },
      "html_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2",
      "id": 686494060,
      "issue_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2",
      "labels": [],
      "locked": false,
      "maintainer_can_modify": false,
      "merge_commit_sha": null,
      "mergeable": null,
      "mergeable_state": "unknown",
      "merged": false,
      "merged_at": null,
      "merged_by": null,
      "milestone": null,
      "node_id": "MDExOlB1bGxSZXF1ZXN0Njg2NDk0MDYw",
      "number": 2,
      "patch_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2.patch",
      "rebaseable": null,
      "requested_reviewers": [],
      "requested_teams": [],
      "review_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/comments{/number}",
      "review_comments": 0,
      "review_comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/comments",
      "state": "open",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/43473b4baa8c7550dc589721b30cf80b153bf11a",
      "title": "Update README.md",
      "updated_at": "2021-07-09T05:04:54Z",
      "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2",
      "user": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      }
    },
    "repository": {
      "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
      "archived": false,
      "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
      "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
      "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
      "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
      "created_at": "2021-07-07T13:41:35Z",
      "default_branch": "main",
      "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
      "description": null,
      "disabled": false,
      "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
      "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
      "fork": false,
      "forks": 0,
      "forks_count": 0,
      "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
      "full_name": "hermitkim1/test-on-github-actions",
      "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
      "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
      "has_downloads": true,
      "has_issues": true,
      "has_pages": false,
      "has_projects": true,
      "has_wiki": true,
      "homepage": null,
      "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
      "html_url": "https://github.com/hermitkim1/test-on-github-actions",
      "id": 383811959,
      "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
      "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
      "language": null,
      "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
      "license": null,
      "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
      "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
      "mirror_url": null,
      "name": "test-on-github-actions",
      "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
      "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
      "open_issues": 1,
      "open_issues_count": 1,
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      },
      "private": false,
      "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
      "pushed_at": "2021-07-09T04:57:24Z",
      "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
      "size": 83,
      "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
      "stargazers_count": 0,
      "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
      "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
      "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
      "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
      "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
      "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
      "updated_at": "2021-07-09T04:57:26Z",
      "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
      "watchers": 0,
      "watchers_count": 0
    },
    "sender": {
      "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
      "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
      "followers_url": "https://api.github.com/users/hermitkim1/followers",
      "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
      "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
      "gravatar_id": "",
      "html_url": "https://github.com/hermitkim1",
      "id": 7975459,
      "login": "hermitkim1",
      "node_id": "MDQ6VXNlcjc5NzU0NTk=",
      "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
      "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
      "repos_url": "https://api.github.com/users/hermitkim1/repos",
      "site_admin": false,
      "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
      "type": "User",
      "url": "https://api.github.com/users/hermitkim1"
    }
  },
  "server_url": "https://github.com",
  "api_url": "https://api.github.com",
  "graphql_url": "https://api.github.com/graphql",
  "workspace": "/home/runner/work/test-on-github-actions/test-on-github-actions",
  "action": "__run",
  "event_path": "/home/runner/work/_temp/_github_workflow/event.json",
  "action_repository": "",
  "action_ref": "",
  "path": "/home/runner/work/_temp/_runner_file_commands/add_path_e48f0438-cfe0-47e0-a39c-d96860e440fa",
  "env": "/home/runner/work/_temp/_runner_file_commands/set_env_e48f0438-cfe0-47e0-a39c-d96860e440fa"
}
github.action: __run
github.action_path: 
github.actor: hermitkim1
github.base_ref: main
github.event: Object
github.event_name: pull_request
github.event_path: /home/runner/work/_temp/_github_workflow/event.json
github.head_ref: test
github.job: show-context
github.ref: refs/pull/2/merge
github.repository: hermitkim1/test-on-github-actions
github.repository_owner: hermitkim1
github.run_id: 1014048828
github.run_number: 15
github.sha: 023d04c1531c18390ff9ddb577366207bddbbd17
github.token: ***
github.workflow: Show context
github.workspace: /home/runner/work/test-on-github-actions/test-on-github-actions
```

#### Case 3: on `pull_request_target` to the upstream `main` branch from the upstream `feature` branch
```
github: Object
toJSON(github):
{
  "token": "***",
  "job": "show-context",
  "ref": "refs/heads/main",
  "sha": "15306570b56586a91acaaa9228c9ea859a1527c1",
  "repository": "hermitkim1/test-on-github-actions",
  "repository_owner": "hermitkim1",
  "repositoryUrl": "git://github.com/hermitkim1/test-on-github-actions.git",
  "run_id": "1014048811",
  "run_number": "14",
  "retention_days": "90",
  "actor": "hermitkim1",
  "workflow": "Show context",
  "head_ref": "test",
  "base_ref": "main",
  "event_name": "pull_request_target",
  "event": {
    "action": "opened",
    "number": 2,
    "pull_request": {
      "_links": {
        "comments": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2/comments"
        },
        "commits": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/commits"
        },
        "html": {
          "href": "https://github.com/hermitkim1/test-on-github-actions/pull/2"
        },
        "issue": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2"
        },
        "review_comment": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/comments{/number}"
        },
        "review_comments": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/comments"
        },
        "self": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2"
        },
        "statuses": {
          "href": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/43473b4baa8c7550dc589721b30cf80b153bf11a"
        }
      },
      "active_lock_reason": null,
      "additions": 2,
      "assignee": null,
      "assignees": [],
      "author_association": "OWNER",
      "auto_merge": null,
      "base": {
        "label": "hermitkim1:main",
        "ref": "main",
        "repo": {
          "allow_merge_commit": true,
          "allow_rebase_merge": true,
          "allow_squash_merge": true,
          "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
          "archived": false,
          "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
          "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
          "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
          "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
          "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
          "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
          "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
          "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
          "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
          "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
          "created_at": "2021-07-07T13:41:35Z",
          "default_branch": "main",
          "delete_branch_on_merge": false,
          "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
          "description": null,
          "disabled": false,
          "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
          "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
          "fork": false,
          "forks": 0,
          "forks_count": 0,
          "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
          "full_name": "hermitkim1/test-on-github-actions",
          "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
          "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
          "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
          "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
          "has_downloads": true,
          "has_issues": true,
          "has_pages": false,
          "has_projects": true,
          "has_wiki": true,
          "homepage": null,
          "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
          "html_url": "https://github.com/hermitkim1/test-on-github-actions",
          "id": 383811959,
          "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
          "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
          "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
          "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
          "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
          "language": null,
          "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
          "license": null,
          "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
          "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
          "mirror_url": null,
          "name": "test-on-github-actions",
          "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
          "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
          "open_issues": 1,
          "open_issues_count": 1,
          "owner": {
            "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
            "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
            "followers_url": "https://api.github.com/users/hermitkim1/followers",
            "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
            "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
            "gravatar_id": "",
            "html_url": "https://github.com/hermitkim1",
            "id": 7975459,
            "login": "hermitkim1",
            "node_id": "MDQ6VXNlcjc5NzU0NTk=",
            "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
            "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
            "repos_url": "https://api.github.com/users/hermitkim1/repos",
            "site_admin": false,
            "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
            "type": "User",
            "url": "https://api.github.com/users/hermitkim1"
          },
          "private": false,
          "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
          "pushed_at": "2021-07-09T04:57:24Z",
          "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
          "size": 83,
          "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
          "stargazers_count": 0,
          "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
          "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
          "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
          "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
          "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
          "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
          "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
          "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
          "updated_at": "2021-07-09T04:57:26Z",
          "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
          "watchers": 0,
          "watchers_count": 0
        },
        "sha": "15306570b56586a91acaaa9228c9ea859a1527c1",
        "user": {
          "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
          "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
          "followers_url": "https://api.github.com/users/hermitkim1/followers",
          "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
          "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
          "gravatar_id": "",
          "html_url": "https://github.com/hermitkim1",
          "id": 7975459,
          "login": "hermitkim1",
          "node_id": "MDQ6VXNlcjc5NzU0NTk=",
          "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
          "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
          "repos_url": "https://api.github.com/users/hermitkim1/repos",
          "site_admin": false,
          "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
          "type": "User",
          "url": "https://api.github.com/users/hermitkim1"
        }
      },
      "body": "aaaa",
      "changed_files": 1,
      "closed_at": null,
      "comments": 0,
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2/comments",
      "commits": 1,
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/commits",
      "created_at": "2021-07-09T05:04:54Z",
      "deletions": 0,
      "diff_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2.diff",
      "draft": false,
      "head": {
        "label": "hermitkim1:test",
        "ref": "test",
        "repo": {
          "allow_merge_commit": true,
          "allow_rebase_merge": true,
          "allow_squash_merge": true,
          "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
          "archived": false,
          "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
          "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
          "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
          "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
          "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
          "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
          "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
          "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
          "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
          "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
          "created_at": "2021-07-07T13:41:35Z",
          "default_branch": "main",
          "delete_branch_on_merge": false,
          "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
          "description": null,
          "disabled": false,
          "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
          "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
          "fork": false,
          "forks": 0,
          "forks_count": 0,
          "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
          "full_name": "hermitkim1/test-on-github-actions",
          "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
          "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
          "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
          "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
          "has_downloads": true,
          "has_issues": true,
          "has_pages": false,
          "has_projects": true,
          "has_wiki": true,
          "homepage": null,
          "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
          "html_url": "https://github.com/hermitkim1/test-on-github-actions",
          "id": 383811959,
          "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
          "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
          "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
          "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
          "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
          "language": null,
          "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
          "license": null,
          "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
          "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
          "mirror_url": null,
          "name": "test-on-github-actions",
          "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
          "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
          "open_issues": 1,
          "open_issues_count": 1,
          "owner": {
            "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
            "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
            "followers_url": "https://api.github.com/users/hermitkim1/followers",
            "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
            "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
            "gravatar_id": "",
            "html_url": "https://github.com/hermitkim1",
            "id": 7975459,
            "login": "hermitkim1",
            "node_id": "MDQ6VXNlcjc5NzU0NTk=",
            "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
            "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
            "repos_url": "https://api.github.com/users/hermitkim1/repos",
            "site_admin": false,
            "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
            "type": "User",
            "url": "https://api.github.com/users/hermitkim1"
          },
          "private": false,
          "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
          "pushed_at": "2021-07-09T04:57:24Z",
          "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
          "size": 83,
          "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
          "stargazers_count": 0,
          "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
          "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
          "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
          "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
          "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
          "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
          "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
          "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
          "updated_at": "2021-07-09T04:57:26Z",
          "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
          "watchers": 0,
          "watchers_count": 0
        },
        "sha": "43473b4baa8c7550dc589721b30cf80b153bf11a",
        "user": {
          "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
          "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
          "followers_url": "https://api.github.com/users/hermitkim1/followers",
          "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
          "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
          "gravatar_id": "",
          "html_url": "https://github.com/hermitkim1",
          "id": 7975459,
          "login": "hermitkim1",
          "node_id": "MDQ6VXNlcjc5NzU0NTk=",
          "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
          "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
          "repos_url": "https://api.github.com/users/hermitkim1/repos",
          "site_admin": false,
          "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
          "type": "User",
          "url": "https://api.github.com/users/hermitkim1"
        }
      },
      "html_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2",
      "id": 686494060,
      "issue_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/2",
      "labels": [],
      "locked": false,
      "maintainer_can_modify": false,
      "merge_commit_sha": null,
      "mergeable": null,
      "mergeable_state": "unknown",
      "merged": false,
      "merged_at": null,
      "merged_by": null,
      "milestone": null,
      "node_id": "MDExOlB1bGxSZXF1ZXN0Njg2NDk0MDYw",
      "number": 2,
      "patch_url": "https://github.com/hermitkim1/test-on-github-actions/pull/2.patch",
      "rebaseable": null,
      "requested_reviewers": [],
      "requested_teams": [],
      "review_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/comments{/number}",
      "review_comments": 0,
      "review_comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2/comments",
      "state": "open",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/43473b4baa8c7550dc589721b30cf80b153bf11a",
      "title": "Update README.md",
      "updated_at": "2021-07-09T05:04:54Z",
      "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls/2",
      "user": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      }
    },
    "repository": {
      "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
      "archived": false,
      "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
      "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
      "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
      "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
      "created_at": "2021-07-07T13:41:35Z",
      "default_branch": "main",
      "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
      "description": null,
      "disabled": false,
      "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
      "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
      "fork": false,
      "forks": 0,
      "forks_count": 0,
      "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
      "full_name": "hermitkim1/test-on-github-actions",
      "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
      "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
      "has_downloads": true,
      "has_issues": true,
      "has_pages": false,
      "has_projects": true,
      "has_wiki": true,
      "homepage": null,
      "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
      "html_url": "https://github.com/hermitkim1/test-on-github-actions",
      "id": 383811959,
      "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
      "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
      "language": null,
      "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
      "license": null,
      "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
      "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
      "mirror_url": null,
      "name": "test-on-github-actions",
      "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
      "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
      "open_issues": 1,
      "open_issues_count": 1,
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      },
      "private": false,
      "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
      "pushed_at": "2021-07-09T04:57:24Z",
      "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
      "size": 83,
      "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
      "stargazers_count": 0,
      "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
      "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
      "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
      "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
      "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
      "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
      "updated_at": "2021-07-09T04:57:26Z",
      "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
      "watchers": 0,
      "watchers_count": 0
    },
    "sender": {
      "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
      "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
      "followers_url": "https://api.github.com/users/hermitkim1/followers",
      "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
      "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
      "gravatar_id": "",
      "html_url": "https://github.com/hermitkim1",
      "id": 7975459,
      "login": "hermitkim1",
      "node_id": "MDQ6VXNlcjc5NzU0NTk=",
      "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
      "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
      "repos_url": "https://api.github.com/users/hermitkim1/repos",
      "site_admin": false,
      "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
      "type": "User",
      "url": "https://api.github.com/users/hermitkim1"
    }
  },
  "server_url": "https://github.com",
  "api_url": "https://api.github.com",
  "graphql_url": "https://api.github.com/graphql",
  "workspace": "/home/runner/work/test-on-github-actions/test-on-github-actions",
  "action": "__run",
  "event_path": "/home/runner/work/_temp/_github_workflow/event.json",
  "action_repository": "",
  "action_ref": "",
  "path": "/home/runner/work/_temp/_runner_file_commands/add_path_6c8eca38-a88f-4790-abaf-4b335e81440d",
  "env": "/home/runner/work/_temp/_runner_file_commands/set_env_6c8eca38-a88f-4790-abaf-4b335e81440d"
}
github.action: __run
github.action_path: 
github.actor: hermitkim1
github.base_ref: main
github.event: Object
github.event_name: pull_request_target
github.event_path: /home/runner/work/_temp/_github_workflow/event.json
github.head_ref: test
github.job: show-context
github.ref: refs/heads/main
github.repository: hermitkim1/test-on-github-actions
github.repository_owner: hermitkim1
github.run_id: 1014048811
github.run_number: 14
github.sha: 15306570b56586a91acaaa9228c9ea859a1527c1
github.token: ***
github.workflow: Show context
github.workspace: /home/runner/work/test-on-github-actions/test-on-github-actions
```

#### Case 4: on `push` by merging to the upstream `main` branch from the upstream `main` branch
```
github: Object
toJSON(github):
{
  "token": "***",
  "job": "show-context",
  "ref": "refs/heads/main",
  "sha": "23a87147b3b886879bec442313169850816c3b43",
  "repository": "hermitkim1/test-on-github-actions",
  "repository_owner": "hermitkim1",
  "repositoryUrl": "git://github.com/hermitkim1/test-on-github-actions.git",
  "run_id": "1014065652",
  "run_number": "16",
  "retention_days": "90",
  "actor": "hermitkim1",
  "workflow": "Show context",
  "head_ref": "",
  "base_ref": "",
  "event_name": "push",
  "event": {
    "after": "23a87147b3b886879bec442313169850816c3b43",
    "base_ref": null,
    "before": "15306570b56586a91acaaa9228c9ea859a1527c1",
    "commits": [
      {
        "author": {
          "email": "hermitkim1@users.noreply.github.com",
          "name": "Yunkon (Alvin) Kim",
          "username": "hermitkim1"
        },
        "committer": {
          "email": "noreply@github.com",
          "name": "GitHub",
          "username": "web-flow"
        },
        "distinct": false,
        "id": "43473b4baa8c7550dc589721b30cf80b153bf11a",
        "message": "Update README.md",
        "timestamp": "2021-07-09T13:46:29+09:00",
        "tree_id": "c46ff5b06f11c20d53b67fc704da2dbd6e793f72",
        "url": "https://github.com/hermitkim1/test-on-github-actions/commit/43473b4baa8c7550dc589721b30cf80b153bf11a"
      },
      {
        "author": {
          "email": "hermitkim1@users.noreply.github.com",
          "name": "Yunkon (Alvin) Kim",
          "username": "hermitkim1"
        },
        "committer": {
          "email": "noreply@github.com",
          "name": "GitHub",
          "username": "web-flow"
        },
        "distinct": true,
        "id": "23a87147b3b886879bec442313169850816c3b43",
        "message": "Merge pull request #2 from hermitkim1/test\n\nUpdate README.md",
        "timestamp": "2021-07-09T14:12:10+09:00",
        "tree_id": "80827d1766981d0377e7daa1e9b16e28ee34f913",
        "url": "https://github.com/hermitkim1/test-on-github-actions/commit/23a87147b3b886879bec442313169850816c3b43"
      }
    ],
    "compare": "https://github.com/hermitkim1/test-on-github-actions/compare/15306570b565...23a87147b3b8",
    "created": false,
    "deleted": false,
    "forced": false,
    "head_commit": {
      "author": {
        "email": "hermitkim1@users.noreply.github.com",
        "name": "Yunkon (Alvin) Kim",
        "username": "hermitkim1"
      },
      "committer": {
        "email": "noreply@github.com",
        "name": "GitHub",
        "username": "web-flow"
      },
      "distinct": true,
      "id": "23a87147b3b886879bec442313169850816c3b43",
      "message": "Merge pull request #2 from hermitkim1/test\n\nUpdate README.md",
      "timestamp": "2021-07-09T14:12:10+09:00",
      "tree_id": "80827d1766981d0377e7daa1e9b16e28ee34f913",
      "url": "https://github.com/hermitkim1/test-on-github-actions/commit/23a87147b3b886879bec442313169850816c3b43"
    },
    "pusher": {
      "email": "hermitkim1@users.noreply.github.com",
      "name": "hermitkim1"
    },
    "ref": "refs/heads/main",
    "repository": {
      "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
      "archived": false,
      "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
      "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
      "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
      "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
      "created_at": 1625665295,
      "default_branch": "main",
      "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
      "description": null,
      "disabled": false,
      "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
      "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
      "fork": false,
      "forks": 0,
      "forks_count": 0,
      "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
      "full_name": "hermitkim1/test-on-github-actions",
      "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
      "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
      "has_downloads": true,
      "has_issues": true,
      "has_pages": false,
      "has_projects": true,
      "has_wiki": true,
      "homepage": null,
      "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
      "html_url": "https://github.com/hermitkim1/test-on-github-actions",
      "id": 383811959,
      "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
      "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
      "language": null,
      "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
      "license": null,
      "master_branch": "main",
      "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
      "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
      "mirror_url": null,
      "name": "test-on-github-actions",
      "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
      "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
      "open_issues": 0,
      "open_issues_count": 0,
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "email": "hermitkim1@users.noreply.github.com",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "name": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      },
      "private": false,
      "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
      "pushed_at": 1625807530,
      "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
      "size": 83,
      "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
      "stargazers": 0,
      "stargazers_count": 0,
      "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
      "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
      "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
      "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
      "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
      "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
      "updated_at": "2021-07-09T04:57:26Z",
      "url": "https://github.com/hermitkim1/test-on-github-actions",
      "watchers": 0,
      "watchers_count": 0
    },
    "sender": {
      "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
      "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
      "followers_url": "https://api.github.com/users/hermitkim1/followers",
      "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
      "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
      "gravatar_id": "",
      "html_url": "https://github.com/hermitkim1",
      "id": 7975459,
      "login": "hermitkim1",
      "node_id": "MDQ6VXNlcjc5NzU0NTk=",
      "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
      "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
      "repos_url": "https://api.github.com/users/hermitkim1/repos",
      "site_admin": false,
      "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
      "type": "User",
      "url": "https://api.github.com/users/hermitkim1"
    }
  },
  "server_url": "https://github.com",
  "api_url": "https://api.github.com",
  "graphql_url": "https://api.github.com/graphql",
  "workspace": "/home/runner/work/test-on-github-actions/test-on-github-actions",
  "action": "__run",
  "event_path": "/home/runner/work/_temp/_github_workflow/event.json",
  "action_repository": "",
  "action_ref": "",
  "path": "/home/runner/work/_temp/_runner_file_commands/add_path_d33d5f75-fa83-4f44-80fa-f9a9da399f75",
  "env": "/home/runner/work/_temp/_runner_file_commands/set_env_d33d5f75-fa83-4f44-80fa-f9a9da399f75"
}
github.action: __run
github.action_path: 
github.actor: hermitkim1
github.base_ref: 
github.event: Object
github.event_name: push
github.event_path: /home/runner/work/_temp/_github_workflow/event.json
github.head_ref: 
github.job: show-context
github.ref: refs/heads/main
github.repository: hermitkim1/test-on-github-actions
github.repository_owner: hermitkim1
github.run_id: 1014065652
github.run_number: 16
github.sha: 23a87147b3b886879bec442313169850816c3b43
github.token: ***
github.workflow: Show context
github.workspace: /home/runner/work/test-on-github-actions/test-on-github-actions
```

#### Case 5: on `push` to the upstream `wiki` of `main` from the upstream `wiki` of `main`
```
github: Object
toJSON(github):
{
  "token": "***",
  "job": "show-context",
  "ref": "refs/heads/main",
  "sha": "c74eca96cf0f736d8692eafbb55221e57446e5ee",
  "repository": "hermitkim1/test-on-github-actions",
  "repository_owner": "hermitkim1",
  "repositoryUrl": "git://github.com/hermitkim1/test-on-github-actions.git",
  "run_id": "1025392058",
  "run_number": "32",
  "retention_days": "90",
  "actor": "hermitkim1",
  "workflow": "Show context",
  "head_ref": "",
  "base_ref": "",
  "event_name": "gollum",
  "event": {
    "pages": [
      {
        "action": "edited",
        "html_url": "https://github.com/hermitkim1/test-on-github-actions/wiki/Home",
        "page_name": "Home",
        "sha": "d762bb8a6927774aab738ed24c11e9d77dc63a13",
        "summary": null,
        "title": "Home"
      }
    ],
    "repository": {
      "archive_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/{archive_format}{/ref}",
      "archived": false,
      "assignees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/assignees{/user}",
      "blobs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/blobs{/sha}",
      "branches_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/branches{/branch}",
      "clone_url": "https://github.com/hermitkim1/test-on-github-actions.git",
      "collaborators_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/collaborators{/collaborator}",
      "comments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/comments{/number}",
      "commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/commits{/sha}",
      "compare_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/compare/{base}...{head}",
      "contents_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contents/{+path}",
      "contributors_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/contributors",
      "created_at": "2021-07-07T13:41:35Z",
      "default_branch": "main",
      "deployments_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/deployments",
      "description": null,
      "disabled": false,
      "downloads_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/downloads",
      "events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/events",
      "fork": false,
      "forks": 2,
      "forks_count": 2,
      "forks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/forks",
      "full_name": "hermitkim1/test-on-github-actions",
      "git_commits_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/commits{/sha}",
      "git_refs_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/refs{/sha}",
      "git_tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/tags{/sha}",
      "git_url": "git://github.com/hermitkim1/test-on-github-actions.git",
      "has_downloads": true,
      "has_issues": true,
      "has_pages": false,
      "has_projects": true,
      "has_wiki": true,
      "homepage": null,
      "hooks_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/hooks",
      "html_url": "https://github.com/hermitkim1/test-on-github-actions",
      "id": 383811959,
      "issue_comment_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/comments{/number}",
      "issue_events_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues/events{/number}",
      "issues_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/issues{/number}",
      "keys_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/keys{/key_id}",
      "labels_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/labels{/name}",
      "language": null,
      "languages_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/languages",
      "license": null,
      "merges_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/merges",
      "milestones_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/milestones{/number}",
      "mirror_url": null,
      "name": "test-on-github-actions",
      "node_id": "MDEwOlJlcG9zaXRvcnkzODM4MTE5NTk=",
      "notifications_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/notifications{?since,all,participating}",
      "open_issues": 0,
      "open_issues_count": 0,
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
        "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
        "followers_url": "https://api.github.com/users/hermitkim1/followers",
        "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
        "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
        "gravatar_id": "",
        "html_url": "https://github.com/hermitkim1",
        "id": 7975459,
        "login": "hermitkim1",
        "node_id": "MDQ6VXNlcjc5NzU0NTk=",
        "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
        "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
        "repos_url": "https://api.github.com/users/hermitkim1/repos",
        "site_admin": false,
        "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
        "type": "User",
        "url": "https://api.github.com/users/hermitkim1"
      },
      "private": false,
      "pulls_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/pulls{/number}",
      "pushed_at": "2021-07-13T05:37:32Z",
      "releases_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/releases{/id}",
      "size": 94,
      "ssh_url": "git@github.com:hermitkim1/test-on-github-actions.git",
      "stargazers_count": 0,
      "stargazers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/stargazers",
      "statuses_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/statuses/{sha}",
      "subscribers_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscribers",
      "subscription_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/subscription",
      "svn_url": "https://github.com/hermitkim1/test-on-github-actions",
      "tags_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/tags",
      "teams_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/teams",
      "trees_url": "https://api.github.com/repos/hermitkim1/test-on-github-actions/git/trees{/sha}",
      "updated_at": "2021-07-13T05:37:35Z",
      "url": "https://api.github.com/repos/hermitkim1/test-on-github-actions",
      "watchers": 0,
      "watchers_count": 0
    },
    "sender": {
      "avatar_url": "https://avatars.githubusercontent.com/u/7975459?v=4",
      "events_url": "https://api.github.com/users/hermitkim1/events{/privacy}",
      "followers_url": "https://api.github.com/users/hermitkim1/followers",
      "following_url": "https://api.github.com/users/hermitkim1/following{/other_user}",
      "gists_url": "https://api.github.com/users/hermitkim1/gists{/gist_id}",
      "gravatar_id": "",
      "html_url": "https://github.com/hermitkim1",
      "id": 7975459,
      "login": "hermitkim1",
      "node_id": "MDQ6VXNlcjc5NzU0NTk=",
      "organizations_url": "https://api.github.com/users/hermitkim1/orgs",
      "received_events_url": "https://api.github.com/users/hermitkim1/received_events",
      "repos_url": "https://api.github.com/users/hermitkim1/repos",
      "site_admin": false,
      "starred_url": "https://api.github.com/users/hermitkim1/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/hermitkim1/subscriptions",
      "type": "User",
      "url": "https://api.github.com/users/hermitkim1"
    }
  },
  "server_url": "https://github.com",
  "api_url": "https://api.github.com",
  "graphql_url": "https://api.github.com/graphql",
  "workspace": "/home/runner/work/test-on-github-actions/test-on-github-actions",
  "action": "__run",
  "event_path": "/home/runner/work/_temp/_github_workflow/event.json",
  "action_repository": "",
  "action_ref": "",
  "path": "/home/runner/work/_temp/_runner_file_commands/add_path_01d82153-d84e-4bb6-9d2f-88ba54d2c955",
  "env": "/home/runner/work/_temp/_runner_file_commands/set_env_01d82153-d84e-4bb6-9d2f-88ba54d2c955"
}
github.action: __run
github.action_path: 
github.actor: hermitkim1
github.base_ref: 
github.event: Object
github.event_name: gollum
github.event_path: /home/runner/work/_temp/_github_workflow/event.json
github.head_ref: 
github.job: show-context
github.ref: refs/heads/main
github.repository: hermitkim1/test-on-github-actions
github.repository_owner: hermitkim1
github.run_id: 1025392058
github.run_number: 32
github.sha: c74eca96cf0f736d8692eafbb55221e57446e5ee
github.token: ***
github.workflow: Show context
github.workspace: /home/runner/work/test-on-github-actions/test-on-github-actions
```