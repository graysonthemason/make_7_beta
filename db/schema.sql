DROP DATABASE IF EXISTS make_7;
CREATE DATABASE make_7;
\c make_7

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS games;


CREATE TABLE users (
  id           serial       PRIMARY KEY,
  name         varchar(255) NOT NULL,
  wins         integer
  losses       integer
  profile
);

CREATE TABLE games (
  id         serial       PRIMARY KEY,
  station_id integer      REFERENCES stations(id) NOT NULL,
  title      varchar(255) NOT NULL,
  created_at timestamp with time zone default now()
);

CREATE TABLE episodes (
  id                serial       PRIMARY KEY,
  series_id         integer      REFERENCES series(id) NOT NULL,
  tmsid             varchar(255) NOT NULL,
  start_time        timestamp with time zone NOT NULL,
  short_start       varchar(127),
  short_end         varchar(127),
  length            integer      NOT NULL,
  title             varchar(255) NOT NULL,
  description       varchar(1023),
  season_number     integer,
  episode_number    integer,
  original_air_date varchar(127),
  created_at        timestamp with time zone default now()
);

CREATE TABLE viewers (
  id   serial       PRIMARY KEY,
  name varchar(127) NOT NULL,
  created_at timestamp with time zone default now()
  
  -- other attributes possible, like favorite genres
  --   or password information for login, but unnecesary
  --   for our MVPrototype
);

CREATE TABLE recordings (
  id                  serial  PRIMARY KEY,
  episode_id          integer REFERENCES episodes(id) NOT NULL,
  viewer_id           integer REFERENCES viewers(id) NOT NULL,
  play_head           integer NOT NULL, -- place in recording in seconds
  currently_recording boolean,
  created_at          timestamp with time zone default now()
);
