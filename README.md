<img src="https://codeberg.org/reesericci/united/media/branch/main/pictures/United.png" alt="United! A free and open system for collective organizations" width="674">

# United

United is free and open membership software for collective organizations, allowing robust tracking of membership, expirations, email broadcast tools, providing single-sign-on for your members, and more.

Copyright (C) 2024 [Software Freedom Conservancy](https://sfconservancy.org/assignment/90c1485a-f5ca-4b6c-ba1a-fded83d87cf3/) and United contributors

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see https://www.gnu.org/licenses/.

## Deploying with Fly.io

1. Clone this repository to your computer
2. Make an account with [fly.io](https://fly.io)
3. Install the fly.io CLI
4. Run `fly login` in the terminal
5. Run `rails credentials:edit` then press (CTRL/CMD)+X to exit the nano editor
6. Run `fly launch`
7. Enjoy!

## Details

- SQLite Database (No external DB needed)

- Ruby 3.3.0

- Site configuration handled through initial wizard


## TODOS (Roadmap-ish)

- [ ] Deploy to Heroku & Render buttons

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

## Screenshots

![Screenshot of the United dashboard in light mode](pictures/admin-members-light.png)
![Screenshot of the United dashboard in dark mode](pictures/admin-members-dark.png)
![Screenshot of the United join page in light mode](pictures/join.png)