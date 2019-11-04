FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update &&  apt-get install -y \
      build-essential \
      default-libmysqlclient-dev \
      libmariadbclient-dev \
      imagemagick \
      git-core \
      nodejs \
      && apt-get autoremove \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT


COPY Gemfile Gemfile.lock ./


RUN gem install bundler
RUN bundle install --jobs 20 --retry 5


COPY . ./

RUN chmod +x $RAILS_ROOT/docker/entrypoint.sh
ENTRYPOINT $RAILS_ROOT/docker/entrypoint.sh
