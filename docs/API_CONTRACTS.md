# HoopConnect API Contracts

## Overview
This document defines the API endpoint specifications for the HoopConnect backend services. The API follows RESTful principles and uses JSON for request/response payloads.

## Base URL
```
Production: https://api.hoopconnect.app/v1
Staging: https://staging-api.hoopconnect.app/v1
Development: http://localhost:3000/v1
```

## Authentication
All authenticated endpoints require a Bearer token in the Authorization header:
```
Authorization: Bearer <access_token>
```

## Common Response Codes
- `200 OK` - Request succeeded
- `201 Created` - Resource created successfully
- `204 No Content` - Request succeeded with no response body
- `400 Bad Request` - Invalid request parameters
- `401 Unauthorized` - Missing or invalid authentication
- `403 Forbidden` - Insufficient permissions
- `404 Not Found` - Resource not found
- `409 Conflict` - Resource conflict (e.g., duplicate)
- `422 Unprocessable Entity` - Validation errors
- `429 Too Many Requests` - Rate limit exceeded
- `500 Internal Server Error` - Server error

## Error Response Format
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  }
}
```

---

## Authentication Endpoints

### Register User
```http
POST /auth/register
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123",
  "username": "hooper123",
  "displayName": "John Doe"
}
```

**Response (201):**
```json
{
  "user": {
    "id": "usr_123abc",
    "email": "user@example.com",
    "username": "hooper123",
    "displayName": "John Doe",
    "createdAt": "2025-12-16T00:00:00Z"
  },
  "tokens": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc...",
    "expiresIn": 3600
  }
}
```

### Login
```http
POST /auth/login
```

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securePassword123"
}
```

**Response (200):**
```json
{
  "user": {
    "id": "usr_123abc",
    "email": "user@example.com",
    "username": "hooper123",
    "displayName": "John Doe"
  },
  "tokens": {
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc...",
    "expiresIn": 3600
  }
}
```

### Refresh Token
```http
POST /auth/refresh
```

**Request Body:**
```json
{
  "refreshToken": "eyJhbGc..."
}
```

**Response (200):**
```json
{
  "accessToken": "eyJhbGc...",
  "refreshToken": "eyJhbGc...",
  "expiresIn": 3600
}
```

### Logout
```http
POST /auth/logout
```

**Headers:** `Authorization: Bearer <token>`

**Response (204):** No content

---

## User Endpoints

### Get Current User Profile
```http
GET /users/me
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "id": "usr_123abc",
  "email": "user@example.com",
  "username": "hooper123",
  "displayName": "John Doe",
  "bio": "Love playing pickup basketball!",
  "profileImageUrl": "https://cdn.hoopconnect.app/users/usr_123abc.jpg",
  "skillLevel": "intermediate",
  "position": "guard",
  "height": 180,
  "weight": 75,
  "location": {
    "latitude": 37.7749,
    "longitude": -122.4194
  },
  "isPremium": false,
  "createdAt": "2025-12-16T00:00:00Z",
  "updatedAt": "2025-12-16T00:00:00Z"
}
```

### Update User Profile
```http
PATCH /users/me
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "displayName": "Johnny Basketball",
  "bio": "Hooper for life",
  "skillLevel": "advanced",
  "position": "forward",
  "height": 185
}
```

**Response (200):** Updated user object

### Get User by ID
```http
GET /users/:userId
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):** User object (public fields only)

### Upload Profile Image
```http
POST /users/me/avatar
```

**Headers:** 
- `Authorization: Bearer <token>`
- `Content-Type: multipart/form-data`

**Request Body:** Form data with `image` field

**Response (200):**
```json
{
  "profileImageUrl": "https://cdn.hoopconnect.app/users/usr_123abc.jpg"
}
```

---

## Court Endpoints

### List Courts
```http
GET /courts
```

**Query Parameters:**
- `lat` (required): Latitude
- `lng` (required): Longitude
- `radius` (optional): Search radius in km (default: 10, max: 50)
- `type` (optional): indoor | outdoor
- `surface` (optional): concrete | asphalt | hardwood | synthetic
- `limit` (optional): Results per page (default: 20, max: 100)
- `page` (optional): Page number (default: 1)

**Response (200):**
```json
{
  "courts": [
    {
      "id": "crt_456def",
      "name": "Downtown Basketball Court",
      "description": "Outdoor court with great lighting",
      "address": {
        "street": "123 Main St",
        "city": "San Francisco",
        "state": "CA",
        "zipCode": "94102"
      },
      "location": {
        "latitude": 37.7749,
        "longitude": -122.4194
      },
      "type": "outdoor",
      "surface": "concrete",
      "numberOfHoops": 2,
      "lighting": true,
      "rating": 4.5,
      "distance": 2.3
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 45,
    "pages": 3
  }
}
```

### Get Court by ID
```http
GET /courts/:courtId
```

**Response (200):** Full court object with amenities and images

### Create Court
```http
POST /courts
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "name": "My Local Court",
  "description": "Great court near my house",
  "address": {
    "street": "456 Oak St",
    "city": "San Francisco",
    "state": "CA",
    "zipCode": "94103"
  },
  "location": {
    "latitude": 37.7849,
    "longitude": -122.4094
  },
  "type": "outdoor",
  "surface": "asphalt",
  "numberOfHoops": 2,
  "lighting": true,
  "amenities": [
    { "type": "parking", "available": true },
    { "type": "restrooms", "available": false }
  ]
}
```

**Response (201):** Created court object

### Update Court
```http
PATCH /courts/:courtId
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:** Partial court object

**Response (200):** Updated court object

### Add Court Review
```http
POST /courts/:courtId/reviews
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "rating": 4,
  "comment": "Great court, well maintained!"
}
```

**Response (201):** Created review object

---

## Game Endpoints

### List Games
```http
GET /games
```

**Query Parameters:**
- `lat` (optional): Latitude for location-based search
- `lng` (optional): Longitude for location-based search
- `radius` (optional): Search radius in km (default: 10)
- `status` (optional): scheduled | active | completed | cancelled
- `skillLevel` (optional): beginner | intermediate | advanced | pro
- `startDate` (optional): ISO 8601 date
- `endDate` (optional): ISO 8601 date
- `limit` (optional): Results per page (default: 20)
- `page` (optional): Page number (default: 1)

**Response (200):**
```json
{
  "games": [
    {
      "id": "gm_789ghi",
      "courtId": "crt_456def",
      "court": {
        "id": "crt_456def",
        "name": "Downtown Basketball Court",
        "location": {
          "latitude": 37.7749,
          "longitude": -122.4194
        }
      },
      "hostId": "usr_123abc",
      "host": {
        "id": "usr_123abc",
        "username": "hooper123",
        "displayName": "John Doe",
        "profileImageUrl": "https://cdn.hoopconnect.app/users/usr_123abc.jpg"
      },
      "title": "Pickup Game - All Levels Welcome",
      "description": "Casual pickup game",
      "scheduledTime": "2025-12-20T18:00:00Z",
      "duration": 120,
      "gameType": "pickup",
      "skillLevel": "intermediate",
      "maxPlayers": 10,
      "currentPlayers": 6,
      "status": "scheduled",
      "isPrivate": false
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 15,
    "pages": 1
  }
}
```

### Get Game by ID
```http
GET /games/:gameId
```

**Response (200):** Full game object with player list

### Create Game
```http
POST /games
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "courtId": "crt_456def",
  "title": "Evening Pickup Game",
  "description": "Looking for 8-10 players",
  "scheduledTime": "2025-12-20T18:00:00Z",
  "duration": 90,
  "gameType": "pickup",
  "skillLevel": "intermediate",
  "maxPlayers": 10,
  "isPrivate": false,
  "inviteOnly": false
}
```

**Response (201):** Created game object

### Update Game
```http
PATCH /games/:gameId
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:** Partial game object

**Response (200):** Updated game object

### Join Game
```http
POST /games/:gameId/join
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "message": "Successfully joined game",
  "game": { }
}
```

### Leave Game
```http
POST /games/:gameId/leave
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "message": "Successfully left game"
}
```

### Cancel Game
```http
POST /games/:gameId/cancel
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):** Cancelled game object

---

## Friendship Endpoints

### Send Friend Request
```http
POST /friendships
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "userId": "usr_456xyz"
}
```

**Response (201):** Friendship object with status "pending"

### List Friend Requests
```http
GET /friendships/requests
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `status` (optional): pending | accepted | blocked

**Response (200):**
```json
{
  "requests": [
    {
      "id": "frd_123abc",
      "user": {
        "id": "usr_456xyz",
        "username": "baller99",
        "displayName": "Jane Smith",
        "profileImageUrl": "https://..."
      },
      "status": "pending",
      "createdAt": "2025-12-15T10:00:00Z"
    }
  ]
}
```

### Accept Friend Request
```http
POST /friendships/:friendshipId/accept
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):** Updated friendship object

### Reject Friend Request
```http
POST /friendships/:friendshipId/reject
```

**Headers:** `Authorization: Bearer <token>`

**Response (204):** No content

### List Friends
```http
GET /friendships
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "friends": [
    {
      "id": "usr_456xyz",
      "username": "baller99",
      "displayName": "Jane Smith",
      "profileImageUrl": "https://...",
      "friendsSince": "2025-12-10T00:00:00Z"
    }
  ]
}
```

---

## Messaging Endpoints

### List Conversations
```http
GET /conversations
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):**
```json
{
  "conversations": [
    {
      "id": "cnv_123abc",
      "type": "direct",
      "participants": [
        {
          "id": "usr_456xyz",
          "username": "baller99",
          "displayName": "Jane Smith",
          "profileImageUrl": "https://..."
        }
      ],
      "lastMessage": {
        "id": "msg_789def",
        "content": "See you at the game!",
        "createdAt": "2025-12-16T12:00:00Z"
      },
      "unreadCount": 2
    }
  ]
}
```

### Get Conversation Messages
```http
GET /conversations/:conversationId/messages
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `limit` (optional): Messages per page (default: 50)
- `before` (optional): Message ID for pagination

**Response (200):**
```json
{
  "messages": [
    {
      "id": "msg_789def",
      "senderId": "usr_456xyz",
      "sender": {
        "id": "usr_456xyz",
        "username": "baller99",
        "displayName": "Jane Smith",
        "profileImageUrl": "https://..."
      },
      "content": "See you at the game!",
      "type": "text",
      "createdAt": "2025-12-16T12:00:00Z",
      "readBy": ["usr_123abc"]
    }
  ]
}
```

### Send Message
```http
POST /conversations/:conversationId/messages
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "content": "Looking forward to it!",
  "type": "text"
}
```

**Response (201):** Created message object

### Create Conversation
```http
POST /conversations
```

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "participantIds": ["usr_456xyz"],
  "type": "direct"
}
```

**Response (201):** Created conversation object

---

## Notification Endpoints

### List Notifications
```http
GET /notifications
```

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `isRead` (optional): true | false
- `limit` (optional): Notifications per page (default: 20)
- `page` (optional): Page number (default: 1)

**Response (200):**
```json
{
  "notifications": [
    {
      "id": "ntf_123abc",
      "type": "game_invite",
      "title": "Game Invitation",
      "message": "John Doe invited you to a game",
      "data": {
        "gameId": "gm_789ghi"
      },
      "isRead": false,
      "createdAt": "2025-12-16T10:00:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 5,
    "pages": 1
  }
}
```

### Mark Notification as Read
```http
PATCH /notifications/:notificationId/read
```

**Headers:** `Authorization: Bearer <token>`

**Response (200):** Updated notification object

### Mark All Notifications as Read
```http
POST /notifications/read-all
```

**Headers:** `Authorization: Bearer <token>`

**Response (204):** No content

---

## Rate Limiting

**Global Limits:**
- 100 requests per minute per IP
- 1000 requests per hour per user

**Endpoint-Specific Limits:**
- Authentication endpoints: 5 requests per minute
- Message sending: 20 requests per minute
- Court creation: 5 requests per hour

**Rate Limit Headers:**
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1639651200
```

---

## Webhooks (Future)

Webhook events for real-time updates:
- `game.created`
- `game.updated`
- `game.cancelled`
- `message.received`
- `friendship.accepted`

---

## Versioning

API versioning is handled via URL path:
- Current version: `/v1`
- Deprecated versions will be supported for 6 months after new version release
- Breaking changes will increment major version

---

## Support

For API support:
- **Documentation**: https://docs.hoopconnect.app
- **Email**: api-support@hoopconnect.app
- **Status Page**: https://status.hoopconnect.app
