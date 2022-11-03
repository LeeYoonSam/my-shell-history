#!/bin/sh

doindent()
{
    j=0;
    while [ "$j" -lt "$1" ]; do
        echo "  \c"
        j=`expr $j + 1`
    done
}

traverse() 
{
    # Traverse a directory
    cd "$1"

    ls | while read i
    do
        doindent $2
        if [ -d "$i" ]; then
            echo "Directory: $i"
            # 이것을 서브쉘로 호출한다는 것은 호출된 함수가 디렉토리를 변경할 때 현재 작업 디렉토리에 영향을 미치지 않는다는 것을 의미합니다.
            (traverse "$i" `expr $2 + 1`)
        else
            echo "File: $i"
        fi
    done
}

if [ -z "$1" ]; then
    traverse . 0
else
    traverse "$1" 0
fi