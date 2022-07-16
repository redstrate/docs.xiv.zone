FROM klakegg/hugo:alpine AS build

COPY . /site
WORKDIR /site
ARG DOMAIN

RUN hugo --baseURL ${DOMAIN}

FROM caddy

COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=build /site/public /srv
