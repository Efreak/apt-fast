#!/data/data/com.termux/files/usr/bin/bash
set -e

apt_fast_installation() {
  if ! dpkg-query --show aria2 >/dev/null 2>&1; then
    apt-get update
    apt-get install -y aria2
  fi

  mkdir -p $PREFIX/bin $PREFIX/etc
  wget https://raw.githubusercontent.com/efreak/apt-fast/master/apt-fast -O $PREFIX/bin/apt-fast
  chmod +x $PREFIX/bin/apt-fast
  if ! [[ -f $PREFIX/etc/apt-fast.conf ]]; then
    wget https://raw.githubusercontent.com/efreak/apt-fast/master/apt-fast.conf -O $PREFIX/etc/apt-fast.conf
  fi
}


if [[ "$EUID" -eq 1 ]]; then
  echo 'Refusing to install as root.'
else
  DECL="$(declare -f apt_fast_installation)"
  bash -c "$DECL; apt_fast_installation"
fi
