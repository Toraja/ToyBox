FROM ubuntu:latest

# `unminimize` is required to use `man`
RUN yes | unminimize
# Official Debian and Ubuntu images automatically run apt-get clean, so explicit invocation is not required.
# Set up to install docker and add PPA
RUN apt-get update && apt-get install --no-install-recommends --yes \
    apt-transport-https ca-certificates curl gnupg lsb-release \
    software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-add-repository ppa:fish-shell/release-3
# Install docker and other packages
# ctags required by Tagbar vim plugin
RUN apt-get update && apt-get install --no-install-recommends --yes \
    sudo less man locales openssh-client fish \
    docker-ce docker-ce-cli containerd.io python3-pip \
    neovim git tmux keychain fzf xclip ctags \
    && rm -rf /var/lib/apt/lists/*

# Without this, `man` complains that $LC_* is not set
RUN locale-gen en_US.UTF-8

RUN pip install docker-compose

ARG USER
RUN useradd --create-home --groups docker --shell /usr/bin/fish ${USER} \
    && echo "%"${USER}" ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}
USER ${USER}

WORKDIR /home/${USER}

# git
COPY --chown=${USER}:${USER} ./gitconfig .gitconfig
RUN git clone https://github.com/Toraja/toybox.git

# fish
RUN fish -c 'curl -sL https://git.io/fisher | source && fisher install \
    jorgebucaran/fisher \
    decors/fish-colored-man \
    gazorby/fish-abbreviation-tips \
    laughedelic/fish_logo \
    laughedelic/pisces \
    markcial/upto \
    oh-my-fish/plugin-pj' \
    && ln -s ~/toybox/fish/functions ~/.config/fish/myfuncs
COPY --chown=${USER}:${USER} ./config.fish .config/fish/

# tmux
COPY --chown=${USER}:${USER} ./tmux.conf .tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
    && ~/.tmux/plugins/tpm/bin/install_plugins

# vim
# pynvim required by deoplote.nvim
RUN python3 -m pip install --user --upgrade pynvim \
    && mkdir -p .config/nvim .vim/swap .vim/bundle \
    && ln -s ~/toybox/nvim/init.vim ~/.config/nvim/ \
    && ln -s ~/toybox/nvim/ginit.vim ~/.config/nvim/ \
    && ln -s ~/toybox/vim/after ~/.vim/after \
    && ln -s ~/toybox/vim/autoload ~/.vim/autoload \
    && ln -s ~/toybox/vim/ftdetect ~/.vim/ftdetect \
    && ln -s ~/toybox/vim/ftplugin ~/.vim/ftplugin \
    && ln -s ~/toybox/vim/UltiSnips ~/.vim/UltiSnips \
    && git clone https://github.com/junegunn/vim-plug.git .vim/bundle/vim-plug

# Setup symlink to host home directory to reduce bind mount
# This also enables replacing those links with actual files when symlink is inappriate
# Here cloned toybox directory is moved so that it can be used in case host's toybox is unavailable
RUN mkdir ~/build \
    && mv ~/toybox ~/build/ \
    && ln -s ~/hosthome/workspace ~/workspace \
    && ln -s ~/hosthome/.ssh ~/.ssh \
    && ln -s ~/hosthome/.docker ~/.docker \
    && ln -s ~/hosthome/toybox ~/toybox

CMD ["tail", "-f", "/dev/null"]
