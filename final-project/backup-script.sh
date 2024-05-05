 #!/bin/bash

VM_NAMES=("vm1" "vm2")

for VM_NAME in "${VM_NAMES[@]}"
do
    echo "Processing $VM_NAME..."

    VM_STATE=$(VBoxManage showvminfo "$VM_NAME" --machinereadable | grep "VMState=" | cut -d '"' -f2)

    if [ "$VM_STATE" = "running" ]; then
        echo "Taking snapshot of the running VM: $VM_NAME"
        VBoxManage snapshot "$VM_NAME" take "snapshot_${VM_NAME}_$(date +%Y-%m-%d)" --live
    else
        echo "VM $VM_NAME is not running. Starting VM to take a snapshot."
        VBoxManage startvm "$VM_NAME" --type headless
        sleep 60 # wait for the VM to start
        VBoxManage snapshot "$VM_NAME" take "snapshot_${VM_NAME}_$(date +%Y-%m-%d)"
        VBoxManage controlvm "$VM_NAME" acpipowerbutton
    fi

    echo "Snapshot for $VM_NAME completed."
done

## 0 3 * * 0 /path/to/weekly_snapshots.sh >> /var/log/vm_snapshots.log 2>&1
