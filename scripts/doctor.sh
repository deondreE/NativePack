#!/bin/bash

# check for the npm, yarn, pnpm binaries.

# npm
if command -v npm &> /dev/null | command -v yarn &> /dev/null | command -v pnpm &> /dev/null
then
    echo "Requirements Installed."
else
    echo "Requirements not installed."
fi
