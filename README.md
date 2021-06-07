# QuestDB DigitalOcean Marketplace image

Build a specific QuestDB version as a DigitalOcean 1-click image.

This repository contains all the necessary configuration the get started on
DigitalOcean.

## Prerequisites

To work with this repository you need to install
[Packer](https://www.packer.io/), and make sure that you have a DigitalOcean API
key.

## Setup

```bash
$ packer init .
```

## Build an image

To build a marketplace image for the latest QuestDB binary, run the following
command:

```bash
$ DIGITALOCEAN_TOKEN="<YOUR API TOKEN>" packer build template.pkr.hcl
```

## Post setup

The firewall settings in the image are managed by
[ufw](https://help.ubuntu.com/community/UFW) and have the following ports
enabled by default:

- `22` for ssh access
- `9009` - InfluxDB line protocol (TCP and UDP)
- `9000/tcp` - Web Console & REST API
- `8812/tcp` - PostgreSQL wire protocol
- `9003/tcp` - Health monitoring port

It's recommended to disable ports for protocols which are not needed. Aside from
[QuestDB server configuration](https://questdb.io/docs/reference/configuration#keys-and-default-values),
`ufw` can be used to easily disable access for specific ports, for example to
disable the Web Console and REST API access via `ufw`, the following command can
be run:

```bash
ufw deny 9000
```

It's also recommended to use
[DigitalOcean firewall rules](https://cloud.digitalocean.com/networking/firewalls)
which enable public access for these protocols by whitelisted IP only.
