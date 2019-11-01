FROM ruby:2.6

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update &&  apt-get install -y \
      build-essential \
      default-libmysqlclient-dev \
      imagemagick \
      git-core \
      nodejs \
      && apt-get autoremove \
      && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ENV GEM_HOME /gems
ENV BUNDLE_PATH $GEM_HOME
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH

COPY Gemfile Gemfile.lock ./


RUN gem install bundler \
    && bundle install --jobs 20 --retry 5 --without development test
RUN npm install -g yarn

COPY . ./

ENTRYPOINT $RAILS_ROOT/docker/entrypoint.sh
