FROM centos:latest

EXPOSE 8080

RUN yum install -y ruby

RUN mkdir /app

COPY /app/ /app

WORKDIR /app

RUN gem install bundler

RUN bundle install

CMD bundle exec puma -C config/puma.rb

CMD ["bundle", "exec", "rackup", "--port=8080"]
