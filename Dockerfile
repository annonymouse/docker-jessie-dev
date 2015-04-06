FROM debian:jessie
# SALT MINION install
RUN apt-get update && apt-get install --yes \
    curl \
    git
# saltstack using runlevel detection to detect relevant services are enabled. 
# RUNLEVEL overrides this for container life.
RUN curl -L https://bootstrap.saltstack.com -o install_salt.sh \
        && export RUNLEVEL=2; sh install_salt.sh -U
# Install my saltconfig
RUN git clone https://github.com/annonymouse/salt-config /root/salt-config \
    && salt-call --local -m /root/salt-config \
        --file-root /root/salt-config state.highstate
# Install homeshick + my vimplugins.  Homeshick irritatingly doesn't let you
# automate the symlinking on clone, as force and batch don't force it to
# happen -- so i need a separate step.
RUN git clone \
        git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick \
    && $HOME/.homesick/repos/homeshick/bin/homeshick \
        clone --force --batch annonymouse/vim-castle annonymouse/dotfiles \
    && $HOME/.homesick/repos/homeshick/bin/homeshick link --force



