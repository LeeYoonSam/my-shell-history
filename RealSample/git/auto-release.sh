#!/bin/bash
# release 브랜치 출시 후 브랜치 최신화 및 버저닝 자동화
# mater 브랜치 tag, push
# develop 브랜치 최신화

usage() 
{
    echo "Usage: $0 [VERSION] [NEW_VERSION] [VERSION_CODE] [NEW_VERSION_CODE]" >&2
    echo "example: $0 1.0.0 1.0.1 1 2"
}

checkCommandStatus() 
{
    if [[ "${?}" -ne 0 ]]
    then
        echo "failed to git commands"
        exit 1
    fi
}

if [[ "${#}" -lt 1 ]]
then
    usage
    exit 1
fi

BRANCH_MSTER='master'
BRANCH_DEV='main'
BRANCH_RELEASE='release'

VERSION=${1}
NEW_VERSION=${2}
VERSION_CODE=${3}
NEW_VERSION_CODE=${4}

# git 변경사항 가져오기
git fetch &> /dev/null
checkCommandStatus

# 마스터 브랜치 push 및 tag 남기기
git checkout "${BRANCH_MSTER}" &> /dev/null
checkCommandStatus

git rebase "${BRANCH_RELEASE}/${VERSION}" &> /dev/null
checkCommandStatus

git push origin "${BRANCH_MSTER}" &> /dev/null
checkCommandStatus

git tag "${VERSION}" || git push "${VERSION}" origin ${BRANCH_MSTER} &> /dev/null
checkCommandStatus

# develop 브랜치 전환
git checkout "${BRANCH_DEV}" &> /dev/null
checkCommandStatus

# develop 브랜치를 mater 브랜치로 rebase
git rebase "${BRANCH_MSTER}" &> /dev/null
checkCommandStatus

# build.gradle 에서 versionCode 를 찾아서 변경
sed "s/versionCode ${VERSION_CODE}/versionCode ${NEW_VERSION_CODE}/" ./app/build.gradle > tmpfile && mv tmpfile ./app/build.gradle

# build.gradle 에서 versionName 을 찾아서 $NEW_VERSION 으로 변경
sed "s/versionName \"${VERSION}\"/versionName \"${NEW_VERSION}\"/" ./app/build.gradle > tmpfile && mv tmpfile ./app/build.gradle

# versionCode $code versionName $NEW_VERSION 으로 git commit
git add app/build.gradle tmpfile
git commit -m "versionCode ${NEW_VERSION_CODE}, versionName ${NEW_VERSION}-dev01" &> /dev/null
checkCommandStatus

# develop 브랜치에 git push
git push origin "${BRANCH_DEV}" &> /dev/null
checkCommandStatus

echo 'Completed Auto Release'
exit 0