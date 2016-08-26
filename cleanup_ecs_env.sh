#!/bin/bash -eux

source globals
source functions

ecs_env="${1:-${ECS_ENV}}"
ecs_network="${2:-${ECS_NETWORK_NAME}}"
ecs_volume_pool="${3:-${ECS_VOLUME_POOL_NAME}}"

cleanup_env $ecs_env $ecs_network $ecs_volume_pool

