#!/bin/bash

yum makecache fast
yum update -y
%{ if ADDITIONAL_CMD != "" }${ADDITIONAL_CMD}%{ endif }
