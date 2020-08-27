FROM ubuntu
LABEL maintainer="Jeff@22ndtech.com"
WORKDIR /root

ENV AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID \
    ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY \
    ENV AWS_DEFAULT_REGION $AWS_DEFAULT_REGION

RUN \
    # update
    apt-get update -y \
    # upgrade
    && apt-get -y upgrade \
    # install pre-requisites
    && apt-get install -y curl \
    && apt-get install -y zip \
    && apt-get install -y unzip \
    && apt-get install -y python \
    # install aws-cli
    && cd /usr/src \
    && mkdir aws-cli \
    && cd aws-cli \
    && curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -b /usr/local/bin/aws \
    # install terraform
    && cd /root \
    && curl "https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip" -o "terraform_0.12.29_linux_amd64.zip" \
    && unzip terraform_0.12.29_linux_amd64.zip \
    && mv terraform /usr/local/bin

COPY . .

RUN \
    # set up the terraform folder and data
    mkdir terraform \
    && cd terraform \
    && mv /root/ndtech-k8s.tf ./
    
ENTRYPOINT ["/root/execute.sh"]
#CMD echo 'test'