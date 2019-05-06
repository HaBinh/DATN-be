FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /raan
WORKDIR /raan
ADD . /raan
RUN bundle install
RUN bundle exec rails db:migrate RAILS_ENV=production