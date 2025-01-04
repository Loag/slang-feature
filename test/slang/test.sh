#!/bin/bash

set -e

source dev-container-features-test-lib

export PATH=$PATH:/opt/slang/bin

check "version" slangc -version

reportResults