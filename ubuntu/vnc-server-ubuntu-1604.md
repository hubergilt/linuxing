# Configuring vino VNC Server in Ubuntu 16.04

## install required packages
```
sudo apt-get -y install vino
```

## configure vino VNC Server in Ubuntu 16.04
```
export DISPLAY=:0
gsettings set org.gnome.Vino enabled true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
```

## open vino VNC Server in Ubuntu 16.04
```
/usr/lib/vino/vino-server
```

