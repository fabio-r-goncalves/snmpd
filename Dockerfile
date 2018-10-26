FROM ubuntu:18.04
EXPOSE 161/udp
RUN apt update
RUN apt install -y wget
RUN apt install -y nano
RUN apt install -y gcc
RUN apt install -y sed
RUN apt install -y file
RUN apt install -y make
RUN mkdir /net-snmp
RUN mkdir /usr/local/etc/snmp
VOLUME /usr/local/etc/snmp
ADD ./net-snmp-5.8 /
RUN apt install -y perl perl-base libperl-dev
RUN cd ./configure
RUN cd make
RUN cd make install
RUN ln -s /net-snmp/agent/.libs/libnetsnmpagent.so.35 /usr/lib/libnetsnmpagent.so.35
RUN ln -s /net-snmp/snmplib/.libs/libnetsnmp.so.35 /usr/lib/libnetsnmp.so.35
RUN ln -s /net-snmp/agent/.libs/libnetsnmpmibs.so.35 /usr/lib/libnetsnmpmibs.so.35
ADD ./snmpd.conf /home
ADD ./script.sh /
RUN chmod 777 script.sh
ENTRYPOINT ["./script.sh"]
