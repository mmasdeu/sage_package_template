#!/bin/bash
echo "Adding deploy public key to GitHub"

echo "Instead of your password, you MUST use a Personal Access Token !!!"
echo "( See here how to get one:"
echo "  https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line )"

filecontents=$(cat .travis_ci_gh_pages_deploy_key.pub)
curl -s -u '{{cookiecutter.github_username}}' https://api.github.com/repos/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}/keys -d "{\"title\":\"Key for deploying documentation to GitHub pages\",\"key\":\"${filecontents}\", \"read_only\":\"false\"}" >> install.log
echo "Done with public key deployment. You may receive an email from GitHub that lets you know of this."
