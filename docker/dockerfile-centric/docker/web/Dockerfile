FROM ubuntu:14.04
MAINTAINER JBPadgett "@jbpadgett"
ENV REFRESHED_AT 04-30-2015

# REPOS SETUP
#RUN apt-get -y update && add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
# Add repos for Phusion Passenger as package
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
RUN sudo apt-get install -y apt-transport-https ca-certificates
RUN sudo echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' > /etc/apt/sources.list.d/passenger.list
RUN sudo chown root: /etc/apt/sources.list.d/passenger.list && chmod 600 /etc/apt/sources.list.d/passenger.list

# INSTALL DESIRED PACKAGES
RUN sudo apt-get update -qq && sudo apt-get install -y build-essential \
                                             curl \
                                             wget \
                                             inetutils-ping \
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
                                             libpq-dev \
                                             postgresql-client \
                                             supervisor \
                                             apache2 \
                                             libapache2-mod-passenger \
                                             nodejs \
                                             passenger

# Create rails user to avoid root owning everything
RUN adduser --disabled-password --home=/rails --gecos "" rails

# Setup Passenger Apache Module
RUN sudo a2enmod passenger && sudo apache2ctl stop && sudo apache2ctl start

# Setup Apache
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /rails/myapp/public
COPY /docker/web/gaphn-apache.conf /etc/apache2/sites-available/gaphn-apache.conf
RUN sudo a2enmod cgi
RUN sudo a2dissite 000-default && sudo a2ensite gaphn-apache && sudo service apache2 restart

# Setup supervisord to manages processes
RUN mkdir -p /var/log/supervisor
COPY /docker/supervisor/rails.svc.conf /etc/supervisor/conf.d/rails.svc.conf


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

# Install bundler
RUN gem install bundler --no-document

### RAILS APP SECTION ###
# Gem caching outside app dir
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN mkdir -p /tmp/bundle
WORKDIR /tmp 
RUN bundle install --path /tmp/bundle/ --gemfile=/tmp/Gemfile

#ADD Gemfile /myapp/Gemfile
#ADD Gemfile.lock /myapp/Gemfile.lock
#RUN mkdir -p /tmp/bundle
#RUN cd /myapp && bundle install --path /tmp/bundle/ --gemfile=/myapp/Gemfile

# Create rails app directory and set ownership to rails user
RUN mkdir -p /rails/myapp
#ADD . /myapp
RUN chown -R rails:rails /rails/myapp
#Create volume for app code
VOLUME /rails/myapp

# Initial DB setup using bundler + rake
#RUN cd /myapp && bundle exec rake db:drop db:create db:migrate

# Rails app env prep
ENV RAILS_ENV development
EXPOSE 3000
WORKDIR /rails/myapp
CMD ["/usr/bin/supervisord"]
