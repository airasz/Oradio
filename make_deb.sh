#!/bin/sh

# This script will create a deb package for Oradio

packageVersion=$(printf "0.1.0.r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")

# Create file structure

mkdir -pv packaging/DEBIAN
mkdir -pv packaging/var/lib/mpd/playlists
mkdir -pv packaging/var/www/html/radio
mkdir -pv packaging/usr/bin
mkdir -pv packaging/etc


# Copy files to corresponding directories

cp -vf src/radio.m3u packaging/var/lib/mpd/playlists
cp -vf src/oradio.js packaging/var/www/html/radio
cp -vf src/oradio.php packaging/var/www/html/radio
cp -vf src/index.html packaging/var/www/html/radio
cp -vf src/style.css packaging/var/www/html/radio
cp -vf src/oradio.sh packaging/usr/bin
cp -vf src/mpd.conf packaging/etc/
cp -vf src/oradio.postinst packaging/DEBIAN/


# Create control file

echo "Package: oradio
Version: ${packageVersion}
Architecture: all
Maintainer: airasz
Depends: mpc,mpd,apache2,php,python3 (>=3.6)
Priority: optional
Homepage: https://github.com/airasz/oradio
Description: internet Radio using mpc mpd" > packaging/DEBIAN/control

# Build the package

dpkg-deb --build packaging

# Rename the package

mv packaging.deb Oradio-${packageVersion}.deb
