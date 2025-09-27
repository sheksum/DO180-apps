#!/bin/bash
# Landscape job: cleanup old proxy configs

echo "[*] Cleaning proxy configs on $(hostname)..."

APT_CONF_DIR="/etc/apt/apt.conf.d"

# 1. Remove apt proxy files
if ls $APT_CONF_DIR/*proxy* $APT_CONF_DIR/*Proxy* &>/dev/null; then
  echo " - Removing apt proxy files from $APT_CONF_DIR"
  rm -f $APT_CONF_DIR/*proxy* $APT_CONF_DIR/*Proxy*
else
  echo " - No apt proxy files found in $APT_CONF_DIR"
fi

# 2. Remove proxy entries in /etc/apt/apt.conf
if [ -f /etc/apt/apt.conf ]; then
  echo " - Stripping proxy lines from /etc/apt/apt.conf"
  sed -i '/Acquire::.*Proxy/d' /etc/apt/apt.conf
fi

# 3. Remove proxy lines from /etc/environment
if [ -f /etc/environment ]; then
  echo " - Stripping proxy lines from /etc/environment"
  sed -i '/_proxy=/Id' /etc/environment
  sed -i '/_PROXY=/Id' /etc/environment
fi

# 4. Remove proxy scripts in /etc/profile.d
if ls /etc/profile.d/*proxy* &>/dev/null; then
  echo " - Removing proxy scripts in /etc/profile.d"
  rm -f /etc/profile.d/*proxy*
fi

# 5. Unset proxy variables for this session
unset http_proxy https_proxy ftp_proxy no_proxy
unset HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY
echo " - Proxy variables unset from current session"

# 6. Verify apt sees no proxy
if apt-config dump | grep -i Proxy; then
  echo "WARNING: proxy still present in apt config!"
else
  echo "No apt proxy configured"
fi

echo "[*] Cleanup complete."