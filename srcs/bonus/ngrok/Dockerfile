FROM debian:buster

ARG AUTH_TOKEN

RUN apt-get update
RUN apt-get install -y wget

WORKDIR /tmp
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
RUN tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin

RUN ngrok config add-authtoken $AUTH_TOKEN

RUN echo "web_addr: 0.0.0.0:4040" >> /root/.config/ngrok/ngrok.yml

EXPOSE 4040

ENTRYPOINT ["ngrok", "http", "app:8080"]
