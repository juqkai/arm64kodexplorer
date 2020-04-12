FROM yulinsoft/kodexplorer:arm64

COPY entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

