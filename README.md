# docker-alpine-umurmur

A small image to run a murmur server.

# Simplest use

```
docker run -t -p 64738:64738 -p 64738:64738/udp frituc/alpine-umurmur
```

# Configuration

You can configure umurmur either with mount a configuration file

```
docker run -t -p 64738:64738 -p 64738:64738/udp -v umurmur.conf:/etc/umurmur/umurmur.conf:ro frituc/alpine-umurmur
```

or by setting variables like :

```
docker run -t -p 64738:64738 -p 64738:64738/udp -e password=secret frituc/alpine-umurmur
```

If you choose the first option, set environment variables will have no effects and the mounted configuration file will not be altered

## Variable list

| Variable name     |  Description  |  Example value  |
| :------------     | :------------     | :-------------: |
| max_bandwidth     | | 48000 |
| welcometext       | | "Welcome to uMurmur!" |
| certificate       | | /etc/umurmur/cert.crt |
| private_key       | | /etc/umurmur/key.key |
| ca_path           | Location of CA certificate. Relevant for OpenSSL only. | /path/to/ca/certificates/ |
| password          | Can be empty | secret |
| admin_password    | Set to enable admin functionality. | test |
| ban_length        | Length in seconds for a ban. Default is 0. 0 = forever. | 0 |
| enable_ban        | | false |
| banfile           | File to save bans to. Default is to not save bans to file. | banfile.txt |
| sync_banfile      | # Keep banfile synced. Default is false, which means it is saved to at shutdown only. | false |
| allow_textmessage | | true |
| opus_threshold    | Required percentage of users that support Opus codec for it to be chosen | 100 |
| max_users         | | 10 |
| username          | username and groupname for privilege dropping. Will attempt to switch user if set. | murmur |
| groupname         | If groupname not set the user's default login group will be used | murmur |
| logfile           | Log to file option. Default is logging to syslog. umurmurd will close and reopen the logfile if SIGHUP is received. | /var/log/umurmurd.log |
