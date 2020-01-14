FROM ruby:2.6.5-alpine

WORKDIR /notify

RUN apk update
RUN apk add build-base bash

RUN gem install bundler

ADD Gemfile* /notify/
RUN bundle install

ADD . /notify
