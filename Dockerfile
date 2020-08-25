# sudo docker build -t fivefives .
# sudo docker run -d -p 1337:1337 --rm -it fivefives

FROM ubuntu:20.04
MAINTAINER unknonwn
LABEL Description="write-it" VERSION='1.0'

#installation
RUN apt update
RUN apt install -y socat
RUN apt install default-jre

#user
RUN adduser --disabled-password --gecos '' pwn
RUN chown -R root:pwn /home/pwn/
RUN chmod 750 /home/pwn

RUN touch /home/pwn/flag.txt

RUN export TERM=xterm

#Copying file
WORKDIR /home/pwn/
COPY ./Main.java /home/pwn
COPY flag.txt /home/pwn

#Setting perm..
RUN chown root:pwn /home/pwn/flag.txt
RUN chmod +x /home/pwn/Main.java
RUN chmod 440 /home/pwn/flag.txt

EXPOSE 1337

#Run the program with socat
CMD su pwn -c "socat TCP-LISTEN:1337,reuseaddr,fork EXEC:java /home/pwn/Main.java"
