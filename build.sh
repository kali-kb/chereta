#!/usr/bin/env bash
# exit on error
set -o errexit

# WSL-specific environment setup
export DEBIAN_FRONTEND=noninteractive

# Install hex and rebar
mix local.hex --force
mix local.rebar --force

# Install dependencies
mix deps.get --only prod

# Compile dependencies
MIX_ENV=prod mix deps.compile

# Compile the application
MIX_ENV=prod mix compile

# Generate the release
MIX_ENV=prod mix release

# Run database migrations
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate

# Run seeds if needed
# MIX_ENV=prod mix run priv/repo/seeds.exs