FROM alpine:latest

WORKDIR /root/
RUN apk update 
RUN apk add bash openssh-client curl tzdata

COPY ./get-cli.sh .
RUN chmod +x ./get-cli.sh
RUN bash ./get-cli.sh

COPY ./get-backup.sh .
RUN chmod +x ./get-backup.sh

RUN echo '0 5,19 * * * date && bash /root/get-backup.sh' >> /etc/crontabs/root
CMD crond -l 2 -f