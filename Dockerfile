FROM dsavell/grav:admin-1.6.11

RUN echo "upload_max_filesize = 200M" >> /etc/php/7.3/cli/conf.d/25-increase-upload-size.ini
RUN echo "upload_max_filesize = 200M" >> /etc/php/7.3/fpm/conf.d/25-increase-upload-size.ini
