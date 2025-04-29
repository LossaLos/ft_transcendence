CREATE TABLE
	IF NOT EXISTS users (
		id SERIAL PRIMARY KEY,
		username VARCHAR(50) NOT NULL UNIQUE CHECK (LENGTH(username) >=6 AND LENGTH(username) <= 20 AND username ~ '^[a-zA-Z0-9_\-]+$'),
        email VARCHAR(255) DEFAULT NULL ,
		password VARCHAR(255) ,
		rank INT DEFAULT 0,
		tournament_status VARCHAR(20) DEFAULT 'out',
		winrate FLOAT DEFAULT 0,
		total_wins INT DEFAULT 0,
		total_losses INT DEFAULT 0,
		elo INT DEFAULT 0,
		is_connected BOOLEAN DEFAULT FALSE,
		total_games INT DEFAULT 0,
		profile_picture VARCHAR(255) DEFAULT 'profile_pics/default-profile-150.png',
		is_2fa_enabled BOOLEAN DEFAULT FALSE,
		is_dummy BOOLEAN DEFAULT FALSE,
		current_tournament_id INT DEFAULT 0,
		twofa_method VARCHAR(50) DEFAULT NULL,
		phone_number VARCHAR(255) DEFAULT NULL,
		temp_2fa_code VARCHAR(255) DEFAULT NULL,
		reset_2fa_expiry TIMESTAMP DEFAULT NULL,
		temp_reset_code VARCHAR(255) DEFAULT NULL,
		reset_code_expiry TIMESTAMP DEFAULT NULL,
		totp_secret VARCHAR(200) DEFAULT NULL,
		oauth_id VARCHAR(255) UNIQUE DEFAULT NULL,
		token_expiry TIMESTAMP DEFAULT NULL,
		session_token VARCHAR(255) DEFAULT NULL,
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);

CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);

CREATE INDEX IF NOT EXISTS idx_users_phone ON users (phone_number);

CREATE TABLE
	IF NOT EXISTS game_history (
		id SERIAL PRIMARY KEY,
		winner_id INT DEFAULT 0,
		loser_id INT DEFAULT 0,
		winner_score INT DEFAULT 0,
		loser_score INT DEFAULT 0,
		created_at TIMESTAMP NOT NULL DEFAULT NOW ()
	);

CREATE TABLE
	IF NOT EXISTS friends (
		id SERIAL PRIMARY KEY,
		user_id INT NOT NULL,
		friend_id INT NOT NULL,
		initiator_id INT NOT NULL,
		status VARCHAR(20) DEFAULT 'pending',
		created_at TIMESTAMP NOT NULL DEFAULT NOW (),
		FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
		FOREIGN KEY (friend_id) REFERENCES users (id) ON DELETE CASCADE,
		UNIQUE (user_id, friend_id)
	);

CREATE TABLE
	IF NOT EXISTS blocks (
		id SERIAL PRIMARY KEY,
		user_id INT NOT NULL,
		blocked_user_id INT NOT NULL,
		created_at TIMESTAMP NOT NULL DEFAULT NOW (),
		initiator_id INT NOT NULL,
		FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
		FOREIGN KEY (blocked_user_id) REFERENCES users (id) ON DELETE CASCADE,
		UNIQUE (user_id, blocked_user_id)
	);

CREATE TABLE
	IF NOT EXISTS tournaments (
		id SERIAL PRIMARY KEY,
		serial_key VARCHAR(255) NOT NULL UNIQUE,
		size INT DEFAULT 0 CHECK (size = 2 OR size = 4 OR size = 8 OR size = 16),
		name VARCHAR(255) DEFAULT 'TOURNAMENT_DEFAULT_NAME',
		organizer_id INT DEFAULT NULL,
		status VARCHAR(50) DEFAULT 'upcoming',
		mode VARCHAR(10) DEFAULT 'local',
		created_at TIMESTAMP NOT NULL DEFAULT NOW (),
		updated_at TIMESTAMP NOT NULL DEFAULT NOW ()
	);

CREATE TABLE
	IF NOT EXISTS tournament_participants (
		id SERIAL PRIMARY KEY,
		tournament_id INT NOT NULL,
		user_id INT NOT NULL,
		status VARCHAR(20) DEFAULT 'pending',
		created_at TIMESTAMP NOT NULL DEFAULT NOW (),
		FOREIGN KEY (tournament_id) REFERENCES tournaments (id) ON DELETE CASCADE,
		UNIQUE (tournament_id, user_id)
	);

CREATE TABLE
	IF NOT EXISTS private_games (
		id SERIAL PRIMARY KEY,
		user_id INT NOT NULL,
		recipient_id INT NOT NULL,
		initiator_id INT NOT NULL,
		status VARCHAR(20) DEFAULT 'pending',
		created_at TIMESTAMP NOT NULL DEFAULT NOW (),
		FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
		FOREIGN KEY (recipient_id) REFERENCES users (id) ON DELETE CASCADE,
		UNIQUE (user_id, recipient_id)
	);

CREATE TABLE 
	IF NOT EXISTS service_tournamentmatch (
		id SERIAL PRIMARY KEY,
		tournament_id INT NOT NULL,
		round_number INT NOT NULL,
		match_order INT NOT NULL,

		player1_id INT DEFAULT NULL,
		player2_id INT DEFAULT NULL,
		winner_id INT DEFAULT NULL,

		status VARCHAR(20) DEFAULT 'pending',
		score VARCHAR(20),
		match_key VARCHAR(100),
		created_at TIMESTAMP NOT NULL DEFAULT NOW(),
		
		FOREIGN KEY (tournament_id) REFERENCES tournaments (id) ON DELETE CASCADE
);

