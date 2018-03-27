#!/bin/sh
find / -name ".DS_Store" -exec rm -vf {} \;
find / -name "Thumbs.db" -exec rm -vf {} \;
