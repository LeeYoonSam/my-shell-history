#!/bin/bash
FILE_NAME='build.gradle'

KEY_VERSION_CODE='versionCode'
KEY_VERSION_NAME='versionName'

versionCode=$( echo $(grep $KEY_VERSION_CODE build.gradle | head -1 | sed s/$KEY_VERSION_CODE//g) )
echo "versionCode: $versionCode"

versionName=$( echo $(grep $KEY_VERSION_NAME build.gradle | head -1 | sed s/$KEY_VERSION_NAME//g) )
echo "versionName: $versionName"
