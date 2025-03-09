-- Create the database if needed (This step is implied in SQLite as we just start using the database file)
-- Connect to the SQLite database or create it if it doesn't exist.

-- Create the lyrics table if it doesn't already exist
CREATE TABLE IF NOT EXISTS lyrics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  fullLyric TEXT NOT NULL
);

-- Delete all existing records from the lyrics table to avoid duplicates
DELETE FROM lyrics;

-- Insert example records into the lyrics table
INSERT INTO lyrics (title, fullLyric) VALUES
  ('Lyric 1 Title', 'Full lyric text for Lyric 1'),
  ('Lyric 2 Title', 'Full lyric text for Lyric 2'),
  ('Lyric 3 Title', 'Full lyric text for Lyric 3'),
  ('Lyric 4 Title', 'Full lyric text for Lyric 4'),
  ('Lyric 5 Title', 'Full lyric text for Lyric 5');

-- Query to verify that the records were inserted successfully
SELECT * FROM lyrics;
