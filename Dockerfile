FROM centos:latest

EXPOSE 8080

RUN yum install -y which tar patch libyaml-devel libffi-devel glibc-headers autoconf gcc-c++ glibc-devel readline-devel zlib-devel openssl-devel bzip2 automake libtool bison
RUN curl -L get.rvm.io | bash -s stable   
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -L get.rvm.io | bash -s stable
RUN source /etc/profile.d/rvm.sh
RUN rvm reload
RUN rvm requirements run
RUN rvm install 2.4.2

RUN mkdir /app

COPY /app/ /app

WORKDIR /app

RUN gem install bundler sinatra thin

RUN bundle install

CMD ["bundle", "exec", "rackup", "--port=8080"]
