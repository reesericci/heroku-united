<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/United.png" alt="United! A free and open system for collective organizations" width="674">

# United!

![Release](https://img.shields.io/gitea/v/release/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org&color=brightgreen)
![Last Commit](https://img.shields.io/gitea/last-commit/reesericci/united?gitea_url=https%3A%2F%2Fcodeberg.org)
![License](https://img.shields.io/badge/license-AGPL--3.0--or--later-brightgreen)

United is free and open membership software for collective organizations, allowing robust tracking of membership, expirations, email broadcast tools, providing single-sign-on for your members, and more.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

## Deploying

I recommend that people use Railway to deploy United, as it has a free tier and an extremely easy setup process.

[<img src="https://railway.app/button.svg" height="32" alt="Deploy on Railway">](https://railway.app/template/UrEjLl?referralCode=_0Cj0x)

---

If you don't want to use Railway, here are some other options for cloud deployments:

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://www.heroku.com/deploy?template=https://github.com/reesericci/heroku-united)
[<img src="https://render.com/images/deploy-to-render-button.svg" height="32" alt="Deploy to Render">](https://render.com/deploy?repo=https://github.com/reesericci/heroku-united)
[<img src="https://fly.io/static/images/external/launch-on-flyio-button.svg" height="32" alt="Launch on Fly.io">](https://codeberg.org/reesericci/united/wiki/Deploying-to-Fly.io)


## Details

- SQLite Database by default (No external DB required)
  - Optional PostgreSQL support available by setting the `DATABASE_URL` environment variable

- Ruby 3.3.2

- Site configuration handled through initial wizard


## TODOS (Roadmap-ish, no particular order)

If you'd like, please feel free to take a task on here and send in a PR!

- [X] Deploy to [service] buttons
  - [X] Heroku
  - [X] Render
  - [X] Railway
  - [ ] [Digital Ocean](https://docs.digitalocean.com/products/app-platform/how-to/add-deploy-do-button/)
  - [ ] Nest

- [ ] Automated update system

- [ ] Self-hosted deployment instructions

- [X] OIDC provider

- [ ] Verify emails

- [ ] Unlimited membership length option

- [ ] Make normal API OAuth-based to consolidate between OIDC Provider w/Doorkeeper and normal API

- [ ] Warning emails for upcoming expirations, and allow for renewing of memberships (HIGH PRIORITY)

- [ ] CSV export of membership (HIGH PRIORITY)

- [ ] Triggers & Hooks

- [ ] Automated testing (RSpec)

- [X] Self-serve portal for editing membership data 

- [ ] Allow for fetching of identity login codes via TOTP app instead of email

- [ ] Easier SMTP setup/SMTP setup guidance with external provider (e.g. Postmark or SES)

- [ ] Approval queue for new members instead of automatic acceptance

- [ ] Surface errors to administrator via alerts (e.g. SMTP misconfiguration)

## Copyright

Copyright (C) 2024 [Software Freedom Conservancy](https://sfconservancy.org/assignment/90c1485a-f5ca-4b6c-ba1a-fded83d87cf3/) and United contributors

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.

## Screenshots

![Screenshot of the United dashboard in light mode](pictures/admin-members-light.png)
![Screenshot of the United dashboard in dark mode](pictures/admin-members-dark.png)
![Screenshot of the United join page in light mode](pictures/join.png)