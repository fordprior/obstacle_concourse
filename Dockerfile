FROM centos:latest

EXPOSE 8080

RUN yum install -y ruby-2.4

RUN mkdir /app

COPY /app/ /app

WORKDIR /app

RUN gem install bundler sinatra thin

RUN bundle install

CMD ["bundle", "exec", "rackup", "--port=8080"]