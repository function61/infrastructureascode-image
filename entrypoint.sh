#!/bin/bash -eu

if [ ! -d .terraform ]; then
	cp -r /terraform-plugins .terraform
fi

exec bash
