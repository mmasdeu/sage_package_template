#!/bin/bash

echo "Rather than asking for passwords we should get an auth token from github once."
exit 1

Some doc:
To create one:
curl -u '<USER>' -d '{"note": "<UNIQUE_STR>"}' https://api.github.com/authorizations
gets you a unique token (and a unique id) in the resonse if UNIQUE_STR
was not already used.
Otherwise you get a   "message": "Validation Failed", with associated errors.
A way around is to add a fingerprint field:
curl -u '<USER>' -d '{"note": "<UNIQUE_STR>", "fingeprint":"<FINGERPRINT>"}' https://api.github.com/authorizations
You can also list the existing authorizations:
curl -u '<USER>' https://api.github.com/authorizations
To delete a token with a given id:
curl -u '<USER>' -X "DELETE" https://api.github.com/authorizations/<UNIQUE_ID>
(this will avoid further failures).

Different way to then use the token:
https://developer.github.com/v3/#authentication

To get a travis token see:
https://docs.travis-ci.com/api/?http#creating-a-temporary-github-token
and
https://github.com/travis-ci/travis-ci/issues/5649

Get a github token with the following scopes:
curl -u '<USER>' -d '{"note": "travis", "scopes": ["read:org", "user:email", "repo_deployment","repo:status","public_repo", "write:repo_hook"]}' https://api.github.com/authorizations

And convert it into a travis token:
curl -i -H 'User-Agent: Travis/1.0' -H 'Content-Type: application/json' -d '{"github_token":"<TOKEN>"}' https://api.travis-ci.org/auth/github

Then use it:
curl -H 'Authorization: token <TOKEN>' ...
or
curl https://api.travis-ci.org/...?access_token=<TOKEN>

check for syncing:
curl -i -H 'Accept: application/vnd.travis-ci.2+json' -H 'Authorization: token ">TOKEN>"' https://api.travis-ci.org/users
force syncing
curl -i -X "POST" -H 'Accept: application/vnd.travis-ci.2+json' -H 'Authorization: token ">TOKEN>"' https://api.travis-ci.org/users/sync

Get info about repo:
curl -i  https://api.travis-ci.org/repos/<USER>/<REPO>

Set hook:
curl -i -X PUT -H 'Content-Type: application/json' -H 'Accept: application/vnd.travis-ci.2+json' -H 'Authorization: token "<TOKEN>"' -d '{"hook": {"id": <ID>, "active": true}}' https://api.travis-ci.org/hooks

