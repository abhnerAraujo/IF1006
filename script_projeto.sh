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

    cd spring-petclinic;
    mvn package;

fi

if hash docker 2>/dev/null;
then
    echo "Docker OK";
else
    echo "Docker is not installed and is needed to proceed. Installing now..";
    sudo apt-get update;
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D;
    sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main';
    sudo apt-get update;
    apt-cache policy docker-engine;
    sudo apt-get install -y docker-engine;
    
    if hash junit 2>/dev/null;
    then
        echo "Docker OK";
    else
        AMBIENT_OK=false;
    fi
fi
if [ "$AMBIENT_OK" = true ];
then
    echo "Tudo pronto!";
    sudo docker login;
    echo "Criar nova imagem[I] ou usar padrão[P]?";

    read imagem;
    
    if [ "$imagem" == "I"];
    then
        echo "digite o nome da imagem:";
        read imgnome;
        sudo docker build -t "$imgnome" .;
        echo "usuario do docker:"
        read user
        sudo docker tag "$imgnome" "$user"/"$imgnome";
        sudo docker push "$user"/"$imgnome";
        echo "Imagem $imgnome no dockerhub";
        
    else
        sudo docker build -t spring-petclininc .;
        sudo docker tag spring-petclininc ianfireman/spring-petclininc:v2;
        sudo docker push ianfireman/spring-petclininc:v2;
        echo "Imagem spring-petclininc no dockerhub";
    fi
    
else
    echo "Instalação do docker foi mal sucedida"
fi