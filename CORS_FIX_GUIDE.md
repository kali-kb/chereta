# CORS Fix Guide for Production Deployment

## Problem
Your Netlify frontend can't access the Render backend due to CORS policy blocking requests.

## Solution Steps

### Step 1: Find Your Netlify URL
After deploying to Netlify, you'll get a URL like:
- `https://amazing-app-123456.netlify.app` (random name)
- `https://your-custom-name.netlify.app` (if you set a custom name)

### Step 2: Update Render Environment Variables
1. Go to your Render dashboard
2. Navigate to your `chereta` service
3. Go to "Environment" tab
4. Add a new environment variable:
   - **Key**: `FRONTEND_URL`
   - **Value**: Your actual Netlify URL (e.g., `https://your-app.netlify.app`)

### Step 3: Redeploy Backend
After adding the environment variable, Render will automatically redeploy your backend with the new CORS configuration.

## Alternative: Manual CORS Update
If you know your Netlify URL now, you can also manually update the CORS configuration:

1. Edit `lib/chereta_web/endpoint.ex`
2. Replace `"https://cheretaet.netlify.app"` with your actual Netlify URL
3. Commit and push to trigger Render redeploy

## Current CORS Configuration
The backend now supports:
- ✅ Development: `http://localhost:3000`
- ✅ Environment variable: `FRONTEND_URL` (recommended)
- ✅ Netlify patterns: `*.netlify.app` domains
- ✅ Backend self-reference: `https://chereta-b6kt.onrender.com`

## Testing
After the fix:
1. Open your Netlify frontend
2. Try to login
3. Check browser console for CORS errors
4. Verify login works properly

## Debug Steps
If still having issues:
1. Check Render logs for CORS messages
2. Verify `FRONTEND_URL` environment variable is set correctly
3. Ensure Netlify URL matches exactly (no trailing slashes)
4. Test with browser dev tools Network tab