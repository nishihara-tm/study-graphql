FROM ruby:3.1.1-slim-bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    vim \
    libxml2-dev \
    libxslt-dev \
    libgmp-dev \
    default-mysql-client \
    default-libmysqlclient-dev \
    pkgconf \
    libxml2 \
    patch \
    liblzma-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ENV APP_ROOT /usr/src
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle config --global build.nokogiri --use-system-libraries && \
  bundle install

COPY . $APP_ROOT

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
