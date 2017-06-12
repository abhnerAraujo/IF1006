#!/bin/sh
if git --version &>/dev/null; 
then
    echo "setting up the ambient";
    mkdir -p "DEV";
    mkdir -p "TEST";
    mkdir -p "UAT";
    mkdir -p "PRODUCTION";
    echo "folders created";
    DIR="./DEV";
    if [ -n "$(ls -A "$DIR")" ];
    then
        echo "DEV directory is not empty"
    else
        echo "downloading repository into DEV folder...";
        cd "DEV";
        git clone "https://github.com/jfsc/spring-petclinic.git";
        echo "repository was clonned with success."
    fi
else
    echo "Git is needed to proceed, please install GIT first";
fi

