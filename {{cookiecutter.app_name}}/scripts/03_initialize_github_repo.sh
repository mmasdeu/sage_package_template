#!/bin/bash
command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }

echo "Initializing the GitHub repository and pushing changes. You may be asked your GitHub password again..."
git init >> install.log
git add . >> install.log
git commit -m "Initial commit" >> install.log
git remote add origin https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git >> install.log
git push -u origin master >> install.log
echo "Initialization done."
echo "Create a branch to hold the automatically generated documentation. You may be asked your GitHub password again..."
git clone --single-branch --depth 1 https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git gh-pages >> install.log
cd gh-pages
git checkout --orphan gh-pages >> install.log
git rm -rf . >> install.log
touch .nojekyll
git add .nojekyll
git commit -m "Initial commit" >> install.log
git push -u origin gh-pages >> install.log
cd ..
echo "Done with branch creation"
