FROM beevelop/android

ENV NODE_VERSION=node_14.x
ENV CORDOVA_VERSION 11.0.0
ENV IONIC_VERSION 6.16.1
ENV NPM_VERSION=8.2.0

RUN apt-get update && apt-get install -y curl gnupg2 lsb-release git bzip2 openssh-client && \
    apt-get install -y curl git ca-certificates --no-install-recommends && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    apt-key fingerprint 1655A0AB68576280 && \
    export DISTRO="$(lsb_release -s -c)" && \
    echo "deb https://deb.nodesource.com/${NODE_VERSION} $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list && \
    echo "deb-src https://deb.nodesource.com/${NODE_VERSION} $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && \
    node -v && npm -v && \
    npm install -g yarn && \
    npm install -g npm@8.2.0 && \
    yarn -v && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm i -g --unsafe-perm cordova@${CORDOVA_VERSION} && \ 
    yes | cordova -v && \
    apt-get update && apt-get install -y build-essential python g++ make gyp && \
    $ANDROID_SDK_ROOT/tools/bin/sdkmanager --update && \
    npm install -g --unsafe-perm @ionic/cli@${IONIC_VERSION} && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get -qqy install google-chrome-stable \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*