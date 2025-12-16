-- HoopConnect Database Schema (Supabase/PostgreSQL)
-- This file contains SQL schema definitions for the HoopConnect application
-- Run this script to set up the database structure

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable PostGIS for geographic data (location-based queries)
CREATE EXTENSION IF NOT EXISTS postgis;

-- ============================================================================
-- ENUMS
-- ============================================================================

CREATE TYPE skill_level AS ENUM ('beginner', 'intermediate', 'advanced', 'pro');
CREATE TYPE position AS ENUM ('guard', 'forward', 'center');
CREATE TYPE court_type AS ENUM ('indoor', 'outdoor');
CREATE TYPE surface_type AS ENUM ('concrete', 'asphalt', 'hardwood', 'synthetic');
CREATE TYPE game_type AS ENUM ('pickup', 'organized', 'tournament');
CREATE TYPE game_status AS ENUM ('scheduled', 'active', 'completed', 'cancelled');
CREATE TYPE friendship_status AS ENUM ('pending', 'accepted', 'blocked');
CREATE TYPE message_type AS ENUM ('text', 'image', 'location');
CREATE TYPE conversation_type AS ENUM ('direct', 'group');
CREATE TYPE notification_type AS ENUM ('game_invite', 'friend_request', 'game_reminder', 'game_cancelled', 'new_message', 'system');

-- ============================================================================
-- USERS TABLE
-- ============================================================================

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) UNIQUE NOT NULL,
  username VARCHAR(50) UNIQUE NOT NULL,
  display_name VARCHAR(100) NOT NULL,
  profile_image_url TEXT,
  bio TEXT,
  skill_level skill_level DEFAULT 'beginner',
  position position,
  height INTEGER, -- in centimeters
  weight INTEGER, -- in kilograms
  location GEOGRAPHY(POINT, 4326), -- PostGIS geography type for lat/lng
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  is_premium BOOLEAN DEFAULT FALSE,
  last_login_at TIMESTAMP WITH TIME ZONE
);

-- Indexes for users table
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_location ON users USING GIST(location);
CREATE INDEX idx_users_skill_level ON users(skill_level);
CREATE INDEX idx_users_is_active ON users(is_active) WHERE is_active = TRUE;

-- ============================================================================
-- COURTS TABLE
-- ============================================================================

CREATE TABLE courts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(200) NOT NULL,
  description TEXT,
  street VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(50),
  zip_code VARCHAR(20),
  location GEOGRAPHY(POINT, 4326) NOT NULL, -- PostGIS geography type
  type court_type NOT NULL,
  surface surface_type NOT NULL,
  number_of_hoops INTEGER DEFAULT 2,
  has_lighting BOOLEAN DEFAULT FALSE,
  rating DECIMAL(3, 2) DEFAULT 0.0 CHECK (rating >= 0 AND rating <= 5),
  review_count INTEGER DEFAULT 0,
  images TEXT[], -- Array of image URLs
  created_by UUID REFERENCES users(id) ON DELETE SET NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_verified BOOLEAN DEFAULT FALSE
);

-- Indexes for courts table
CREATE INDEX idx_courts_location ON courts USING GIST(location);
CREATE INDEX idx_courts_type ON courts(type);
CREATE INDEX idx_courts_surface ON courts(surface);
CREATE INDEX idx_courts_rating ON courts(rating DESC);
CREATE INDEX idx_courts_is_verified ON courts(is_verified) WHERE is_verified = TRUE;

-- ============================================================================
-- COURT AMENITIES TABLE
-- ============================================================================

CREATE TABLE court_amenities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  court_id UUID REFERENCES courts(id) ON DELETE CASCADE,
  amenity_type VARCHAR(50) NOT NULL, -- 'parking', 'restrooms', 'water', 'benches'
  is_available BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_court_amenities_court_id ON court_amenities(court_id);

-- ============================================================================
-- GAMES TABLE
-- ============================================================================

CREATE TABLE games (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  court_id UUID REFERENCES courts(id) ON DELETE CASCADE,
  host_id UUID REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  scheduled_time TIMESTAMP WITH TIME ZONE NOT NULL,
  duration INTEGER NOT NULL, -- in minutes
  game_type game_type NOT NULL,
  skill_level skill_level,
  max_players INTEGER NOT NULL,
  current_player_count INTEGER DEFAULT 0,
  status game_status DEFAULT 'scheduled',
  is_private BOOLEAN DEFAULT FALSE,
  invite_only BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for games table
CREATE INDEX idx_games_court_id ON games(court_id);
CREATE INDEX idx_games_host_id ON games(host_id);
CREATE INDEX idx_games_scheduled_time ON games(scheduled_time);
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_games_skill_level ON games(skill_level);
CREATE INDEX idx_games_game_type ON games(game_type);

-- ============================================================================
-- GAME PLAYERS TABLE (Many-to-Many relationship)
-- ============================================================================

CREATE TABLE game_players (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  game_id UUID REFERENCES games(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(game_id, user_id)
);

CREATE INDEX idx_game_players_game_id ON game_players(game_id);
CREATE INDEX idx_game_players_user_id ON game_players(user_id);

-- ============================================================================
-- FRIENDSHIPS TABLE
-- ============================================================================

CREATE TABLE friendships (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id_1 UUID REFERENCES users(id) ON DELETE CASCADE,
  user_id_2 UUID REFERENCES users(id) ON DELETE CASCADE,
  status friendship_status DEFAULT 'pending',
  requested_by UUID REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CHECK (user_id_1 < user_id_2), -- Ensure consistent ordering
  UNIQUE(user_id_1, user_id_2)
);

CREATE INDEX idx_friendships_user_id_1 ON friendships(user_id_1);
CREATE INDEX idx_friendships_user_id_2 ON friendships(user_id_2);
CREATE INDEX idx_friendships_status ON friendships(status);

-- ============================================================================
-- CONVERSATIONS TABLE
-- ============================================================================

CREATE TABLE conversations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  type conversation_type NOT NULL,
  last_message_id UUID,
  last_message_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- CONVERSATION PARTICIPANTS TABLE
-- ============================================================================

CREATE TABLE conversation_participants (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(conversation_id, user_id)
);

CREATE INDEX idx_conversation_participants_conversation_id ON conversation_participants(conversation_id);
CREATE INDEX idx_conversation_participants_user_id ON conversation_participants(user_id);

-- ============================================================================
-- MESSAGES TABLE
-- ============================================================================

CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
  sender_id UUID REFERENCES users(id) ON DELETE SET NULL,
  content TEXT NOT NULL,
  type message_type DEFAULT 'text',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  read_by UUID[] DEFAULT ARRAY[]::UUID[]
);

CREATE INDEX idx_messages_conversation_id ON messages(conversation_id);
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_created_at ON messages(created_at DESC);

-- ============================================================================
-- REVIEWS TABLE
-- ============================================================================

CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  court_id UUID REFERENCES courts(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  images TEXT[], -- Array of image URLs
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(court_id, user_id) -- One review per user per court
);

CREATE INDEX idx_reviews_court_id ON reviews(court_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_created_at ON reviews(created_at DESC);

-- ============================================================================
-- NOTIFICATIONS TABLE
-- ============================================================================

CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  type notification_type NOT NULL,
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  data JSONB, -- Additional context data
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read) WHERE is_read = FALSE;
CREATE INDEX idx_notifications_created_at ON notifications(created_at DESC);
CREATE INDEX idx_notifications_type ON notifications(type);

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply trigger to all tables with updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_courts_updated_at BEFORE UPDATE ON courts
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_games_updated_at BEFORE UPDATE ON games
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_friendships_updated_at BEFORE UPDATE ON friendships
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_conversations_updated_at BEFORE UPDATE ON conversations
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON reviews
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Trigger to update game player count
CREATE OR REPLACE FUNCTION update_game_player_count()
RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE games SET current_player_count = current_player_count + 1 WHERE id = NEW.game_id;
  ELSIF (TG_OP = 'DELETE') THEN
    UPDATE games SET current_player_count = current_player_count - 1 WHERE id = OLD.game_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_game_player_count_trigger
AFTER INSERT OR DELETE ON game_players
FOR EACH ROW EXECUTE FUNCTION update_game_player_count();

-- Trigger to update court rating
CREATE OR REPLACE FUNCTION update_court_rating()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE courts 
  SET rating = (SELECT AVG(rating) FROM reviews WHERE court_id = COALESCE(NEW.court_id, OLD.court_id)),
      review_count = (SELECT COUNT(*) FROM reviews WHERE court_id = COALESCE(NEW.court_id, OLD.court_id))
  WHERE id = COALESCE(NEW.court_id, OLD.court_id);
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_court_rating_trigger
AFTER INSERT OR UPDATE OR DELETE ON reviews
FOR EACH ROW EXECUTE FUNCTION update_court_rating();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) - Enable for Supabase
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE courts ENABLE ROW LEVEL SECURITY;
ALTER TABLE court_amenities ENABLE ROW LEVEL SECURITY;
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_players ENABLE ROW LEVEL SECURITY;
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE conversation_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Example RLS policies (customize based on your needs)

-- Users can read their own data and public profiles of others
CREATE POLICY "Users can view their own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can view public profiles" ON users
  FOR SELECT USING (is_active = TRUE);

-- Users can update their own profile
CREATE POLICY "Users can update their own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

-- Anyone can view public courts
CREATE POLICY "Anyone can view courts" ON courts
  FOR SELECT USING (TRUE);

-- Authenticated users can create courts
CREATE POLICY "Authenticated users can create courts" ON courts
  FOR INSERT WITH CHECK (auth.uid() = created_by);

-- Anyone can view scheduled games
CREATE POLICY "Anyone can view public games" ON games
  FOR SELECT USING (is_private = FALSE OR host_id = auth.uid());

-- Authenticated users can create games
CREATE POLICY "Authenticated users can create games" ON games
  FOR INSERT WITH CHECK (auth.uid() = host_id);

-- Users can read their own notifications
CREATE POLICY "Users can view their own notifications" ON notifications
  FOR SELECT USING (auth.uid() = user_id);

-- ============================================================================
-- SAMPLE DATA (Optional - for development)
-- ============================================================================

-- Uncomment to insert sample data
/*
INSERT INTO users (email, username, display_name, skill_level) VALUES
  ('john@example.com', 'hooper123', 'John Doe', 'intermediate'),
  ('jane@example.com', 'baller99', 'Jane Smith', 'advanced');
*/

-- ============================================================================
-- CLEANUP FUNCTIONS
-- ============================================================================

-- Function to clean up old notifications (call periodically)
CREATE OR REPLACE FUNCTION cleanup_old_notifications()
RETURNS void AS $$
BEGIN
  DELETE FROM notifications 
  WHERE is_read = TRUE 
  AND created_at < NOW() - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql;

-- Function to cleanup cancelled games
CREATE OR REPLACE FUNCTION cleanup_cancelled_games()
RETURNS void AS $$
BEGIN
  DELETE FROM games 
  WHERE status = 'cancelled' 
  AND updated_at < NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql;
