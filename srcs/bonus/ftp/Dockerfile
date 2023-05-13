FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vsftpd

ARG FTP_USER
ARG FTP_PASS

RUN mkdir -p /var/run/vsftpd/empty
RUN adduser $FTP_USER --disabled-password
RUN echo "$FTP_USER:$FTP_PASS" | chpasswd
RUN echo $FTP_USER > /etc/vsftpd.userlist

COPY conf/vsftpd.conf /etc

EXPOSE 21

CMD ["vsftpd", "/etc/vsftpd.conf"]
