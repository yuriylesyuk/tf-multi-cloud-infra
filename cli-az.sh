#!/bin/bash

# rust to compile cryptography modules
if ! [ -x "$(command -v jq)" ]; then
    echo "rustc is not found. installing it..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

pip3 install azure-cli
source ~/.profile

echo "execute az login to authenticate"



