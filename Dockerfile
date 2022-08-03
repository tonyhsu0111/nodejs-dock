FROM centos:centos7
RUN yum install sudo openssh openssh-server net-tools bind-utils -y && \
sed -i -e 's/^\(%wheel\s\+.\+\)/#\1/gi' /etc/sudoers && \
echo -e '\n%wheel ALL=(ALL) ALL' >> /etc/sudoers && \
echo -e '\nDefaults:root   !requiretty' >> /etc/sudoers && \
echo -e '\nDefaults:%wheel !requiretty' >> /etc/sudoers && \
chmod u+s /usr/bin/sudo && chmod a+x /usr/bin/sudo && \
ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' && \
ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N '' && \
sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config 
WORKDIR /home/node/

# Install nvm with node and npm
# install nvm
# https://github.com/creationix/nvm#install-script
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 12.22.12
#ENV NODE_VERSION 14.16.1
#ENV NODE_VERSION 16.15.0
ENV NVM_VERSION v0.31.7
RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash \
  && source $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN node --version
RUN npm --version
#RUN npm install -g npm@6.14.12 && npm install -g yarn
#RUN npm install -g npm@8.10.0 && npm install -g yarn

#ENTRYPOINT "/usr/sbin/sshd -D"

#CMD ["sh", "/etc/rc.local"]
CMD /usr/sbin/sshd -D