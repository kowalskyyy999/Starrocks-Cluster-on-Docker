FROM starrocks-base:3.3.0

ARG USER=starrocks
ARG USER_UID=1000
ARG USER_GID=1000

WORKDIR /opt/starrocks

RUN apt-get install ca-certificates -y && \
    mkdir /etc/pki && \
    mkdir /etc/pki/tls && \
    mkdir /etc/pki/tls/certs && \
    cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

RUN mkdir fe/meta  &&\
    echo bash /opt/starrocks/fe/bin/stop_fe.sh --daemon > "start_server_fe.sh" && \
    echo bash /opt/starrocks/fe/bin/start_fe.sh --daemon >> "start_server_fe.sh" && \
    echo sleep 5 >> "start_server_fe.sh" && \
    echo tail -f /opt/starrocks/fe/log/fe.log >> "start_server_fe.sh" && \
    chmod a+x start_server_fe.sh 

RUN chown -R ${USER_UID}:${USER_GID} /opt/starrocks

WORKDIR /opt

VOLUME [ "/opt/starrocks/fe" ]

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8030
EXPOSE 9010
EXPOSE 9020
EXPOSE 9030

USER ${USER}

CMD /opt/starrocks/start_server_fe.sh
