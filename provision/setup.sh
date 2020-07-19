#!/bin/bash

# Single quotes for special-character passwords
PASSWORD='vagrant'
PUBLICDIRECTORY='html'

echo "System updates..."
sudo apt update > /dev/null 2>&1
sudo apt -y upgrade > /dev/null 2>&1
