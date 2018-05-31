FROM circleci/ruby:2.3.7-jessie

ENV FOO=bar

USER root

RUN apt-get update && apt-get install -y metacity vnc4server && apt-get clean

USER circleci