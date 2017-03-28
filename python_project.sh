#!/bin/bash

function main {
    while [ "$project_name" == "" ]
    do
        echo "Please enter a name for the project "
        read project_name
    done

    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    read -p "Create project in current directory ${DIR}?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        create_files
    fi
}

function create_files {
    files=("README.md" 
           "setup.py"
           "requirements.txt"
           "$project_name/__init__.py"
           "$project_name/main.py"
           "$project_name/test/__init__.py"
           "$project_name/test/test_main.py"
           "$project_name/test/__init__.py" )

    for f in "${files[@]}"
    do
        echo $f
        echo ''
    done
}

main

