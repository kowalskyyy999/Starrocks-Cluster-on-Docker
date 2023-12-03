FROM starrocks-base:2.5.16

ARG USER=starrocks
ARG USER_UID=1000
ARG USER_GID=1000

ENV TZ="Asia/Jakarta"

WORKDIR /opt/starrocks

RUN mkdir be/storage && \
    echo bash /opt/starrocks/be/bin/stop_be.sh --daemon > "start_be_server.sh" && \
    echo bash /opt/starrocks/be/bin/start_be.sh --daemon >> "start_be_server.sh" && \
    echo sleep 5 >> "start_be_server.sh" && \
    echo tail -f /opt/starrocks/be/log/be.INFO >> "start_be_server.sh" && \
    chmod a+x start_be_server.sh 

RUN chown -R ${USER_UID}:${USER_GID} /opt/starrocks

WORKDIR /opt

VOLUME [ "/opt/starrocks/be" ]

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8040
EXPOSE 8060
EXPOSE 9050 
EXPOSE 9060

USER ${USER}

CMD /opt/starrocks/start_be_server.sh 