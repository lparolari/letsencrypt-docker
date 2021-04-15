# Let's Encrypt Docker

This is based on the amazing work done in [Nginx and Let’s Encrypt with Docker in Less Than 5 Minutes](https://pentacent.medium.com/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).

## Usage

1. Create the data file needed for the execution of nginx and certbot.

```bash
./install.sh example.org  # replace `example.org` with your server name
```

2. Run docker-compose

```bash
docker-compose up -d
```

After a min or so you should be able to see in `data/certbot/conf/live` the certificates that Certbot issued to you.

### Options

- `led_servername`. You can set the server name also by setting an environment variable. This overrides the script param.

## Author
