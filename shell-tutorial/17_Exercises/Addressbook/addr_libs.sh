# Global variables
BOOK=~/.addressbook
export BOOK

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

edit_item() 
{
    echo "called by edit_item"
}

remove_item() 
{
    echo "called by remove_item"
}