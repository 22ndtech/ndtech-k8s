FROM ubuntu
LABEL maintainer="Jeff@22ndtech.com"

ARG CONTEXT_PATH="/root"

ENV CONTEXT_PATH="${CONTEXT_PATH}"
ENV NDTECH_K8S_MODE ${NDTECH_K8S_MODE}
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
ENV GOOGLE_APPLICATION_CREDENTIALS /ndtech-k8s-admin-key.json

WORKDIR "${CONTEXT_PATH}"

RUN \
  # update
  apt-get update -y \
  # upgrade
  && apt-get -y upgrade \
  # install pre-requisites
  && echo "installing pre-requisites" \
  && apt-get install -y git \
  && apt-get install -y curl \
  && apt-get install -y python \
  # install pip
  && echo "starting install pip" \
  && curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" \
  && python get-pip.py \
  # install gcp-cli
  && cd "${CONTEXT_PATH}" \
  && mkdir gcp-cli \
  && cd gcp-cli \
  && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-309.0.0-linux-x86_64.tar.gz \
  && tar -zxvf google-cloud-sdk-309.0.0-linux-x86_64.tar.gz google-cloud-sdk \
  # install terraform
  && apt-get install -y unzip \
  && cd /root \
  && curl "https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip" -o "terraform_0.13.4_linux_amd64.zip" \
  && unzip terraform_0.13.4_linux_amd64.zip \
  && mv terraform /usr/local/bin \
  # install gccloud
  && ${CONTEXT_PATH}/gcp-cli/google-cloud-sdk/install.sh --usage-reporting false --command-completion true --path-update true -q \
  # install jx
  && curl -L https://github.com/jenkins-x/jx-cli/releases/download/v3.0.574/jx-cli-linux-amd64.tar.gz | tar xzv \
  && mv jx /usr/local/bin \
  # install kubectl
  && cd "${CONTEXT_PATH}" \
  && curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
  && mv kubectl /usr/local/bin \
  && chmod +x /usr/local/bin/kubectl

COPY . .

# neither ENTRYPOINT nor CMD can use the replacement syntax for some reason but it needs to match the context
ENTRYPOINT "${CONTEXT_PATH}/execute.sh"