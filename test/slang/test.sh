#!/bin/bash

set -e

source dev-container-features-test-lib

check "version" slangc -version

reportResults