![Build status](https://github.com/function61/infrastructureascode-image/workflows/Build/badge.svg)
[![Download](https://img.shields.io/docker/pulls/fn61/infrastructureascode.svg?style=for-the-badge)](https://hub.docker.com/r/fn61/infrastructureascode/)


What is this?
-------------

Docker image with:

- [Packer](https://www.packer.io) (to build VM images)
- [Terraform](https://www.terraform.io/) (to spin VMs from images)
- Various Terraform providers pre-downloaded:
  - Cloudflare
  - DigitalOcean
  - AWS
  - Hetzner

Used internally from James [function61/james](https://github.com/function61/james).


FAQ
---

Q: Why pre-download Terraform providers?

A: I don't like the idea of downloading plugins on-the-fly, because you never know what you
   get and Hashicorp doesn't have a great track record of not introducing regressions.
