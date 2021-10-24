#!/bin/bash
set -e

bin/key_cloak_poc eval "KeyCloakPoc.Release.migrate"
bin/key_cloak_poc start

exec "$@"