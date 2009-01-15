#!/bin/bash

source /etc/init.d/functions.sh

PROJECT=porticron
VERSION=$(sed 's/^:Version: \(.*\)/\1/;t;d' README)

mkdir -p ~/public_html/projects/${PROJECT}/dist

ebegin "Creating release tarball"
git archive --format=tar --prefix=${PROJECT}-${VERSION}/ HEAD | \
bzip2 > ~/public_html/projects/${PROJECT}/dist/${PROJECT}-${VERSION}.tar.bz2
eend $?

ebegin "Generating project page"
rst2html.py < README > ~/public_html/projects/${PROJECT}/index.html
eend $?
