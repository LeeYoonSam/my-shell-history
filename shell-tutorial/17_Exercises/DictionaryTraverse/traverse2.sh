#!/bin/sh

doindent()
{
    # 트리의 깊이에 따라 들여쓰기를 하십시오. 
    # 환경에 따라 echo -en " " 대신 echo " \c"를 사용해야 할 수도 있습니다.
    j=0;
    while [ "$j" -lt "$1" ]; do
        echo "  \c"
        j=`expr $j + 1`
    done
}

traverse()
{
    # Traverse a directory
    indent="$2"

    ls "$1" | while read i
    do
        doindent $2
        if [ -d "$1/$i" ]; then
            echo "Directory: $1/$i"
            # 이것을 서브쉘로 호출한다는 것은 호출된 함수가 디렉토리를 변경할 때 현재 작업 디렉토리에 영향을 미치지 않는다는 것을 의미합니다.
            traverse "$1/$i" `expr $2 + 1`
        else
            echo "File: $1/$i"
        fi
    done
}

if [ -z "$1" ]; then
    traverse . 0
else 
    traverse "$1" 0
fi