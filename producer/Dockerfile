FROM docker.io/library/ruby:3.0

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY app.rb .

RUN bundle install

CMD ["ruby", "/app/app.rb"]
