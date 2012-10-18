#!/bin/bash

/etc/init.d/crond stop

target_dt=`date +%Y%m%d%H%M`
ami_dir=${SAVE_DIR}${target_dt}
ami_name=${AMI_NAME_PREFIX}${target_dt}
source ./get_ec2_data.sh

rm -rf /tmp/*
rm -f /var/log/boot* /var/log/cloud-init* /var/log/cron* /var/log/dmesg* /var/log/maillog* /var/log/messages* /var/log/secure* /var/log/spooler* /var/log/wtmp* /var/log/yum*
rm -f /var/log/audit/*
rm -f /var/log/pgpool/*
rm -f /var/log/zabbix/*

cd /mnt
rm -rf *
ec2-bundle-vol -d /mnt -c ${CERT} -k ${PK} -u ${ec2_user_id} -r x86_64

s3cmd sync ${S3CMD_CONF} --reduced-redundancy --mime-type=application/octet-stream /mnt/image.* s3://${ami_dir}/
s3cmd setacl ${S3CMD_CONF} --acl-grant=read:za-team@amazon.com s3://${ami_dir}/*

ec2-register -C ${CERT} -K ${PK} ${ami_dir}/image.manifest.xml --region ${ec2_region} -a x86_64 -n ${ami_name}
