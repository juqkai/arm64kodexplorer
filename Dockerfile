FROM yulinsoft/kodexplorer:arm64

COPY entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

USER 1000:501
EXPOSE 8080
ENTRYPOINT ["entrypoint.sh"]
CMD [ "php", "-S", "0000:8080", "-t", "/var/www/html" ]

