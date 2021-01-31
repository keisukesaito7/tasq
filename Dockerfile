FROM ruby:2.6.5

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && \
    apt-get install -y nodejs yarn && \
    mkdir /tasq
WORKDIR /tasq
COPY Gemfile /tasq/Gemfile
COPY Gemfile.lock /tasq/Gemfile.lock
RUN gem install bundler:2.1.4 && \
    bundle install
COPY . /tasq

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]