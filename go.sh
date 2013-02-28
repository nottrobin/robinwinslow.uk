#!/bin/bash

jekyll --server --auto &
sass --watch _scss:css --style compressed &

