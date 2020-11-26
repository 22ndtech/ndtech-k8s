FROM digitalocean/doctl:1.48.0
LABEL maintainer="Jeff@22ndtech.com"

ARG CONTEXT_PATH="/root"

ENV NDTECH_K8S_MODE ${NDTECH_K8S_MODE} \
  ENV RELATIVE_PROCESSING_PATH ${RELATIVE_PROCESSING_PATH} \
  ENV CONTEXT_PATH="${CONTEXT_PATH}" \
  ENV JX_NO_DELETE_TMP_DIR \
  ENV GITHUB_NDTECH_K8S_PIPELINE_EMAIL \
  ENV GITHUB_NDTECH_K8S_PIPELINE_TOKEN \
  ENV GITHUB_NDTECH_K8S_ADMIN_USERNAME \
  ENV GITHUB_NDTECH_K8S_ADMIN_TOKEN \
  ENV GITHUB_TOKEN="$GITHUB_NDTECH_K8S_ADMIN_TOKEN" \
  ENV HMAC_TOKEN="$GITHUB_NDTECH_K8S_PIPELINE_TOKEN" \
  ENV DIGITAL_OCEAN_INITIAL_TOKEN="$DIGITAL_OCEAN_INITIAL_TOKEN"

WORKDIR "${CONTEXT_PATH}"

RUN \
  # move doctl to the path
  echo "moving doctl to /usr/local/bin" \
  && mv /app/doctl /usr/local/bin \
  # install kubectl
  && echo "installing kubectl" \
  && cd "${CONTEXT_PATH}" \
  && curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
  && mv kubectl /usr/local/bin \
  && chmod +x /usr/local/bin/kubectl \
  && apk add git \ 
  && apk add python3 \
  && python3 -m ensurepip \
  && pip3 install --upgrade pip \
  && pip3 install yq \
  # install jenkins x
  && echo "installing jenkins x" \
  && curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent "https://github.com/jenkins-x/jx/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#')/jx-linux-amd64.tar.gz" | tar xzv "jx" \
  && mv jx /usr/local/bin \
  # install krew
  && echo "installing krew" \
  && ( \
    set -x; cd "$(mktemp -d)" \
    && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" \
    && tar zxvf krew.tar.gz \
    && KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" \
    && "$KREW" install krew \
  ) \
  && apk update \
  && apk add --upgrade ncurses \
  && PATH="${KREW_ROOT:-/root/.krew}/bin:$PATH" \
  # install ctx
  && echo "installing the ctx plugin for kubectl" \
  && kubectl krew install ctx \
  # install ns
  && echo "installing the ns plugin for kubectl" \
  && kubectl krew install ns \
  && curl -s https://toolkit.fluxcd.io/install.sh | sh

ENV PATH="${KREW_ROOT:-/root/.krew}/bin:$PATH"

RUN \
  echo "set up alias for kubectl" \
  # set up an alias for kubectl
  && echo "alias k='kubectl'" > ./.bashrc

COPY . .

ENV DO_EXTERNAL_DNS_TOKEN=${DO_EXTERNAL_DNS_TOKEN}
  
# neither ENTRYPOINT nor CMD can use the replacement syntax for some reason but it needs to match the context
ENTRYPOINT "execute.sh"