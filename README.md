# Example export habitat services to a vagrant box

### In the studio

hab pkg exec core/hab-pkg-image env HAB_SYSTEM=core/hab-image-vagrant HAB_SUP_OPTIONS="--peer 192.168.100.100" HAB_SVC_OPTIONS="--strategy=rolling --topology=leader" hab-pkg-image core/redis
hab pkg exec core/qemu qemu-img convert results/core-redis-{version-timestamp}.raw -O vmdk results/core-redis-{version-timestamp}

### On your workstation

scripts/create_box_from.sh results/core-redis-{version-timestamp}.vmdk core-redis 

vagrant up
