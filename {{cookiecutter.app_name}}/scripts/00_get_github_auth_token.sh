#!/bin/bash

echo "Rather than asking for passwords we should get an auth token from github once."
exit 1

Some doc:
To create one:
curl -u '<USER>' -d '{"note": "<UNIQUE_STR>"}'
https://api.github.com/authorizations
gets you a unique token (and a unique id) in the resonse if UNIQUE_STR
was not already used.
Otherwise you get a   "message": "Validation Failed", with associated errors.
A way around is to add a fingerprint field:
curl -u '<USER>' -d '{"note": "<UNIQUE_STR>",
"fingeprint":"<FINGERPRINT>"}' https://api.github.com/authorizations
You can also list the existing authorizations:
curl -u '<USER>' https://api.github.com/authorizations
To delete a token with a given id:
curl -u '<USER>' -X "DELETE" https://api.github.com/authorizations/<UNIQUE_ID>
(this will avoid further failures).

Different way to then use the token:
https://developer.github.com/v3/#authentication
