# Chereta Production Deployment Guide

## 🚀 Your Deployed Phoenix API

**Production URL**: `https://[YOUR-APP-NAME].onrender.com`

### Available Endpoints

#### Health Check
- **URL**: `https://[YOUR-APP-NAME].onrender.com/api/health`
- **Method**: GET
- **Purpose**: Check if your API and database are running
- **Response**: 
  ```json
  {
    "status": "ok",
    "timestamp": "2025-01-12T10:30:00Z",
    "service": "chereta-api",
    "database": "connected",
    "version": "0.1.0"
  }
  ```

#### Main API Endpoints
- `POST /api/login` - User authentication
- `GET /api/categories` - List categories
- `POST /api/categories` - Create category
- `POST /api/categories/batch` - Batch create categories
- `GET /api/items/:item_id` - Get item details
- `POST /api/users/:user_id/items` - Create auction item
- `POST /api/users/:user_id/items/:item_id/bids` - Place bid

#### WebSocket Endpoint
- **URL**: `wss://[YOUR-APP-NAME].onrender.com/socket`
- **Purpose**: Real-time bidding and presence tracking

## 🌐 Frontend Configuration

### Development (.env)
```env
VITE_DEV_BACKEND_URL=http://localhost:4002
VITE_DEV_SOCKET_URL=ws://localhost:4002/socket
VITE_UPLOAD_PRESET=[YOUR_UPLOAD_PRESET]
VITE_CLOUD_NAME=[YOUR_CLOUD_NAME]
```

### Production (.env.production)
```env
VITE_DEV_BACKEND_URL=https://[YOUR-APP-NAME].onrender.com
VITE_DEV_SOCKET_URL=wss://[YOUR-APP-NAME].onrender.com/socket
VITE_UPLOAD_PRESET=[YOUR_UPLOAD_PRESET]
VITE_CLOUD_NAME=[YOUR_CLOUD_NAME]
```

## 🔧 Configuration Updates Made

### 1. Health Check Endpoint Added
- **File**: `lib/chereta_web/controllers/health_controller.ex`
- **Route**: `GET /api/health`
- **Purpose**: Monitor service health for production

### 2. CORS Configuration Updated
- **File**: `lib/chereta_web/endpoint.ex`
- **Added**: `https://[YOUR-APP-NAME].onrender.com` to allowed origins
- **Purpose**: Allow your production frontend to access the API

### 3. Router Updated
- **File**: `lib/chereta_web/router.ex`
- **Added**: Health check route
- **Maintained**: All existing API routes

## 🔗 WebSocket Features

Your app includes real-time features:

### Presence Tracking
- **Channel**: `item:*` (for each auction item)
- **Purpose**: Track users currently viewing/bidding on items
- **Example**: `item:123` for auction item with ID 123

### Real-time Bidding
- **Event**: `new_bid`
- **Purpose**: Broadcast new bids to all connected users
- **Data**: Bid amount, user info, timestamp

## 🧪 Testing Your Deployment

### 1. Test Health Check
```bash
curl https://[YOUR-APP-NAME].onrender.com/api/health
```

### 2. Test Categories API
```bash
curl https://[YOUR-APP-NAME].onrender.com/api/categories
```

### 3. Test WebSocket (from browser console)
```javascript
const socket = new Phoenix.Socket('wss://[YOUR-APP-NAME].onrender.com/socket', {
  params: { token: 'your-jwt-token' }
});
socket.connect();
```

## 🚨 Important Notes

### Security
- ✅ **SSL Enabled**: All traffic uses HTTPS/WSS
- ✅ **CORS Configured**: Only allowed origins can access API
- ✅ **Database SSL**: Connection to database uses SSL
- ✅ **Environment Variables**: Secrets managed by hosting platform

### Performance
- **Free Tier**: May sleep after 15 minutes of inactivity
- **Cold Start**: First request after sleep takes ~30 seconds
- **Database**: External database (always available)

### Monitoring
- **Platform Dashboard**: Monitor logs and metrics
- **Health Endpoint**: Check service status
- **Database**: Monitor via database dashboard

## 🔄 Deployment Workflow

1. **Push to Repository**: All changes trigger redeploy
2. **Automatic Build**: Platform runs `build.sh`
3. **Database Migration**: Runs automatically during build
4. **Service Start**: Phoenix server starts with `PHX_SERVER=true`

Your Phoenix API is now live and ready to serve your frontend! 🎉
