FROM dsavell/grav:admin-1.7.12

RUN wget https://packages.sury.org/php/apt.gpg -O /etc/apt/trusted.gpg.d/php-sury.gpg && \
    chmod 1777 /tmp && apt-get update && \
    apt-get -y install git sqlite3  php7.4-pdo php7.4-sqlite3 php7.4-mysql
RUN echo "upload_max_filesize = 200M" >> /etc/php/7.4/cli/conf.d/25-increase-upload-size.ini
RUN echo "upload_max_filesize = 200M" >> /etc/php/7.4/fpm/conf.d/25-increase-upload-size.ini

COPY site.yaml /var/www/grav/user/config/site.yaml
COPY page-toc.yaml /var/www/grav/user/config/plugins/
RUN mkdir /var/www/grav/user/pages

# Add dogfish
ARG PERSISTANT_DIR=/var/www/grav/user
COPY dogfish/ /usr/share/dogfish
COPY migrations/ /usr/share/dogfish/shell-migrations
RUN ln -s /usr/share/dogfish/dogfish /usr/bin/dogfish
RUN mkdir /var/lib/dogfish
# Need to do this all together because ultimately, the config folder is a volume, and anything done in there will be lost.
RUN mkdir -p ${PERSISTANT_DIR} && touch ${PERSISTANT_DIR}/migrations.log && ln -s ${PERSISTANT_DIR}/migrations.log /var/lib/dogfish/migrations.log

## Set up the CMD as well as the pre and post hooks.
COPY go-init /bin/go-init
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY exitpoint.sh /usr/bin/exitpoint.sh

ENTRYPOINT ["go-init"]
CMD ["-main", "/usr/bin/entrypoint.sh /init-admin", "-post", "/usr/bin/exitpoint.sh"]
