#!/bin/bash
#assume existance of a .agignore file
cat .agignore | tr -d '/' > .clean_not_gtag_paths
find -maxdepth 1 | cut -c3- | grep -Fxvf .clean_not_gtag_paths | grep -v '^$' | grep -v '[.]' > .gtagpaths
rm .clean_not_gtag_paths
touch .gtagfilepaths
rm .gtagfilepaths
while read p; do
  find $PWD/$p >> .gtagfilepaths -regex '.*/.*\.\(c\|cpp\|cc\|hh\|h\)$'
done <.gtagpaths

gtags -f .gtagfilepaths
rm .gtagpaths
rm .gtagfilepaths
