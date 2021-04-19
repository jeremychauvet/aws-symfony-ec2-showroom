FROM public.ecr.aws/ubuntu/ubuntu:20.04

LABEL org.opencontainers.image.authors Jeremy Chauvet

# Install basics deps.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --no-install-recommends software-properties-common make ssh git curl wget=1.20.3-1ubuntu1 unzip=6.0-25ubuntu1 python3-pip sudo tmux -y && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
