# SCRIPT IF1006

### 1 Passo:
Rodar comando de permissão para o script: `sudo chmod 777 script.sh`
### 2 Passo:
Rodar o script em si: `./script.sh`

O que acontece:

>Instala o Git (se não houver)

>Instala o Maven (se não houver)

>Instala o JUnit (se não houver)

>Crias as pastas: DEV PRODUCTION TEST UAT

>Clona o petclinic dentro de DEV

>Realiza o build da aplicação

>Instala o Docker (se não houver)

>Faz login no Docker

>Pergunta se quer construir uma nova imagem ou atualizar a padrão(ianfireman/petclininc)

>Apos isso é realizado o push para o docker hub

### 3 Passo(Google cloud):
A partir do momento que a imagem estava no docker hub foi criado uma vm no google cloud onde fizemos o `docker pull` da imagem
 e rodamos o `sudo docker run -i -t --expose=80 -p 80:8080 -h 10.150.0.2 ianfireman/spring-petclininc:part1` para deixar a aplicação rodando
  dentro do docker, atualmente rodando em: http://35.186.186.220/
  
foi bem complicado essa parte de deixar rodando devido a quantidade de parametros e documentção ambígua, ate chegarmos a esse comando levou bastante tempo, 
o comando em si significa: 

`sudo docker run -i -t --expose=80 -p 80:8080 -h 10.150.0.2 ianfireman/spring-petclininc:part1`

`sudo docker run -i -t --expose=IP_PARA_ACESSO_PUBLICO -p IP_PARA_ACESSO_PUBLICO:PORTA_ONDE_APP_ESTA_RODANDO_DENTRO_DO_DOCKER -h IP_INTERNO_GOOGLE_CLOUD IMAGEM`

### 4 Passo:
Sonar foi configurado e testado, porem foi separado do script

Docker hub: https://hub.docker.com/r/ianfireman/spring-petclinic/

Aplicacao rodando(google cloud): http://35.186.186.220/

Acesso precisa ser via http devido a falta de certificado


