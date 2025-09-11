# Use the official Elixir image
# This will install Elixir 1.16.0 and Erlang/OTP 26
FROM elixir:1.16.0-otp-26-alpine

# Install build dependencies
RUN apk add --no-cache build-base git postgresql-client

# Create app directory
WORKDIR /app

# Set environment
ENV MIX_ENV=prod

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy mix.exs and mix.lock
COPY mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get --only prod

# Copy configuration files
COPY config ./config

# Copy lib, priv, and other necessary files
COPY lib ./lib
COPY priv ./priv

# Compile dependencies and application
RUN mix deps.compile && \
    mix compile

# Create release
RUN mix release

# Expose port
EXPOSE 4000

# Set the startup command
CMD ["_build/prod/rel/chereta/bin/chereta", "start"]