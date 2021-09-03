#!/bin/bash

sudo rm -rf ~/.workbench/workshop
git clone https://github.com/dl-wb-experiments/face-hiding-workshop ~/.workbench/workshop

chmod -R 777 ~/.workbench/workshop/

source venv/bin/activate
openvino-workbench --image openvino/workbench:2021.4.0.2 --assets-directory ~/.workbench --detached
