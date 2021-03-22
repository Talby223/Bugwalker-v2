-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE builds (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    build_string TEXT NOT NULL UNIQUE,
    build_date TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TABLE specs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    game_id INT NOT NULL UNIQUE,
    game_class_id INT NOT NULL UNIQUE,
    spec_name TEXT NOT NULL,
    spec_description TEXT NOT NULL,
    spec_icon TEXT NOT NULL
);
CREATE TABLE spells (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    build_id UUID NOT NULL,
    game_id INT NOT NULL UNIQUE,
    spell_name TEXT NOT NULL,
    spell_description TEXT NOT NULL,
    spell_icon TEXT NOT NULL,
    spec_id UUID NOT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    email TEXT NOT NULL UNIQUE,
    last_login TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    username TEXT NOT NULL UNIQUE,
    user_role INT DEFAULT 1 NOT NULL,
    password_salt TEXT NOT NULL,
    user_avatar TEXT NOT NULL
);
CREATE TABLE bugs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    spell_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    modified_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    bug_severity INT DEFAULT 0 NOT NULL,
    bug_type INT DEFAULT 0 NOT NULL,
    bug_status INT DEFAULT 0 NOT NULL,
    bug_tags TEXT NOT NULL,
    bug_description TEXT NOT NULL,
    bug_content TEXT NOT NULL,
    bug_blue_tracker_link TEXT NOT NULL,
    user_id UUID NOT NULL,
    bug_pinned BOOLEAN DEFAULT false NOT NULL
);
CREATE TABLE comments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    comment_body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    comment_status INT DEFAULT 0 NOT NULL
);
ALTER TABLE bugs ADD CONSTRAINT bugs_ref_spell_id FOREIGN KEY (spell_id) REFERENCES spells (id) ON DELETE NO ACTION;
ALTER TABLE bugs ADD CONSTRAINT bugs_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE comments ADD CONSTRAINT comments_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE spells ADD CONSTRAINT spells_ref_build_id FOREIGN KEY (build_id) REFERENCES builds (id) ON DELETE NO ACTION;
ALTER TABLE spells ADD CONSTRAINT spells_ref_spec_id FOREIGN KEY (spec_id) REFERENCES specs (id) ON DELETE NO ACTION;
