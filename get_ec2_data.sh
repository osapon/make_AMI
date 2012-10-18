#!/bin/sh

# get instance data
url_prefix=http://169.254.169.254/latest
ec2_instance_id=`/usr/bin/curl ${url_prefix}/meta-data/instance-id/ --stderr /dev/null`
ec2_region=`/usr/bin/curl ${url_prefix}/meta-data/public-hostname --stderr /dev/null | awk -F . '{print $2}'`
ec2_public_ipv4=`/usr/bin/curl ${url_prefix}/meta-data/public-ipv4 --stderr /dev/null`
ec2_user_id=`/usr/bin/curl ${url_prefix}/dynamic/instance-identity/document --stderr /dev/null | awk -F : '/accountId/ {n=split($2,a,"\"");print a[2]}'`
