# Flock

Volunteer scheduling for churches — integrates with Planning Center.

## Features

- **Team & Position Management** — Create teams and define positions (e.g., Worship Team → Lead Vocals, Guitar, Sound Tech)
- **Event Scheduling** — Schedule events and assign volunteers to positions
- **Availability Management** — Volunteers set their weekly availability
- **Conflict Detection** — Warns when scheduling volunteers outside their available times
- **Assignment Workflow** — Volunteers can confirm or decline assignments
- **Email Notifications** — Automatic emails when volunteers are assigned
- **Planning Center Integration** — OAuth connection to import teams and people from PCO

## Tech Stack

- Ruby 3.2
- Rails 8
- PostgreSQL
- Tailwind CSS
- Hotwire/Turbo

## Setup
```bash
git clone https://github.com/camorford/flock.git
cd flock
bundle install
bin/rails db:setup
bin/dev
```

## Planning Center Integration

To enable PCO sync:

1. Create an OAuth app at [api.planningcenteronline.com](https://api.planningcenteronline.com/oauth/applications)
2. Set the callback URL to `http://localhost:3000/auth/planning_center/callback`
3. Add credentials:
```bash
bin/rails credentials:edit
```
```yaml
planning_center:
  client_id: your_client_id
  client_secret: your_client_secret
```

4. Click "Connect to Planning Center" in the app nav

## Screenshots

[Add screenshots here]

## License

MIT