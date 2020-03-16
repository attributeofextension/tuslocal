FROM centos/httpd

RUN yum install -y epel-release yum-utils && yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum-config-manager --enable remi-php73 \ 
    && yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd yum php-pgsql \ 
    && yum install -y composer \
   # && cd /var/www/html \
   # && composer create-project symfony/website-skeleton tusweb \
   # && cd /var/www/html/tusweb \
   # && composer require symfony/orm-pack && composer require --dev symfony/maker-bundle && composer require doctrine/doctrine-bundle
# CANNOT RUN THESE COMMANDS ON BUILD - TUSWEB DIR MUST MOUNT FIRST

# COPY doctrine.yaml /var/www/html/tusweb/config/packages/doctrine.yaml

# RUN cd /var/www/html/tusweb/bin && php console doctrine:database:create
# This step cannot be completed during build - it must be run in container after docker-compose up

COPY local.conf /etc/httpd/conf.d
# Missing log path causes httpd container to crash
RUN cd /var/log/httpd && mkdir tusweb
