make_AMI
========

The AMI registration tool which operates by EC2

!!!  Cautions  !!!
/tmp, /mnt, and /var/log are deleted. 


An environment variable is set to .bash_profile. 

CERT=cert_file.pem
PK=key_file.pem
SAVE_DIR=bucket/dir/                "s3://" does not write.
AMI_NAME_PREFIX=ami_prefix             ami_prefixYYYYMMDDHHMI
S3CMD_CONF=--config=/home/ec2user/.s3cfg


It performs by a root user. 
./make_AMI.sh


