![United! A free and open system for collective organizations](<United.png>)

# United

Free and open membership software for collective organizations

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

TODO: Deploy to Heroku & Render buttons [ ]

TODO: Automated update system [ ]

TODO: Self-hosted deployment instructions [ ]

~~TODO: OIDC provider [X]~~

TODO: Verify emails [ ]

TODO: Unlimited membership length option [ ]

TODO: Make normal API OAuth-based to consolidate between OIDC Provider w/Doorkeeper and normal API [ ]

TODO: Warning emails for upcoming expirations, and allow for renewing of memberships (HIGH PRIORITY) [ ]

TODO: CSV export of membership (HIGH PRIORITY) [ ]

## Screenshot

![Screenshot of the United dashboard](screenshot.png)