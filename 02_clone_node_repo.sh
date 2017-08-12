#!/bin/bash

cd ~
git clone https://github.com/nodejs/node.git && cd node && git checkout v6.11.2
make clean
