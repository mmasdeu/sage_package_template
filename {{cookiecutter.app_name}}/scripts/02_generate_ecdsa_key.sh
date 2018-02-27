#!/bin/bash
command -v ssh-keygen >/dev/null 2>&1 || { echo >&2 "ssh-keygen required but not installed.  Aborting."; exit 1; }
echo "Now generating a ECDSA key..."
ssh-keygen -q -t ecdsa -f .travis_ci_gh_pages_deploy_key -N ""
echo "...done."
