#!/bin/sh
AMBIENT_OK=true;
if hash git 2>/dev/null;
then
    echo "Git OK";
else
    echo "Git is not installed and is needed to proceed. Installing now...";
    echo "Getting Git. Press Y if asked to install."
    sudo apt-get install git;
    
    if hash git 2>/dev/null;
    then
        echo "Git OK";
    else
        AMBIENT_OK=false;
    fi
fi
if hash mvn 2>/dev/null;
then
    echo "Maven OK";
else
    echo "Maven is not installed and is needed to proceed. Installing now...";
    echo "Updating ambient...";
    sudo apt-get install software-properties-common;
    sudo apt-add-repository universe;
    sudo apt-get update;
    echo "Getting Maven. Press Y if asked to install."
    sudo apt-get install maven;
    if hash mvn 2>/dev/null;
    then
        echo "Maven OK";
    else
        AMBIENT_OK=false;
    fi
fi

if hash junit 2>/dev/null;
then
    echo "JUnit OK";
else
    echo "JUnit is not installed and is needed to proceed. Installing now..";
    sudo apt-get install junit;
    if hash junit 2>/dev/null;
        then
            echo "JUnit OK";
        else
            AMBIENT_OK=false;
        fi
fi

if [ "$AMBIENT_OK" = true ];
then
    echo "Setting the things up:"
    mkdir -p "DEV";
    mkdir -p "TEST";
    mkdir -p "UAT";
    mkdir -p "PRODUCTION";
    echo "Directories OK"
    
    echo "Getting project into DEV directory";
    
    if [ -n "$(ls -A "$DIR")" ];
    then
        echo "DEV directory is not empty"
    else
        echo "downloading repository into DEV folder...";
        cd "DEV";
        git clone "https://github.com/jfsc/spring-petclinic.git";
        echo "repository was clonned with success."
    fi
fi