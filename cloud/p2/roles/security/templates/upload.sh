#!/bin/bash

#GS3 parameters
GS3KEY="GOOGQ7JEGVOHWRNHNU6OGZUU"
GS3SECRET="yyhY3PUuUGO74RLixT1EFHhPsJC2O6Co28ieIuxx"
GS3BUCKET="pracownia"
GS3STORAGETYPE="STANDARD" #leave as "standard", defaults to however bucket is set up
function putGoogleS3
{
  local path=$1
  local file=$2
  local aws_path=$3
  local bucket="${GS3BUCKET}"
  local date=$(date +"%a, %d %b %Y %T %z")
  local acl="x-amz-acl:private"
  local content_type="application/octet-stream"
  local storage_type="x-amz-storage-class:${GS3STORAGETYPE}"
  local string="PUT\n\n$content_type\n$date\n$acl\n$storage_type\n/$bucket$aws_path$file"
  local signature=$(echo -en "${string}" | openssl sha1 -hmac "${GS3SECRET}" -binary | base64)
  curl -s -X PUT -T "$path/$file" \
    -H "Host: $bucket.storage.googleapis.com" \
    -H "Date: $date" \
    -H "Content-Type: text/plain" \
    -H "$storage_type" \
    -H "$acl" \
    -H "Authorization: AWS ${GS3KEY}:$signature" \
    "http://$bucket.storage.googleapis.com$aws_path$file"
}

putGoogleS3