#!/data/data/com.termux/files/usr/bin/bash
set -e

apt_fast_installation() {
  if ! dpkg-query --show aria2 >/dev/null 2>&1; then
    apt-get update
    apt-get install -y aria2
  fi

  mkdir -p $PREFIX/local/sbin $PREFIX/etc
  wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast -O $PREFIX/local/sbin/apt-fast
  chmod +x /usr/local/sbin/apt-fast
  if ! [[ -f /etc/apt-fast.conf ]]; then
    wget https://raw.githubusercontent.com/ilikenwf/apt-fast/master/apt-fast.conf -O $PREFIX/etc/apt-fast.conf
  fi
}


if [[ "$EUID" -eq 1 ]]; then
  echo 'Refusing to install as root.'
else
  DECL="$(declare -f apt_fast_installation)"
  bash -c "$DECL; apt_fast_installation"
fi
