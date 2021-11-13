#!/bin/bash
## Hey Deviant, why did you edit BreachParse.sh? It was working fine for me!
## Hi guy, because it was not outputting everything I wanted when searching password breaches on an engagement and I craved moar. 
## Additionally, I found that using ripgrep was significanty faster than grep or python throughout my testing.

if ! command -v rg &> /dev/null
then
    echo "This script utilizes ripgrep which you don't appear to have installed :("
    exit 1
fi

if [ $# -lt 2 ]; then
    echo 'Breach-RIP: A Breached Domain Parsing Tool originally by Heath Adams'
    echo 'Modified and > Breach-RIP by Dominic (Deviant)'
    echo 'Usage: ./breach-rip.sh <domain to search> <file to output> [breach data location]'
    echo 'Example: ./breach-rip.sh @gmail.com gmail.txt'
    echo 'Example: ./breach-rip.sh @gmail.com gmail.txt "~/Downloads/BreachCompilation/data"'
    echo 'You only need to specify [breach data location] if its not in the expected location (/opt/breach-rip/BreachCompilation/data)'
    echo " "
    echo 'For multiple domains: ./breach-rip.sh "[domain to search]|[domain to search]" <file to output>'
    echo 'Example: ./breach-rip.sh "@gmail.com|@yahoo.com" multiple.txt'
    exit 1
else
    if [ $# -ge 4 ]; then
        echo 'You supplied more than 3 arguments, make sure to double quote your strings:'
        echo 'Example: ./breach-rip.sh @gmail.com gmail.txt "~/Downloads/Temp Files/BreachCompilation"'
        exit 1
    fi

    # assume default location
    breachDataLocation="/opt/breaches/"
    # check if BreachCompilation was specified to be somewhere else
    if [ $# -eq 3 ]; then
        if [ -d "$3" ]; then
            breachDataLocation="$3"
        else
            echo "Could not find a directory at ${3}"
            echo 'Pass the BreachCompilation/data directory as the third argument'
            echo 'Example: ./breach-rip.sh @gmail.com gmail.txt "~/Downloads/BreachCompilation/data"'
            exit 1
        fi
    else
        if [ ! -d "${breachDataLocation}" ]; then
            echo "Could not find a directory at ${breachDataLocation}"
            echo 'Put the breached password list there or specify the location of the BreachCompilation/data as the third argument'
            echo 'Example: ./breach-rip.sh @gmail.com gmail.txt "~/Downloads/BreachCompilation/data"'
            exit 1
        fi
    fi

    # set output filenames
    fullfile=$2
    fbname=$(basename "$fullfile" | cut -d. -f1)
    main=$fbname-main.txt
    emails=$fbname-emails.txt
    users=$fbname-users.txt
    passwords=$fbname-passwords.txt

    touch $main
    # count files for progressBar
    # -not -path '*/\.*' ignores hidden files/directories that may have been created by the OS
    total_Files=$(find "$breachDataLocation" -type f -not -path '*/\.*' | wc -l)
    file_Count=0

    function ProgressBar() {

        let _progress=$(((file_Count * 100 / total_Files * 100) / 100))
        let _done=$(((_progress * 4) / 10))
        let _left=$((40 - _done))

        _fill=$(printf "%${_done}s")
        _empty=$(printf "%${_left}s")

        printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"

    }

    # grep for passwords
    find "$breachDataLocation" -type f -not -path '*/\.*' -print0 | while read -d $'\0' file; do
        rg "$1" "$file" | sed 's/ //g' >>$main
        ((++file_Count))
        ProgressBar ${number} ${total_Files}

    done
fi

sleep 3

## Extract emails, usernames, and passwords from here
echo # newline
echo 'Extracting email addresses...'
rg -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b' $main >$emails

sleep 1

echo 'Extracting usernames...'
sed 's/@.*//' $emails >$users

sleep 1

# This works best with combolists.. If your breach has some weird formatting then this may get a little rough - refer to main.
echo 'Extracting passwords...'
awk -F':'  '{print $3,$NF}' $main | sed 's/ //g' >$passwords
echo
exit 0
