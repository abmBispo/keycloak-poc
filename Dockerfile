FROM elixir:1.12-alpine AS build

RUN apk add --no-cache build-base git

ARG mix_env="dev"

WORKDIR /phoenix

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY priv priv
COPY test test
COPY lib lib
COPY .formatter.exs .formatter.exs
COPY start.sh start.sh
RUN MIX_ENV=$mix_env mix do compile, release

# prepare release image
FROM alpine:3.9 AS phoenix
ARG mix_env="dev"
ENV MIX_ENV=$mix_env
RUN apk add --no-cache openssl ncurses-libs libstdc++

WORKDIR /phoenix

RUN chown nobody:nobody /phoenix

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /phoenix/_build/$MIX_ENV/rel/marketplace ./
COPY --from=build --chown=nobody:nobody /phoenix/start.sh ./start.sh

ENV HOME=/phoenix

CMD ["sh", "./start.sh"]