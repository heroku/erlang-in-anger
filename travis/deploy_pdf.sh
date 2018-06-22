#!/bin/bash

set -ex

if [[ "${TRAVIS_OS_NAME}" == "linux" && "${TRAVIS_BRANCH}" == "japanese" && "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  openssl aes-256-cbc -k "$SERVER_KEY" -in ./travis/deploy_key.enc -d -a -out deploy.key
  cp deploy.key ~/.ssh/
  chmod 600 ~/.ssh/deploy.key
  git config --global user.email "yyu@mental.poker"
  git config --global user.name "Yuu Yoshimura"
  git fetch origin gh-pages:gh-pages
  git stash -a
  git checkout gh-pages
  rm text-ja.pdf
  git stash pop
  git add text-ja.pdf
  git commit -a -m "auto commit on travis $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT"
  git push git@github.com:ymotongpoo/erlang-in-anger.git gh-pages:gh-pages
elif [[ "${TRAVIS_PULL_REQUEST}" != "false" ]]; then
  echo -e "Host github.com\n\tStrictHostKeyChecking no\nIdentityFile ~/.ssh/deploy.key\n" >> ~/.ssh/config
  cp ./travis/deploy_key_pr ~/.ssh/deploy.key
  chmod 600 ~/.ssh/deploy.key
  git config --global user.email "yyu@mental.poker"
  git config --global user.name "Yuu Yoshimura"
  git clone git@github.com:y-yu/erlang-in-anger-pr.git
  mkdir -p "erlang-in-anger-pr/${TRAVIS_PULL_REQUEST_BRANCH}"
  cp text-ja.pdf "./erlang-in-anger-pr/${TRAVIS_PULL_REQUEST_BRANCH}/${TRAVIS_PULL_REQUEST_SHA}.pdf"
  cd ./erlang-in-anger-pr
  git add "./${TRAVIS_PULL_REQUEST_BRANCH}/${TRAVIS_PULL_REQUEST_SHA}.pdf"
  git commit -a -m "auto commit on travis $TRAVIS_JOB_NUMBER $TRAVIS_COMMIT"
  git push git@github.com:y-yu/erlang-in-anger-pr.git master:master
fi
