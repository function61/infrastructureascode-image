#!/bin/bash -eu

terraform apply my.plan && rm my.plan
