gpg --no-symkey-cache pr.tar.gpg
tar xvf pr.tar &&
cp personal/cookies.sqlite ~/.mozilla/firefox/c0uxp8xo.default-release/
cp personal/iut.nmconnection /etc/NetworkManager/system-connections/
rm -r personal
rm pr.tar
chmod 600 /etc/NetworkManager/system-connections/iut.nmconnection
systemctl restart NetworkManager
