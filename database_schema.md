# Supabase Database Schema

## Cấu trúc cơ sở dữ liệu cho Sabo Arena

### 1. Bảng users (Người dùng)
```sql
-- Tạo bảng users
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT UNIQUE NOT NULL,
  username TEXT UNIQUE NOT NULL,
  first_name TEXT,
  last_name TEXT,
  avatar TEXT,
  phone TEXT,
  birth_date DATE,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tạo trigger để tự động cập nhật updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 2. Bảng user_stats (Thống kê người dùng)
```sql
-- Tạo bảng user_stats
CREATE TABLE user_stats (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  total_tournaments INTEGER DEFAULT 0,
  tournaments_won INTEGER DEFAULT 0,
  total_matches INTEGER DEFAULT 0,
  matches_won INTEGER DEFAULT 0,
  matches_lost INTEGER DEFAULT 0,
  win_rate DECIMAL(5,2) DEFAULT 0.00,
  total_points INTEGER DEFAULT 0,
  ranking INTEGER DEFAULT 0,
  level INTEGER DEFAULT 1,
  experience_points INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id)
);

CREATE TRIGGER update_user_stats_updated_at BEFORE UPDATE ON user_stats 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 3. Bảng tournaments (Giải đấu)
```sql
-- Tạo enum cho tournament status
CREATE TYPE tournament_status AS ENUM (
  'upcoming', 'ongoing', 'completed', 'cancelled'
);

-- Tạo enum cho tournament type
CREATE TYPE tournament_type AS ENUM (
  'single_elimination', 'double_elimination', 'round_robin', 'swiss'
);

-- Tạo bảng tournaments
CREATE TABLE tournaments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  game TEXT NOT NULL,
  tournament_type tournament_type NOT NULL DEFAULT 'single_elimination',
  status tournament_status NOT NULL DEFAULT 'upcoming',
  max_participants INTEGER NOT NULL,
  current_participants INTEGER DEFAULT 0,
  entry_fee DECIMAL(10,2) DEFAULT 0.00,
  prize_pool DECIMAL(10,2) DEFAULT 0.00,
  start_date TIMESTAMP WITH TIME ZONE NOT NULL,
  end_date TIMESTAMP WITH TIME ZONE,
  registration_deadline TIMESTAMP WITH TIME ZONE,
  rules TEXT,
  banner_image TEXT,
  organizer_id UUID REFERENCES users(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TRIGGER update_tournaments_updated_at BEFORE UPDATE ON tournaments 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 4. Bảng tournament_participants (Người tham gia giải đấu)
```sql
-- Tạo bảng tournament_participants
CREATE TABLE tournament_participants (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  registration_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  seed INTEGER, -- Thứ hạng khởi tạo
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(tournament_id, user_id)
);
```

### 5. Bảng matches (Trận đấu)
```sql
-- Tạo enum cho match status
CREATE TYPE match_status AS ENUM (
  'scheduled', 'in_progress', 'completed', 'cancelled'
);

-- Tạo bảng matches
CREATE TABLE matches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
  round INTEGER NOT NULL,
  match_number INTEGER NOT NULL,
  player1_id UUID REFERENCES users(id),
  player2_id UUID REFERENCES users(id),
  winner_id UUID REFERENCES users(id),
  player1_score INTEGER DEFAULT 0,
  player2_score INTEGER DEFAULT 0,
  status match_status DEFAULT 'scheduled',
  scheduled_time TIMESTAMP WITH TIME ZONE,
  started_at TIMESTAMP WITH TIME ZONE,
  ended_at TIMESTAMP WITH TIME ZONE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TRIGGER update_matches_updated_at BEFORE UPDATE ON matches 
FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 6. Row Level Security (RLS) Policies

```sql
-- Bật RLS cho tất cả các bảng
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;
ALTER TABLE tournament_participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE matches ENABLE ROW LEVEL SECURITY;

-- Policies cho bảng users
CREATE POLICY "Users can view their own profile" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON users
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Anyone can view public user profiles" ON users
  FOR SELECT USING (true);

-- Policies cho bảng user_stats
CREATE POLICY "Users can view their own stats" ON user_stats
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update their own stats" ON user_stats
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Anyone can view public user stats" ON user_stats
  FOR SELECT USING (true);

-- Policies cho bảng tournaments
CREATE POLICY "Anyone can view tournaments" ON tournaments
  FOR SELECT USING (true);

CREATE POLICY "Organizers can create tournaments" ON tournaments
  FOR INSERT WITH CHECK (auth.uid() = organizer_id);

CREATE POLICY "Organizers can update their tournaments" ON tournaments
  FOR UPDATE USING (auth.uid() = organizer_id);

-- Policies cho bảng tournament_participants
CREATE POLICY "Anyone can view tournament participants" ON tournament_participants
  FOR SELECT USING (true);

CREATE POLICY "Users can register for tournaments" ON tournament_participants
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can withdraw from tournaments" ON tournament_participants
  FOR DELETE USING (auth.uid() = user_id);

-- Policies cho bảng matches
CREATE POLICY "Anyone can view matches" ON matches
  FOR SELECT USING (true);

CREATE POLICY "Tournament organizers can create matches" ON matches
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM tournaments 
      WHERE id = tournament_id AND organizer_id = auth.uid()
    )
  );

CREATE POLICY "Tournament organizers can update matches" ON matches
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM tournaments 
      WHERE id = tournament_id AND organizer_id = auth.uid()
    )
  );
```

### 7. Functions và Triggers hữu ích

```sql
-- Function để tự động cập nhật số lượng participants
CREATE OR REPLACE FUNCTION update_tournament_participants_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE tournaments 
    SET current_participants = current_participants + 1
    WHERE id = NEW.tournament_id;
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE tournaments 
    SET current_participants = current_participants - 1
    WHERE id = OLD.tournament_id;
    RETURN OLD;
  END IF;
  RETURN NULL;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_participants_count 
AFTER INSERT OR DELETE ON tournament_participants
FOR EACH ROW EXECUTE FUNCTION update_tournament_participants_count();

-- Function để tự động tạo user_stats khi tạo user mới
CREATE OR REPLACE FUNCTION create_user_stats()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_stats (user_id) VALUES (NEW.id);
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER create_user_stats_trigger 
AFTER INSERT ON users
FOR EACH ROW EXECUTE FUNCTION create_user_stats();

-- Function để cập nhật win_rate tự động
CREATE OR REPLACE FUNCTION update_win_rate()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.total_matches > 0 THEN
    NEW.win_rate = (NEW.matches_won::DECIMAL / NEW.total_matches::DECIMAL) * 100;
  ELSE
    NEW.win_rate = 0;
  END IF;
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_win_rate_trigger 
BEFORE UPDATE ON user_stats
FOR EACH ROW EXECUTE FUNCTION update_win_rate();
```

### 8. Indexes để tối ưu performance

```sql
-- Indexes cho performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_tournaments_status ON tournaments(status);
CREATE INDEX idx_tournaments_start_date ON tournaments(start_date);
CREATE INDEX idx_tournament_participants_tournament_id ON tournament_participants(tournament_id);
CREATE INDEX idx_tournament_participants_user_id ON tournament_participants(user_id);
CREATE INDEX idx_matches_tournament_id ON matches(tournament_id);
CREATE INDEX idx_matches_status ON matches(status);
CREATE INDEX idx_user_stats_user_id ON user_stats(user_id);
```

### 9. Sample Data (Dữ liệu mẫu)

```sql
-- Insert sample tournaments
INSERT INTO tournaments (name, description, game, max_participants, start_date, registration_deadline)
VALUES 
  ('Spring Championship 2024', 'Giải đấu mùa xuân 2024', 'League of Legends', 64, '2024-04-01 10:00:00+07', '2024-03-25 23:59:59+07'),
  ('Summer Cup', 'Giải đấu mùa hè', 'Valorant', 32, '2024-06-15 14:00:00+07', '2024-06-10 23:59:59+07'),
  ('Autumn Tournament', 'Giải đấu mùa thu', 'FIFA 24', 16, '2024-09-01 16:00:00+07', '2024-08-25 23:59:59+07');
```

## Hướng dẫn Setup

1. **Truy cập Supabase Dashboard**: https://supabase.com
2. **Tạo project mới** hoặc sử dụng project hiện tại
3. **Mở SQL Editor** trong dashboard
4. **Chạy từng script** theo thứ tự:
   - Tạo bảng users và trigger
   - Tạo bảng user_stats
   - Tạo bảng tournaments với enums
   - Tạo bảng tournament_participants
   - Tạo bảng matches
   - Setup RLS policies
   - Tạo functions và triggers
   - Tạo indexes
   - Insert sample data (tùy chọn)

5. **Kiểm tra** trong Table Editor để đảm bảo tất cả bảng đã được tạo thành công.
