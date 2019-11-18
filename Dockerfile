FROM drupal:8

# Install packages
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    apt-get update && apt-get install --no-install-recommends -y \
    curl \
    wget \
    vim \
    git \
    unzip \
    mysql-client

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# Install Drush
RUN composer global require drush/drush && \
    composer global update

# Add drupal console
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \
    && php -r "readfile('https://drupalconsole.com/installer');" > drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal


# Clean repository
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
