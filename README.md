<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/United.png" alt="United! A free and open system for collective organizations" width="674">

# United!

![Release](https://img.shields.io/gitea/v/release/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org&color=brightgreen)
![Last Commit](https://img.shields.io/gitea/last-commit/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org)
![License](https://img.shields.io/badge/license-AGPL--3.0--or--later-brightgreen)
![Contributions Encouraged](https://img.shields.io/badge/contributions-encouraged-brightgreen)
[![wakatime](https://wakatime.com/badge/user/02e135ef-3334-4334-bed2-d93c78a66812/project/018efdd4-e497-4afc-a027-22c684b20171.svg)](https://wakatime.com/badge/user/02e135ef-3334-4334-bed2-d93c78a66812/project/018efdd4-e497-4afc-a027-22c684b20171)
![Code Coverage](https://codeberg.org/reesericci/united/media/branch/main/coverage/coverage_badge_total.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/ce969661e4948733fdb0/maintainability)](https://codeclimate.com/github/reesericci/heroku-united/maintainability)

![Produced By Human, Not by AI](https://codeberg.org/reesericci/united/media/branch/main/pictures/Produced-By-Human-Not-By-AI-Badge-white.svg)

United is free and open membership software for collective organizations, allowing robust tracking of membership, expirations, email broadcast tools, providing single-sign-on for your members, and more.

<a class="ui basic labeled button" href="https:///demo.united.obl.ong">Open demo! ↗</a>

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-members-light.png" width="30%" alt="Screenshot of the United dashboard in light mode"></img><img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-members-dark.png" alt="Screenshot of the United dashboard in dark mode" width="30%"></img><img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/join.png" width="30%"></img><img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/my-renew-light.png" alt="Screenshot of the United member my requiring a renewal in light mode" width="30%"></img><img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/my-dark.png" alt="Screenshot of the United member my in dark mode" width="30%"></img><img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-broadcasts-light.png" alt="Screenshot of the United broadcasts dashboard in light mode"
 width="30%"></img>

## Demo

A fully functional demo is available at [demo.united.obl.ong](https://demo.united.obl.ong)! 

> [!WARNING]
> All data resets every 30 minutes on the hour and at the 30-minute mark.

<a class="ui basic labeled button" href="https:///demo.united.obl.ong">Open demo! ↗</a>

## Installation

> [!NOTE]
> United requires an external email (SMTP) server to send login codes & information to members. We recommend using [Postmark](https://postmarkapp.com) or another **transactional email** service for this.
>
> For instructions on how to get the SMTP **token** for a Postmark server, click [here](https://postmarkapp.com/support/article/1207-how-to-create-and-send-through-message-streams#sendingsmtp). Be sure to use a "Broadcast" message stream for compliance.

> [!WARNING]
> Do not use Gmail or similar personal mail services for United.

### Cloud (IaaS)

#### Railway

I recommend that people use Railway to deploy United, as it has a free tier and an extremely easy setup process.

[<img src="https://railway.app/button.svg" height="32" alt="Deploy on Railway">](https://railway.app/template/eqEBYm?referralCode=_0Cj0x)

Here's a video of me spinning up a United instance in less than 10 minutes on Railway:

<video controls="" src="https://codeberg.org/reesericci/united/media/branch/main/pictures/United-Railway.webm" width="500">
  <strong>Your browser does not support the HTML5 "video" tag.</strong>
</video>

#### Others

If you don't want to use Railway, here are some other options for cloud deployments:

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://www.heroku.com/deploy?template=https://github.com/reesericci/heroku-united)
[<img src="https://render.com/images/deploy-to-render-button.svg" height="32" alt="Deploy to Render" style="border-radius: 6px;">](https://render.com/deploy?repo=https://github.com/reesericci/heroku-united)
[<img src="https://fly.io/static/images/external/launch-on-flyio-button.svg" height="32" alt="Launch on Fly.io">](https://codeberg.org/reesericci/united/wiki/Deploying-to-Fly.io)

### Computer

#### Automated

> [!CAUTION]
> The automated install script expects a **dedicated computer or virtual machine** with ports 80 and 443 available.

You can use our simple automated script to install United onto any ol' computer or server running Linux with Docker. I highly recommend this option as it allows for minimizing recurring costs and full control.

Just paste the following in the terminal and answer a few short questions!

```
bash <(curl -s https://codeberg.org/reesericci/united/raw/branch/main/bin/install)
```

To install Linux on a computer, please visit the [Fedora Server install guide](https://docs.fedoraproject.org/en-US/fedora-server/installation/).

---

## Details

- SQLite Database by default (No external DB required)
  - Optional PostgreSQL support available by setting the `DATABASE_URL` environment variable
- Ruby 3.3.2
- Rails edge (main branch)
- Site configuration handled through initial wizard
- We relentlessly aim for:
  - Simple deployment
  - Low-maintainance stability

## Versioning

We use [Brett Uglow's SemVer for end-user software applications](https://uglow.medium.com/making-sense-of-semantic-versioning-for-end-user-software-applications-a3049d97478b), to version this application:

```
Given the importance of the installation-requirements of an application to installer-users, I propose that semver be used to version end-user applications using the installation-requirements as the public API with installer-users as the consumers of this API.

In practice, increment the:

    MAJOR version when you make incompatible API changes (e.g. installer-users have to modify their infrastructure (phone/tablet/PC/web-server/firewall config/etc) in some way),
    MINOR version when you add functionality in a backwards-compatible manner (e.g. passing additional data to an already-provisioned API or adding any end-user functionality that does not affect the installation-requirements), and
    PATCH version when you make backwards-compatible bug fixes (e.g. fixing any end-user bug that does not affect the installation requirements).
```

## Copyright

Copyright (C) 2024 [Software Freedom Conservancy](https://sfconservancy.org/assignment/90c1485a-f5ca-4b6c-ba1a-fded83d87cf3/) and United contributors

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.

---

This site is a member of the Hard Fork webring

[![Previous Site](https://codeberg.org/reesericci/united/media/branch/main/pictures/button\(3\).png)](https://webri.ng/webring/hardfork/previous?via=https://united.obl.ong)
[![Random!](https://codeberg.org/reesericci/united/media/branch/main/pictures/button\(4\).png)](https://webri.ng/webring/hardfork/random?via=https://united.obl.ong)
[![Next Site](https://codeberg.org/reesericci/united/media/branch/main/pictures/button\(2\).png)](https://webri.ng/webring/hardfork/next?via=https://united.obl.ong)
