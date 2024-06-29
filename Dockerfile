FROM ubuntu:jammy as base
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS solo
ARG TAGS
RUN addgroup --gid 1000 solo && \
    adduser --gecos '' --uid 1000 --gid 1000 --disabled-password solo && \
    echo "solo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/solo

USER solo
WORKDIR /home/solo

COPY . .
CMD ["sh", "-c", "ansible-playbook $TAGS bb-remote.yml"]

