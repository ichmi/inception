FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget

RUN wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

WORKDIR /app

COPY conf/main.go ./
COPY conf/index.html ./
RUN /usr/local/go/bin/go mod init github.com/ichmi/app

RUN CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -o app

EXPOSE 8080

CMD ["./app"]
