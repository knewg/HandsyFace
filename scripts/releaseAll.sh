#!/bin/bash

cd $(dirname $0)
rm ../release/*
devices=( fenix5 fenix5plus fenix5s fenix5splus fenix5x fenix5xplus )
for i in ${devices[@]}; do
  ./release.sh $i
done

