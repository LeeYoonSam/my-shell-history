# Global variables
BOOK=~/.addressbook
export BOOK

confirm()
{
    echo -en "$@"
    read ans
    ans=`echo $ans | tr '[a-z]' '[A-Z]'`
    if [ "$ans" == "Y" ]; then
        return 0
    else 
        return 1
    fi
}

num_lines()
{
    grep -i "$@" $BOOK|wc -l| awk '{ print $1 }'
}

find_lines()
{
    # Find lines matching $1
    res=-1
    if [ ! -z "$1" ]; then
        grep -i "$@" $BOOK
        res=$?
    fi
    return $res
}

list_items() 
{
    # 주어진 검색 기준과 일치하는 항목
    if [ "$#" -eq "0" ]; then
        echo -en "Search for: (return to list all) "
        read search
        if [ -z $search ]; then
            search="."
        fi
        echo
    else 
        search="$@"
    fi
    find_lines "${search}" | while read i
    do
        echo "$i" | tr ':' '\t\'
    done
    echo -en "Messages found: "
    num_lines "$search"
}

add_item() 
{
    echo "Add Item: You will be prompted for 3 items:"
    echo "  - Name, Phone, Email."
    echo
    echo -en "Name: "
    read name
    find_lines "^${name}:"
    if [ `num_lines "^${name}:"` -ne "0" ]; then
        echo "Sorry, $name already has an entry."
        return
    fi
    echo -en "Phone: "
    read phone
    echo -en "Email: "
    read email
    # Confirm
    echo "${name}:${phone}:${email}" >> $BOOK
}

locate_single_item()
{
    echo -en "Item to search for: "
    read search
    n=`num_lines "$search"`
    if [ -z "$n" ]; then
        n=0
    fi
    while [ "${n}" -ne "1" ]; do
        #list_items "$search"
        echo -en "${n} matches found. Please choose a "
        case "$n" in
            "0") echo "less" ;;
            "*") echo "more" ;;
        esac
        echo "specific search term (q to return to main): "
        read search
        if [ "$search" == "q" ]; then
            return 0
        fi
        n=`num_lines "$search"`
    done
    return `grep -in $search $BOOK |cut -d":" -f1`
}

remove_item() 
{
    locate_single_item
    # tail -n : 끝에서 n줄, tr A B : A 를 B로 치환
    search=`head -$? $BOOK | tail -1 | tr ' ' ','`
    if [ -z "{$search}" ]; then
        return
    fi
    list_items "$search"
    confirm "Remove?"
    if [ "$?" -eq "0" ]; then 
        grep -v "$search" $BOOK > ${BOOK}.tmp ; mv ${BOOK}.tmp ${BOOK}
    else 
        echo "NOT REMOVING"
    fi
}

edit_item() 
{
    locate_single_item
    search=`head -$? $BOOK | tail -1|tr ' ' '.'`
    if [ -z "${search}" ]; then
        return
    fi
    list_items "$search"
    this_line=`grep -i "$search" ${BOOK}`
    oldname=`echo $this_line|cut -d":" -f1`
    oldphone=`echo $this_line|cut -d":" -f2`
    oldmail=`echo $this_line|cut -d":" -f3`
    echo "SEARCH: $search"
    grep -v "$search" $BOOK > ${BOOK}.tmp ; mv ${BOOK}.tmp ${BOOK}
    echo -en "Name [ $oldname ]"
    read name
    if [ -z $name ]; then
        naem=$oldname
    fi
    find_lines "^${name}:"
    if [ `num_lines "^${name}:"` -ne "0" ]; then
        echo "Sorry, $name already has an entry."
        return
    fi
    echo -en "Phone [ $oldphone ] "
    read phone
    if [ -z "$phone" ]; then
        phone=$oldphone
    fi
    echo -en "Email [ $email ] "
    read email
    if [ -z "$email" ]; then
        email=$oldemail
    fi
    echo "${name}:${phone}:${email}" >> $BOOK
}