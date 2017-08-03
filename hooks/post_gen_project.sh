#!/bin/bash
sh -c "curl -u '{{cookiecutter.github_username}}' https://api.github.com/user/repos -d '{\"name\":\"{{cookiecutter.app_name}}\",\"description\":\"{{cookiecutter.project_short_description}}\"}'" # Create new repository on github.com

ssh-keygen -t dsa -f .travis_ci_gh_pages_deploy_key -N "" # Generate DSA key for Travis-CI doc deployment

git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git
git remote -v
git push -u origin master

git clone --single-branch --depth 1 https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git gh-pages
cd gh-pages
git checkout --orphan gh-pages
git rm -rf .
touch .nojekyll
git add .nojekyll
git commit -m "Initial commit"
git push -u origin gh-pages
cd ..


filecontents=$(cat .travis_ci_gh_pages_deploy_key.pub)

sh -c "curl -u '{{cookiecutter.github_username}}' https://api.github.com/repos/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}/keys -d '{\"title\":\"Key for deploying documentation to GitHub pages\",\"key\":\"${filecontents}\", \"read_only\":\"false\"}'" # Add deploy public key to Github

gem install --user travis
travis login -u {{cookiecutter.github_username}}
travis encrypt-file .travis_ci_gh_pages_deploy_key --add before_script -r {{cookiecutter.github_username}}/{{cookiecutter.app_name}}
travis enable -r {{cookiecutter.github_username}}/{{cookiecutter.app_name}}

git add .travis_ci_gh_pages_deploy_key.enc
git add .travis.yml
git commit -m "Deploy built documentation to GitHub"
git push
