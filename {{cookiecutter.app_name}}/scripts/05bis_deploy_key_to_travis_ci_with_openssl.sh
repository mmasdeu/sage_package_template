#!/bin/bash
echo "Experimental script! You'd better use the travis command line utility."
exit 1

echo "See https://github.com/travis-ci/travis.rb/blob/master/lib/travis/cli/encrypt_file.rb"
echo "and https://gist.github.com/cboehme/5204711 for info."

echo "Downloading your project travis ci public key into .travis.pubkey"
curl -s https://api.travis-ci.org/repo/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}/key | 
sed "s/^.*\(-----BEGIN\( RSA\)\? PUBLIC KEY-----.*-----END\( RSA\)\? PUBLIC KEY-----\\\\n\).*$/\1/" | 
sed "s/\\\\n/\n/g" | 
sed "s/ RSA PUBLIC KEY/ PUBLIC KEY/g" > ".travis.pubkey"

# generate key and iv and encrypt them
echo "Creating random AES key and iv, encrypting your project github pages private key with it, and encrypting the key and iv (yes, that's correct) with your project travis repository public key."
openssl aes-256-cbc -e -p -nosalt -pass pass: -in .travis_ci_gh_pages_deploy_key -out .travis_ci_gh_pages_deploy_key.enc |
while read VAREQVAL; do
  VAREQVAL=`echo ${VAREQVAL} | tr -d ' '`
  echo "Encrypting ${VAREQVAL} with your travis repository public key."
  echo "To make it available in travis VM, add the following line in the env section of .travis.yml:"
  echo -n "  - secure: "
  echo -n "encrypted_gh_${VAREQVAL}" | openssl pkeyutl -encrypt -pubin -inkey ".travis.pubkey" | base64 --wrap 0
  echo
done

echo "To decode the github pages private key in travis VM, add the following line in the before_install section of .travis.yml:"
echo "  - openssl aes-256-cbc -d -K \$encrypted_gh_key -iv \$encrypted_gh_iv -in .travis_ci_gh_pages_deploy_key.enc -out .travis_ci_gh_pages_deploy_key"

echo "Running 'travis encrypt-file .travis_ci_gh_pages_deploy_key' would generate random AES key and IV the same way and make them available in 'automagically' defined envvars named encrypted_<uuid>_[key|iv] where uuid is computed as \"pwd|tr -d '\\n' | sha1sum | cut -c1-12\", which is currently `pwd | tr -d '\n' | sha1sum | cut -c1-12`"
echo "and ask you to add the following line to .travis.yml:"
echo "  - openssl aes-256-cbc -d -K \$encrypted_<uuid>_key -iv \$encrypted_<uuid>_iv -in .travis_ci_gh_pages_deploy_key.enc -out .travis_ci_gh_pages_deploy_key"

echo "Finally we add the encrypted key and commit changes to GitHub. You may be asked for your GitHub password one last time."
        
git add .travis_ci_gh_pages_deploy_key.enc
git add .travis.yml
git commit -m "Deploy built documentation to GitHub"
git push

