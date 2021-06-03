# QuestDB DigitalOcean Marketplace image

Build a specific QuestDB version as a DigitalOcean 1-click image.

This repository contains all the necessary configuration the get started on DigitalOcean.

## Prerequisites

To work with this repository you need to install [Packer](https://www.packer.io/), and make sure that you have a DigitalOcean API key.

## Setup

``` bash
$ packer init .
```

## Build an image

To build a marketplace image for the latest QuestDB binary, run the following command:

```bash
$ DIGITALOCEAN_TOKEN="<YOUR API TOKEN>" packer build template.pkr.hcl
```

## Post setup

The firewall settings explicitly deny port 9000 for security reasons. In case you need the web interface, run `ufw allow 9000/tcp` on the droplet.
