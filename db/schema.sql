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
