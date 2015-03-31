FROM ubuntu:14.04
MAINTAINER JBPadgett "@jbpadgett"
ENV REFRESHED_AT 04-27-2015

# REPOS SETUP
#RUN apt-get -y update && add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"

# INSTALL DESIRED PACKAGES
RUN apt-get update -qq && apt-get install -y build-essential \
                                             curl \
                                             wget \
                                             git-core \
                                             git \
                                             zlib1g-dev \
                                             openssl \
                                             libssl-dev \
                                             libreadline-dev \
                                             libyaml-dev \
                                             libxml2-dev \
                                             libxslt-dev \
                                             libtool \
                                             libcurl4-openssl-dev \
                                             python-software-properties \
                                             software-properties-common \
                                             libffi-dev \
                                             bison \
                                             unzip \
                                             vim \
                                             libsqlite3-dev \
                                             sqlite3 \
                                             postgresql-client

# Install Ruby from source
ADD http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.4.tar.gz /tmp/
RUN cd /tmp && \
      tar -xzf ruby-2.1.4.tar.gz && \
      cd ruby-2.1.4 && \
      ./configure && \
      make && \
      make install && \
      cd .. && \
      rm -rf ruby-2.1.4 && \
      rm -f ruby-2.1.4.tar.gz

# Install base gems
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri
 
# Regenerate binstubs
RUN gem regenerate_binstubs

### RAILS APP SECTION ###

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Rails app env prep
ADD docker/web/start_rails_server.sh /start_rails_server.sh
RUN chmod +x /start_rails_server.sh

# Gem caching outside app dir
WORKDIR /tmp 
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install 

# Create rails app directory
ADD . /myapp
WORKDIR /myapp
ENV RAILS_ENV development
RUN RAILS_ENV=development bundle exec rake assets:precompile --trace

EXPOSE 3000
CMD ["/start_rails_server.sh"]
