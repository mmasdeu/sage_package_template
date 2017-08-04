==========================================================
Further setup instructions (to delete before distribution)
==========================================================

1) Create a Github repository (https://github.com/new)

2) Put your newly created package in it::

     $ cd {{cookiecutter.app_name}}
     $ git init
     $ git add .
     $ git commit -m "first commit"
     $ git remote add origin https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git
     $ git remote -v
     $ git push -u origin master

3) Edit how the documentation should appear, by changing appropriate files in docs/

#) Enable Travis CI integration: follow the rest of the article to enable Continuous Integration via `https://travis-ci.org`.

   Scripts that run ``make test`` on various SageMath versions on the
   Travis CI system are included.
   https://docs.travis-ci.com/user/for-beginners explains how to enable
   automatic Travis CI builds for your GitHub-hosted project.

   The scripts download and install the last two binary releases from a
   SageMath mirror.  Edit ``.travis-install.sh`` if some optional or
   experimental SageMath packages need to be installed prior to running
   your package.

#) Enable automatic deployment of documentation to GitHub pages using Travis CI.

   * First enable Travis CI integration of your GitHub-hosted project. This is done by signing-in into https://travis-ci.org/profile/{{cookiecutter.github_username}} and pushing the switch corresponding to {{cookiecutter.app_name}}.

   * If you don't already have GitHub pages for your project: Create and
     checkout a branch ``gh-pages`` in your repository and put an empty
     file ``.nojekyll`` in it (see
     https://help.github.com/articles/files-that-start-with-an-underscore-are-missing/).
     Then commit it and push it to GitHub::

       $ git clone --single-branch --depth 1 https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}.git gh-pages
       $ cd gh-pages
       $ git checkout --orphan gh-pages
       $ git rm -rf .
       $ touch .nojekyll
       $ git add .nojekyll
       $ git commit -m "Initial commit"
       $ git push -u origin gh-pages
       $ cd ..

   * Add the public ssh key (contents of the file
     ``.travis_ci_gh_pages_deploy_key.pub``, which was generated
     by the cookiecutter) to your GitHub repository
     as a deploy key (Settings/Deploy keys/Add deploy key).
     Title: "Key for deploying documentation to GitHub pages".
     Check *Allow write access*.

   * Install the Travis CI command-line client from
     https://github.com/travis-ci/travis.rb::

       $ gem install travis

   * Log in to Travis CI using your GitHub credentials::

       $ travis login

   * Encrypt the private ssh key, add the decryption keys
     as secure environment variables to Travis CI, and
     add code to ``.travis.yml`` to decrypt it::

       $ travis encrypt-file .travis_ci_gh_pages_deploy_key --add before_script

   * Make sure that only one line is present in the ``before_script`` section of ``.travis.yml``. It should look like
   
        before_script:
        - openssl aes-256-cbc -K $encrypted_896e4f392045_key -iv $encrypted_896e4f392045_iv -in .travis_ci_gh_pages_deploy_key.enc -out .travis_ci_gh_pages_deploy_key -d || true

     The names after the ``$`` signs should match those found in travis-ci.org > More options > settings. Make sure that
     the ``|| true`` is also at the end of the line (add if it is not there).
   
   * Add the encrypted private ssh key to the repository::

       $ git add .travis_ci_gh_pages_deploy_key.enc

   * Optionally, edit ``.travis.yml`` to adjust variables ``DEPLOY_DOC_...``

   * Commit all changes to GitHub.  The Travis CI build should then run
     automatically and deploy it::

       $ git add .travis.yml
       $ git commit -m "Deploy built documentation to GitHub"
       $ git push

   * The deployed documentation will be available at:
     https://{{cookiecutter.github_username}}.github.io/{{cookiecutter.app_name}}/
     This can be customized by changing ``DEPLOY_DOC_TO_DIRECTORY=/``
     to another directory in ``.travis.yml``
     For example, setting ``DEPLOY_DOC_TO_DIRECTORY=doc/html`` will make
     the deployed documentation available at:
     https://{{cookiecutter.github_username}}.github.io/{{cookiecutter.app_name}}/doc/html/

