#!/bin/bash

src_image=${1}
name=${2:-"habos-$(date +%H%m%d%H%M%S)"}

if [[ -f "${name}.vmdk" ]]; then
  echo "${name} already exists!"
  exit 1
fi

VBoxManage clonehd ${src_image} "${name}.vmdk"

VBoxManage createvm --name "${name}" --ostype Linux_64 --register
VBoxManage storagectl "${name}" --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach "${name}" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "${name}.vmdk"
VBoxManage modifyvm "${name}" --ioapic on
VBoxManage modifyvm "${name}" --boot1 disk
VBoxManage modifyvm "${name}" --memory 512 --vram 128

vagrant package --base "${name}" --output "${name}.box" 
vagrant box add "${name}.box" --force  --name ${name}

