  #!/bin/bash -xe
  curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.21.14/2023-01-30/bin/darwin/amd64/kubectl
  chmod +x ./kubectl &&   mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
  echo 'export PATH=$PATH:$HOME/bin' >> ~/.bash_profile
  # for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
  ARCH=amd64
  PLATFORM=$(uname -s)_$ARCH

  curl -sLO "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

  # (Optional) Verify checksum
  curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

  tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

  sudo mv /tmp/eksctl /usr/local/bin 
