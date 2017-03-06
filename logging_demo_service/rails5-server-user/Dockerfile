FROM daocloud.io/ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /src
WORKDIR /src

COPY Gemfile /src/
COPY Gemfile.lock /src/
RUN cd /src && bundle install

COPY . /src/

EXPOSE 5001
ADD . /src