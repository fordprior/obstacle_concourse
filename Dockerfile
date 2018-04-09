FROM centos:latest

EXPOSE 8080

RUN yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel \
   libyaml-devel libffi-devel openssl-devel make \
   bzip2 autoconf automake libtool bison iconv-devel sqlite-devel
   
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
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
