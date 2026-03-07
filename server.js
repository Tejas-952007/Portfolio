const express = require('express');
const path = require('path');
const cors = require('cors');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

const DATA_DIR = path.join(__dirname, 'data');
const CONTACT_FILE = path.join(DATA_DIR, 'contact.json');
const PROJECTS_FILE = path.join(DATA_DIR, 'projects.json');

// Ensure data directory and files exist
if (!fs.existsSync(DATA_DIR)) fs.mkdirSync(DATA_DIR, { recursive: true });
if (!fs.existsSync(CONTACT_FILE)) fs.writeFileSync(CONTACT_FILE, '[]');
if (!fs.existsSync(PROJECTS_FILE)) fs.writeFileSync(PROJECTS_FILE, '[]');

function readJson(file) {
  try {
    return JSON.parse(fs.readFileSync(file, 'utf8'));
  } catch {
    return [];
  }
}

function writeJson(file, data) {
  fs.writeFileSync(file, JSON.stringify(data, null, 2), 'utf8');
}

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files (HTML, CSS, JS, images) from current directory
app.use(express.static(path.join(__dirname)));

// --- API Routes ---

// POST /api/contact - Save contact form message
app.post('/api/contact', (req, res) => {
  try {
    const { name, email, message } = req.body;
    if (!name || !email || !message) {
      return res.status(400).json({ success: false, error: 'Name, email and message are required.' });
    }
    const messages = readJson(CONTACT_FILE);
    messages.push({
      id: Date.now(),
      name: name.trim(),
      email: email.trim(),
      message: message.trim(),
      created_at: new Date().toISOString()
    });
    writeJson(CONTACT_FILE, messages);
    res.json({ success: true, message: 'Message sent successfully!' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, error: 'Failed to save message.' });
  }
});

// GET /api/contact - Get contact messages (for you to view)
app.get('/api/contact', (req, res) => {
  try {
    const messages = readJson(CONTACT_FILE);
    res.json({ success: true, messages: messages.reverse() });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, error: 'Failed to fetch messages.' });
  }
});

// GET /api/projects - Get all projects (for future admin/dynamic listing)
app.get('/api/projects', (req, res) => {
  try {
    const projects = readJson(PROJECTS_FILE);
    res.json({ success: true, projects });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, error: 'Failed to fetch projects.' });
  }
});

// POST /api/projects - Add a project (for future admin)
app.post('/api/projects', (req, res) => {
  try {
    const { title, problem_stat, approach, tech_stack, github_url, image_path, category } = req.body;
    const projects = readJson(PROJECTS_FILE);
    projects.push({
      id: Date.now(),
      title: title || '',
      problem_stat: problem_stat || '',
      approach: approach || '',
      tech_stack: tech_stack || '',
      github_url: github_url || '',
      image_path: image_path || '',
      category: category || 'web'
    });
    writeJson(PROJECTS_FILE, projects);
    res.json({ success: true, message: 'Project added.' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, error: 'Failed to add project.' });
  }
});

// Serve index.html for root
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Start server
app.listen(PORT, () => {
  console.log(`Portfolio backend running at http://localhost:${PORT}`);
});
