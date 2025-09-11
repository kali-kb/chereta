# WSL Deployment Guide for Chereta

## WSL Environment Setup

Since you're running in WSL, here are the specific steps for your environment:

### Prerequisites

1. **Elixir and Erlang installed in WSL**:
   ```bash
   # Check versions
   elixir --version
   erl -version
   ```

2. **Git configured in WSL**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

### Making build.sh Executable in WSL

```bash
# Navigate to your project in WSL
cd /mnt/c/Users/USER/projects/elixir/chereta/chereta

# Make build script executable
chmod +x build.sh

# Verify permissions
ls -la build.sh
```

### WSL File System Considerations

1. **Use WSL paths for development**:
   ```bash
   # Work from WSL filesystem (faster)
   cp -r /mnt/c/Users/USER/projects/elixir/chereta ~/chereta
   cd ~/chereta/chereta
   ```

2. **Environment Variables**:
   - WSL can access Windows environment variables
   - .env file loading is configured for WSL paths
   - Database connections work from WSL to external services

### Development Workflow in WSL

```bash
# From WSL terminal
cd ~/chereta/chereta  # or your WSL project path

# Install dependencies
mix deps.get

# Create/migrate database
mix ecto.create
mix ecto.migrate

# Start server
mix phx.server
```

### WSL-Specific Configuration

The following are automatically handled:
- ✅ **Path resolution**: Updated .env loading for WSL paths
- ✅ **Line endings**: Git handles CRLF/LF conversion
- ✅ **File permissions**: build.sh made executable
- ✅ **Environment variables**: WSL-compatible loading

### Deployment from WSL

When deploying to Render:

1. **Commit from WSL**:
   ```bash
   git add .
   git commit -m "Deploy from WSL"
   git push origin main
   ```

2. **Render will use the WSL-compatible build.sh**

3. **Database connections work from both WSL and production**

### Troubleshooting WSL Issues

#### File Permission Issues:
```bash
# Fix permissions
chmod +x build.sh
find . -name "*.sh" -exec chmod +x {} \;
```

#### Environment Variable Issues:
```bash
# Check if .env is loaded
mix run -e "IO.inspect(System.get_env(\"DB_USERNAME\"))"
```

#### Path Issues:
```bash
# Use WSL paths instead of Windows paths
pwd  # Should show /home/username/... not /mnt/c/...
```

### WSL Performance Tips

1. **Use WSL filesystem** (not /mnt/c/) for better performance
2. **Install dependencies in WSL** rather than sharing with Windows
3. **Use WSL-native git** for version control

Your project is now configured to work optimally in the WSL environment!