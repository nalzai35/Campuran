# Campuran

### catatan 1

```sh
mysqldump -u root namadb > db.sql

rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress  /var/www/ root@173.222.222.222:/var/www/

mysql -u root -p -h localhost namadb < db2.sql

chown -R www-data:www-data htdocs

service mysql info
mysqld_safe --skip-grant-tables > /dev/null 2>&1 &
mysql -u root -e "use mysql; update user set password=PASSWORD('gantipassword') where User='root'; flush privileges;"
service mysql restart

nano /etc/mysql/conf.d/my.cnf

ee secure --auth
```

## youtube-dl

### untuk download yt ke mp3

```youtube-dl --extract-audio --audio-format mp3 -o '%(id)s.%(ext)s' https://www.youtube.com/watch?v=x_OwcYTNbHs```

## Install AGC-youtube for ubuntu 18.04


```
$ apt update

# install ffmpeg 4.0.2
$ snap install ffmpeg

# install python
$ apt install python3 -y
$ alias python=python3
$ apt install python-pip -y
$ pip install --upgrade setuptools
$ pip install --upgrade google-api-python-client
$ pip install --upgrade oauth2client progressbar2

# install youtube-upload
$ wget https://github.com/tokland/youtube-upload/archive/master.zip
$ apt install unzip && unzip master.zip
$ cd youtube-upload-master && sudo python setup.py install
$ cd

# install google_images_download
$ pip install google_images_download

```
