#!/bin/bash -eu

terraform init

terraform plan -out my.plan
