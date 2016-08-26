#!/bin/bash -eux

source globals
source functions

ecs_env=${1:-${ECS_ENV}}
ecs_network_name=${2:-${ECS_NETWORK_NAME}}
ecs_network_ip=${3:-${ECS_NETWORK_IP}}
ecs_volume_pool=${4:-${ECS_VOLUME_POOL_NAME}}
ecs_volume_pool_path=${5:-${ECS_VOLUME_POOL_PATH}}
ecs_cdrom_path=${6:-${ECS_CDROM_PATH}}

create_network $ecs_network $ecs_ip
create_volume_pool $ecs_volume_pool $ecs_volume_pool_path

create_vm $ecs_env $ecs_volume_pool $ecs_network $ecs_cdrom_path

wait_vm_status $ecs_env 'shut'

patch_vm_disk_cache_settings $ecs_env

ecs_env_number=$(echo $ecs_env | awk -F '-' '{print($2)')
ecs_ip=$(echo $ecs_network_ip | sed "s/\\([0-9.]\\+\\)\\(\\.[0-9]\\+\\)\$/\\1.${ecs_env_number}/")
patch_vm_network_settings $ecs_env $ecs_volume_pool $ecs_ip $ecs_network_ip 
