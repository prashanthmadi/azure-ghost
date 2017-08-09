FROM ghost:1.5

# Install openssh for web-ssh access from kudu
RUN apt-get update && apt-get install \
      --no-install-recommends --no-install-suggests -y \
      openssh-server \
	  supervisor \
      && echo "root:Docker!" | chpasswd

COPY sshd_config /etc/ssh/
COPY init-container.sh /bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf	

EXPOSE 2222
CMD ["/bin/init-container.sh"]