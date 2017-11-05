#!/bin/bash

#build
hugo --quiet

#deploy
s3cmd sync  public/ s3://blog.stderror.net --exclude '.DS_Store' --delete-removed
