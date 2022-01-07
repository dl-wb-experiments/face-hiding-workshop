# Create VM

VM_NAME_PREFIX=dlwb-backup

DISK_NAME_PREFIX=dlwb-backup-disk

DISK_SNAPSHOT_NAME=dlwb-workshop-image

SUBNET_NAME=default-ru-central1-a
ZONE_NAME=ru-central1-a

#TODO: set public key before run
PUBLIC_KEY_PATH=~/.ssh/id_rsa.pub
# --metadata-from-file user-data=metadata.yaml \

VM_NUMBER=1

for i in $(seq 1 ${VM_NUMBER}); do
  VM_NAME="${VM_NAME_PREFIX}-${i}"
  
  echo "Creating virtual machine ${VM_NAME} ..."
  
  yc compute instance create \
    --name ${VM_NAME} \
    --network-interface subnet-name=${SUBNET_NAME},nat-ip-version=ipv4 \
    --zone ${ZONE_NAME} \
    --ssh-key ${PUBLIC_KEY_PATH} \
    --create-boot-disk name=${DISK_NAME_PREFIX}-${i},snapshot-name=${DISK_SNAPSHOT_NAME},type=network-ssd \
    --platform 'standard-v3' \
    --memory 16 \
    --cores 4 \
    --core-fraction 100 \
    --service-account-name 'workbench' \
    --preemptible \
    --async
done

echo "Triggered creation of ${VM_NUMBER} virtual machines"
