cat $HOME/.aws/credentials #show placement of AWS credentials

aws configure #configure aws cli

cat /etc/system-release #You can view your version of Amazon Linux using the following command.


# Check whether an IP address is part of the CIDRs of your security groups
# Replace <security-group-id> with the ID of the security group you want to check and <ip-address> with the IP address you want to check. 
# This command will return the CIDRs of the IP ranges allowed by the security group, 
# and you can use the grep command to check if the IP address you want to check is part of any of those CIDRs.
aws ec2 describe-security-groups --group-ids <security-group-id> --query 'SecurityGroups[].IpPermissions[].IpRanges[].CidrIp' --output text | grep <ip-address>
