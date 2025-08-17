#!/bin/bash

if grep -qEi "(Microsoft|WSL)" /proc/version; then
    WSL=true
else
    WSL=false
fi

if [ "$WSL" = true ]; then
    cat << EOF
Use are running on WSL
Execute on Windows Host machine:
--------------------------------
winget install --interactive --exact dorssel.usbipd-win1 # Only if not already installed
usbipd.exe list # find BUSID starting from 0955
usbipd.exe bind --busid <BUSID> --force
usbipd.exe attach --wsl --busid=<BUSID> --auto-attach
EOF

    read -p "Type 'Go' or 'g' to continue: " user_input
    while [[ "$user_input" != "Go" && "$user_input" != "g" ]]; do
        echo "Invalid input. Please type 'Go' or 'g' to continue."
        read -p "Execute and type 'Go' or 'g' to continue: " user_input
    done
fi

if ! command -v sdkmanager &> /dev/null; then
    sudo apt update

    if [ "$WSL" = true ]; then
        sudo apt install -y wslu linux-tools-virtual hwdata
    fi

    ubuntu_version=$(lsb_release -rs | sed 's/\.//g')
    formatted_version="ubuntu${ubuntu_version}"

    wget https://developer.download.nvidia.com/compute/cuda/repos/$formatted_version/x86_64/cuda-keyring_1.1-1_all.deb
    sudo dpkg -i cuda-keyring_1.1-1_all.deb
    rm -rf cuda-keyring_1.1-1_all.deb
    sudo apt update
    sudo apt -y install sdkmanager
fi

sdkmanager