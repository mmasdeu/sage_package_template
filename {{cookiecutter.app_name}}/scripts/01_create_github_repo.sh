#!/bin/bash
curl -s https://api.github.com/repos/{{cookiecutter.github_username}}/{{cookiecutter.app_name}} | grep "Not Found" > /dev/null || { echo >&2 "The repository {{cookiecutter.app_name}} already exists in {{cookiecutter.github_username}}.  Aborting."; exit 1; }

echo "Trying to create a new repository on github.com."
echo "You will be asked for the GitHub password corresponding to the user {{cookiecutter.github_username}}"
echo "{{cookiecutter.github_username}}/{{cookiecutter.app_name}}"
echo "{{cookiecutter.project_short_description}}"

curl -s -u '{{cookiecutter.github_username}}' https://api.github.com/user/repos -d '{"name":"{{cookiecutter.app_name}}","description":"{{cookiecutter.project_short_description}}"}' >> install.log # Create new repository on github.com

echo "Repository successfully created."
