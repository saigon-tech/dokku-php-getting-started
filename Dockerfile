FROM heroku/heroku:22-build as build

# setup buildpack
RUN git clone https://github.com/heroku/heroku-buildpack-php.git /tmp/buildpack/heroku/php
RUN mkdir /app
WORKDIR /app

# copy source code
COPY ./src /app

# Compile source code
RUN STACK=heroku-22 /tmp/buildpack/heroku/php/bin/compile /app /tmp/build_cache /tmp/env

# Minimize to final image
FROM heroku/heroku:22
RUN useradd -m sgt
ENV PATH="/app/.heroku/php/sbin:/app/.heroku/php/bin:/app/.heroku/php/bin:/app/.heroku/php/sbin:/app/.heroku/php/bin:/app/.heroku/php/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/app/vendor/bin:${PATH}"

# copy source from build stage to production
COPY --chown=sgt:www-data --from=build /app /app

ENV HOME /app
WORKDIR /app

USER sgt
