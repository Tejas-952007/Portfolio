# Deploy Your Portfolio

Your site (HTML + Node.js backend) can be deployed to **Render** (recommended), **Railway**, or **Vercel**.

---

## Option 1: Render (recommended, free tier)

1. **Push your project to GitHub** (if not already):
   ```bash
   git init
   git add .
   git commit -m "Portfolio with backend"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Sign up**: Go to [render.com](https://render.com) and sign up (free) with GitHub.

3. **New Web Service**:
   - Dashboard → **New** → **Web Service**
   - Connect your GitHub repo (select the portfolio repo)
   - Use these settings:
     - **Name:** `portfolio` (or any name)
     - **Runtime:** `Node`
     - **Build Command:** `npm install`
     - **Start Command:** `npm start`
     - **Instance Type:** Free
   - Click **Create Web Service**

4. **Wait for deploy.** Render will build and run your app. Your site will be at:
   `https://YOUR-SERVICE-NAME.onrender.com`

5. **Optional – custom domain:** In the service → **Settings** → **Custom Domain**, add your domain.

**Note:** On the free tier the app may sleep after ~15 min of no traffic; the first request after that can be slow.

---

## Option 2: Railway

1. Go to [railway.app](https://railway.app) and sign in with GitHub.
2. **New Project** → **Deploy from GitHub repo** → select your portfolio repo.
3. Railway will detect Node.js and run `npm install` and `npm start`.
4. In the service → **Settings** → **Generate Domain** to get a public URL.

---

## Option 3: Vercel (static + serverless)

Vercel is great for static sites; the backend would need to be converted to **serverless functions**. If you want to keep your current Express server as-is, use Render or Railway instead.

To deploy only the **static site** (no contact form backend) on Vercel:
- Import the repo at [vercel.com](https://vercel.com).
- Set **Output Directory** to `.` and **Build Command** to empty (or use a simple static export). The contact form will not save messages unless you add Vercel serverless API routes later.

---

## After deployment

- **Contact form:** Submissions go to your backend; on Render/Railway they are stored in `data/contact.json` on the server. On free tiers the filesystem can reset on redeploy, so messages may not be permanent unless you add a database later.
- **View messages:** Call `GET https://YOUR-URL/api/contact` in the browser or add a simple admin page that uses this API.
- **HTTPS:** Render and Railway provide HTTPS by default.

---

## One-click deploy (Render Blueprint)

If your repo has the `render.yaml` file in the root:

1. Render Dashboard → **New** → **Blueprint**
2. Connect the repo; Render will read `render.yaml` and create the web service with the settings defined there.
