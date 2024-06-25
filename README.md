<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/United.png" alt="United! A free and open system for collective organizations" width="674">

# United!

![Release](https://img.shields.io/gitea/v/release/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org&color=brightgreen)
![Last Commit](https://img.shields.io/gitea/last-commit/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org)
![License](https://img.shields.io/badge/license-AGPL--3.0--or--later-brightgreen)
![Contributions Encouraged](https://img.shields.io/badge/contributions-encouraged-brightgreen)
[![wakatime](https://wakatime.com/badge/user/02e135ef-3334-4334-bed2-d93c78a66812/project/018efdd4-e497-4afc-a027-22c684b20171.svg)](https://wakatime.com/badge/user/02e135ef-3334-4334-bed2-d93c78a66812/project/018efdd4-e497-4afc-a027-22c684b20171)

United is free and open membership software for collective organizations, allowing robust tracking of membership, expirations, email broadcast tools, providing single-sign-on for your members, and more.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-members-light.png" width="30%" alt="Screenshot of the United dashboard in light mode"></img> <img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-members-dark.png" alt="Screenshot of the United dashboard in dark mode" width="30%"></img> <img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/join.png" width="30%"></img> <img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/kiosk-renew-light.png" alt="Screenshot of the United member kiosk requiring a renewal in light mode" width="30%"></img> <img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/kiosk-dark.png" alt="Screenshot of the United member kiosk in dark mode" width="30%"></img> <img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/admin-broadcasts-light.png" alt="Screenshot of the United broadcasts dashboard in light mode"
 width="30%"></img>

## Installation

> [!NOTE]
> United requires an external email (SMTP) server to send login codes & information to members. We recommend using [Postmark](https://postmarkapp.com) or another **transactional email** service for this. 

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
[<img src="https://render.com/images/deploy-to-render-button.svg" height="32" alt="Deploy to Render">](https://render.com/deploy?repo=https://github.com/reesericci/heroku-united)
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

## TODOS

If you'd like, please feel free to take a task on here and send in a PR!

- [ ] Verify emails
- [ ] Make normal API OAuth-based to consolidate between OIDC Provider w/Doorkeeper and normal API
- [ ] Triggers & Hooks
- [ ] Automated testing (RSpec)
- [X] Allow for fetching of identity login codes via TOTP app instead of email
- [ ] Easier SMTP setup/SMTP setup guidance with external provider (e.g. Postmark or SES)
  - [ ] Postmark setup wiki guide
- [ ] Approval queue for new members instead of automatic acceptance
- [ ] Surface errors to administrator via alerts (e.g. SMTP misconfiguration)
- [ ] Managed hosting service
- [ ] Getting started walkthrough videos
  - [X] Railway (Cloud IaaS)
  - [ ] Hetzner (Own VPS)
  - [ ] Bare Metal
- [ ] Trial/Demo Mode
- [X] Automated update system
- [X] Auxillary (Custom) Fields
- Deploy to [service] buttons
  - [X] Heroku
  - [X] Render
  - [X] Railway
- [X] Self-hosted deployment instructions
- [X] OIDC provider
- [X] Unlimited membership length option
- [X] Advisory emails for upcoming expirations, and allow for renewing of memberships (HIGH PRIORITY)
- [X] CSV export of membership (HIGH PRIORITY)
- [X] Self-serve portal for editing membership data


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
