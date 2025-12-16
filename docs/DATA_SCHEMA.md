# HoopConnect Data Schema

## Overview
This document defines the entity definitions, relationships, and indexes for the HoopConnect application.

## Entity Definitions

### Users
```typescript
interface User {
  id: string;                    // UUID
  email: string;                 // Unique, indexed
  username: string;              // Unique, indexed
  displayName: string;
  profileImageUrl?: string;
  bio?: string;
  skillLevel: SkillLevel;        // Beginner | Intermediate | Advanced | Pro
  position?: Position;           // Guard | Forward | Center
  height?: number;               // In centimeters
  weight?: number;               // In kilograms
  location: GeoPoint;            // Latitude/Longitude
  createdAt: Timestamp;
  updatedAt: Timestamp;
  isActive: boolean;
  isPremium: boolean;
  stats?: PlayerStats;
}

enum SkillLevel {
  Beginner = "beginner",
  Intermediate = "intermediate",
  Advanced = "advanced",
  Pro = "pro"
}

enum Position {
  Guard = "guard",
  Forward = "forward",
  Center = "center"
}
```

### Courts
```typescript
interface Court {
  id: string;                    // UUID
  name: string;
  description?: string;
  address: Address;
  location: GeoPoint;            // Indexed for geo-queries
  type: CourtType;               // Indoor | Outdoor
  surface: SurfaceType;          // Concrete | Asphalt | Hardwood | Synthetic
  numberOfHoops: number;
  lighting: boolean;
  rating: number;                // Average rating 0-5
  amenities: Amenity[];
  images: string[];
  createdBy: string;             // User ID
  createdAt: Timestamp;
  updatedAt: Timestamp;
  isVerified: boolean;
}

enum CourtType {
  Indoor = "indoor",
  Outdoor = "outdoor"
}

enum SurfaceType {
  Concrete = "concrete",
  Asphalt = "asphalt",
  Hardwood = "hardwood",
  Synthetic = "synthetic"
}

interface Amenity {
  type: string;                  // Parking, Restrooms, Water, Benches
  available: boolean;
}
```

### Games
```typescript
interface Game {
  id: string;                    // UUID
  courtId: string;               // Foreign key to Courts
  hostId: string;                // Foreign key to Users
  title: string;
  description?: string;
  scheduledTime: Timestamp;
  duration: number;              // In minutes
  gameType: GameType;            // Pickup | Organized | Tournament
  skillLevel: SkillLevel;
  maxPlayers: number;
  currentPlayers: string[];      // Array of User IDs
  status: GameStatus;            // Scheduled | Active | Completed | Cancelled
  isPrivate: boolean;
  inviteOnly: boolean;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum GameType {
  Pickup = "pickup",
  Organized = "organized",
  Tournament = "tournament"
}

enum GameStatus {
  Scheduled = "scheduled",
  Active = "active",
  Completed = "completed",
  Cancelled = "cancelled"
}
```

### Friendships
```typescript
interface Friendship {
  id: string;                    // UUID
  userId1: string;               // User ID (lower ID first for consistency)
  userId2: string;               // User ID
  status: FriendshipStatus;
  requestedBy: string;           // User ID who initiated
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum FriendshipStatus {
  Pending = "pending",
  Accepted = "accepted",
  Blocked = "blocked"
}
```

### Messages
```typescript
interface Message {
  id: string;                    // UUID
  conversationId: string;        // Foreign key to Conversations
  senderId: string;              // Foreign key to Users
  content: string;
  type: MessageType;             // Text | Image | Location
  createdAt: Timestamp;
  readBy: string[];              // Array of User IDs
}

enum MessageType {
  Text = "text",
  Image = "image",
  Location = "location"
}
```

### Conversations
```typescript
interface Conversation {
  id: string;                    // UUID
  participants: string[];        // Array of User IDs
  type: ConversationType;        // Direct | Group
  lastMessage?: string;          // Message ID
  lastMessageAt?: Timestamp;
  createdAt: Timestamp;
  updatedAt: Timestamp;
}

enum ConversationType {
  Direct = "direct",
  Group = "group"
}
```

### Reviews
```typescript
interface Review {
  id: string;                    // UUID
  courtId: string;               // Foreign key to Courts
  userId: string;                // Foreign key to Users
  rating: number;                // 1-5
  comment?: string;
  images?: string[];
  createdAt: Timestamp;
  updatedAt: Timestamp;
}
```

### Notifications
```typescript
interface Notification {
  id: string;                    // UUID
  userId: string;                // Foreign key to Users
  type: NotificationType;
  title: string;
  message: string;
  data?: Record<string, any>;    // Additional context
  isRead: boolean;
  createdAt: Timestamp;
}

enum NotificationType {
  GameInvite = "game_invite",
  FriendRequest = "friend_request",
  GameReminder = "game_reminder",
  GameCancelled = "game_cancelled",
  NewMessage = "new_message",
  System = "system"
}
```

## Relationships

### One-to-Many
- `User` → `Games` (as host)
- `User` → `Reviews`
- `Court` → `Games`
- `Court` → `Reviews`
- `Conversation` → `Messages`

### Many-to-Many
- `User` ↔ `Games` (players)
- `User` ↔ `User` (friends via Friendships)
- `User` ↔ `Conversation` (participants)

## Indexes

### Performance Indexes
```sql
-- Users
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_users_location ON Users(location); -- Geospatial

-- Courts
CREATE INDEX idx_courts_location ON Courts(location); -- Geospatial
CREATE INDEX idx_courts_type ON Courts(type);
CREATE INDEX idx_courts_rating ON Courts(rating DESC);

-- Games
CREATE INDEX idx_games_court_id ON Games(courtId);
CREATE INDEX idx_games_host_id ON Games(hostId);
CREATE INDEX idx_games_scheduled_time ON Games(scheduledTime);
CREATE INDEX idx_games_status ON Games(status);

-- Friendships
CREATE INDEX idx_friendships_user1 ON Friendships(userId1);
CREATE INDEX idx_friendships_user2 ON Friendships(userId2);
CREATE INDEX idx_friendships_status ON Friendships(status);

-- Messages
CREATE INDEX idx_messages_conversation_id ON Messages(conversationId);
CREATE INDEX idx_messages_created_at ON Messages(createdAt DESC);

-- Notifications
CREATE INDEX idx_notifications_user_id ON Notifications(userId);
CREATE INDEX idx_notifications_is_read ON Notifications(isRead);
CREATE INDEX idx_notifications_created_at ON Notifications(createdAt DESC);

-- Reviews
CREATE INDEX idx_reviews_court_id ON Reviews(courtId);
CREATE INDEX idx_reviews_user_id ON Reviews(userId);
```

## Data Validation Rules

1. **Email**: Must be valid email format
2. **Username**: 3-20 characters, alphanumeric and underscores only
3. **Rating**: Must be between 0 and 5
4. **SkillLevel**: Must be one of predefined enum values
5. **Location**: Valid latitude/longitude coordinates
6. **Timestamps**: All dates must be valid ISO 8601 format

## Security Considerations

1. User passwords are hashed using bcrypt (never stored in plain text)
2. Personal information (email, location) has restricted access
3. Messages are encrypted in transit
4. User-generated content is sanitized before storage
5. Rate limiting applied to prevent abuse

## Future Schema Extensions

- Player statistics tracking
- Tournament brackets
- Payment information (PCI compliant)
- Equipment rental tracking
- Court booking history
