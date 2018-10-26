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
ADD ./net-snmp-5.8 /net-snmp
RUN apt install -y perl perl-base libperl-dev
RUN cd /net-snmp && ./configure
RUN cd /net-snmp && make
RUN cd /net-snmp make install
RUN ln -s /net-snmp/agent/.libs/libnetsnmpagent.so.35 /usr/lib/libnetsnmpagent.so.35
RUN ln -s /net-snmp/snmplib/.libs/libnetsnmp.so.35 /usr/lib/libnetsnmp.so.35
RUN ln -s /net-snmp/agent/.libs/libnetsnmpmibs.so.35 /usr/lib/libnetsnmpmibs.so.35
ADD ./snmpd.conf /usr/local/etc/snmp
ENTRYPOINT ["/usr/local/sbin/snmpd", "-Lo", "-f"]
