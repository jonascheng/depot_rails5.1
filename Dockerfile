FROM ruby:2.4 as base

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    nodejs

RUN gem install bundler

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

########################################
# dev stage for conveinent development envrionment
FROM base as dev

# for development only, feel free to remove in release
RUN apt-get install -y --no-install-recommends \
    mysql-client

########################################
# release stage
FROM base as release

RUN rm -rf /var/lib/apt/lists/*
