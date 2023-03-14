#!/bin/bash

usage() 
{
    echo "Usage: ${0} [TARGET_BARNCH] [NEW_VERSION_SUFFIX]" >&2
    echo '이 스크립트를 실행하려면 [TARGET_BRANCH]와 [NEW_VERSION_SUFFIX]가 필요합니다.' >&2
    exit 1
}

if [[ ${#} -lt 2 ]]
then
    usage
fi

TARGET_BRANCH=${1}
NEW_VERSION_SUFFIX=${2}

# get exist versionName and versionCode
VERSION=$(grep versionName ./app/build.gradle | sed s/versionName//g | xargs)
VERSION_CODE=$(grep versionCode ./app/build.gradle | sed s/versionCode//g | xargs)

echo "TARGET_BRANCH: ${TARGET_BRANCH}"
echo "NEW_VERSION_SUFFIX: ${NEW_VERSION_SUFFIX}"
echo "VERSION: ${VERSION}"
echo "VERSION_CODE: ${VERSION_CODE}"


# change [VERSION] to [NEW_VERSION]
sed "s/versionName \"${VERSION}\"/versionName \"${NEW_VERSION_SUFFIX}\"/" ./app/build.gradle > tmpfile && mv tmpfile ./app/build.gradle

git add app/build.gradle
git commit -m "versionCode ${VERSION_CODE}, versionName ${NEW_VERSION_SUFFIX}" &> /dev/null
git push origin "${TARGET_BRANCH}" &> /dev/null

echo 'Complted version up push!'
exit 0