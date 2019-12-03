FROM beevelop/ionic:v5.2.3

ENV NODEJS_VERSION=10.13.0 PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/android/tools:/opt/android/platform-tools:/opt/android/build-tools/27.0.0:/usr/share/ant/bin:/usr/share/maven/bin:/usr/share/gradle/bin:/opt/node/bin
WORKDIR /opt/node
RUN apt-get update && apt-get install -y curl git ca-certificates --no-install-recommends &&     curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1 &&     rm -rf /var/lib/apt/lists/* &&     apt-get clean
WORKDIR /tmp

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
