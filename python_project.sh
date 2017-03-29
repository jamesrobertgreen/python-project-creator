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
        write_app_py
        write_gitignore
        write_setup_py
        write_readme
    fi
}

function create_files {
    files=("README.md" 
           "setup.py"
           "requirements.txt"
           ".gitignore"
           "$project_name/__init__.py"
           "$project_name/main.py"
           "$project_name/test/__init__.py"
           "$project_name/test/test_main.py"
           "$project_name/test/__init__.py" )

    dirs=("$project_name"
          "$project_name/test/" )
    for d in "${dirs[@]}"
    do
        echo "Creating directory $d"
        mkdir ${d}
    done
    for f in "${files[@]}"
    do
        echo "Creating file $f"
        touch $f
    done
}

function write_app_py {
    app_str=$'def main():\n\tprint(\'Hello\')\n\n\nif __name__ == \'__main__\':\n\tmain()'
    echo "$app_str" > "$project_name/main.py"
}

function write_gitignore {
    gitignore_str=$'.idea\n*.egg-info\nbuild\ndist'
    echo "$gitignore_str" > ".gitignore"
}

function write_setup_py {
    setup_str=$'from setuptools import setup\n\nsetup(name=\'project_name\',\n\tversion=\'1.0\',\n\tdescription=\'\',\n\tclassifiers=[\n\t\tProgramming Language :: Python :: 2.7\',\n\t\t\'License :: OSI Approved :: MIT License\',\n\t\t\'Intended Audience :: Developers\',\n\t],\n\turl=\'\',\n\tmaintainer=\'James Green\',\n\tmaintainer_email=\'jrgreen@gmail.com\',\n\tlicense=\'MIT\',\n\tpackages=[\'$project\'],\n\tsetup_requires[\'nose>=1.0\'],\n\ttests_require[\n\t\t\'mock\',\n\t\t\'nose>=1.0\',\n\t],\n\tentry_points={\n\t\t\'console_scripts\': [\n\t\t\'project_name = project_name.main:main\'\n\t\t\t]\n\t\t})'
    setup_str=$(echo $setup_str | sed "s/project_name/$project_name/g")
    echo "$setup_str" > "setup.py"
}

function write_readme {
    readme_str=$"#$project_name"
    echo "$readme_str" > "README.md"
}

main