#!/bin/bash 
set -e

from_revision=$1
to_revision=$2

if [ -z ${from_revision} ]; then
  echo please specify from_revision
  echo
  exit 0
fi

if [ -z ${to_revision} ]; then
  echo please specify to_revision
  echo
  exit 0
fi
