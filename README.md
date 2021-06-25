# QuestDB DigitalOcean marketplace

This repository contains the source for the official QuestDB DigitalOcean
1-click image.

## Get started with a 1-Click Droplet

QuestDB is now available on the DigitalOcean marketplace. Set up a new QuestDB
droplet in one click here:

[![Create QuestDB droplet on DigitalOcean](.github/do-btn-blue.svg)](https://cloud.digitalocean.com/droplets/new?image=questdb-20-04)

This will allow you to configure the latest QuestDB version as a Droplet with
the configuration you need such as:

- A choice from 8 geographic regions to deploy to
- Persistent block storage
- Monitoring
- Credentials management for remote access (SSH)
- Backups
- Networking and VPC configuration

For new DigitalOcean users, our referral program offers \$100 account credit
with this link:

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=50d6b551562b&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)

## Building a custom DigitalOcean QuestDB image

To build an image using this repository, you need the following:

- [Packer](https://www.packer.io/)
- [DigitalOcean API key](https://cloud.digitalocean.com/account/api/tokens)

Firstly, Packer should be initialized:

```bash
$ packer init .
```

This command builds a snapshot in the DigitalOcean account associated with the
API key:

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
- `9003/tcp` - Health monitoring & Prometheus `/metrics`

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
