# Portfolio Backend

Backend for your portfolio website. Serves the site and stores contact form messages.

## Run

```bash
npm install
npm start
```

Then open **http://localhost:3000** in your browser.

## API

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST   | `/api/contact` | Save a contact form message (body: `name`, `email`, `message`) |
| GET    | `/api/contact` | List all contact messages |
| GET    | `/api/projects` | List projects (for future use) |
| POST   | `/api/projects` | Add a project (for future admin) |

## Data

- Contact messages: `data/contact.json`
- Projects: `data/projects.json`

To view messages, open `data/contact.json` or call `GET /api/contact` (e.g. in browser or Postman).

## Port

Default port is **3000**. Override with:

```bash
PORT=8080 npm start
```
