import sys
import requests
import yaml
import os
import argparse
import string

# Usage: python t-apply.py --version "1.0.0"
parser = argparse.ArgumentParser()
parser.add_argument('--version', 
                    help = 'Version of the app or the docker tag',
                    type = str,
                    required = True)

args = parser.parse_args()
version = args.version
print("Update for version", version )

# terraform plan -var="version_num=2.0.0"
# terraform apply -var="version_num=2.0.0"
