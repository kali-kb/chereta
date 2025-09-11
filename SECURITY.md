# Security Best Practices for Chereta

## Environment Variables Security

### ✅ What We've Implemented

1. **`.env` in .gitignore**: Your `.env` file is ignored by git and won't be committed
2. **`.env.example` template**: Provides a template without sensitive data
3. **Environment variable loading**: Automatically loads variables in development
4. **Fallback values**: Config has safe defaults for development

### 🚨 Security Checklist

#### Before Committing Code:
- [ ] Verify `.env` is in `.gitignore`
- [ ] Check `git status` to ensure `.env` is not tracked
- [ ] Never commit files with hardcoded credentials
- [ ] Use `.env.example` for documenting required variables

#### For Production Deployment:
- [ ] Use Render's environment variables (not .env files)
- [ ] Generate new `SECRET_KEY_BASE` for production
- [ ] Use managed database services (like Render PostgreSQL)
- [ ] Enable SSL/TLS for all connections

#### Database Security:
- [ ] Use SSL connections (`sslmode=require`)
- [ ] Rotate passwords regularly
- [ ] Use least-privilege database users
- [ ] Monitor database access logs

### 🔐 Alternative Secure Methods

#### Option 1: System Environment Variables
```bash
export DB_USERNAME="your_username"
export DB_PASSWORD="your_password"
# ... other variables
mix phx.server
```

#### Option 2: Using direnv (Recommended for teams)
1. Install direnv: https://direnv.net/
2. Create `.envrc` file (also add to .gitignore)
3. Use `direnv allow` to load variables

#### Option 3: Encrypted Environment Files
Use tools like:
- `git-crypt` for encrypted files in git
- `blackbox` for encrypted secrets
- `ejson` for encrypted JSON configs

### 🚀 Production Security

For production on Render:
1. All secrets are managed by Render's environment system
2. Database credentials are auto-injected
3. SSL is enforced automatically
4. No local `.env` files are used

### 🔍 Security Audit Commands

Check for accidentally committed secrets:
```bash
# Check if .env is tracked
git ls-files | grep "\.env$"

# Search for potential secrets in code
grep -r "password\|secret\|key" --include="*.ex" --include="*.exs" .

# Check git history for secrets (use carefully)
git log --patch | grep -i "password\|secret\|key"
```

## Quick Security Fix

If you've accidentally committed secrets:
```bash
# Remove file from git history (DANGER: rewrites history)
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch .env' --prune-empty --tag-name-filter cat -- --all

# Force push (coordinate with team first!)
git push origin --force --all
```

Better approach:
1. Revoke/change the compromised credentials immediately
2. Remove secrets from future commits
3. Consider the git history compromised

## Remember
- **Secrets should never be in code or version control**
- **When in doubt, regenerate credentials**
- **Security is a team responsibility**