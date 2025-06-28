CREATE TABLE Directors (
    did INT PRIMARY KEY AUTO_INCREMENT,
    dname VARCHAR(40) NOT NULL,
    photo_path VARCHAR(100)
);

CREATE TABLE Movies (
    mid INT PRIMARY KEY AUTO_INCREMENT,
    mname VARCHAR(60) NOT NULL,
    title TEXT,
    initial_release DATE,
    rate FLOAT,
    did INT,
    poster_path VARCHAR(100),  -- مسیر عکس فیلم
    FOREIGN KEY (did) REFERENCES Directors(did)
);

CREATE TABLE Genres (
    gid INT PRIMARY KEY AUTO_INCREMENT,
    gname VARCHAR(20) NOT NULL
);

CREATE TABLE Actors (
    aid INT PRIMARY KEY AUTO_INCREMENT,
    aname VARCHAR(40) NOT NULL,
    photo_path VARCHAR(100)    -- مسیر عکس بازیگر
);

CREATE TABLE Users (
    uid INT PRIMARY KEY AUTO_INCREMENT,
    uname VARCHAR(50) NOT NULL,
    bio TEXT,
    registration_date DATE,
    password_hash VARCHAR(255) NOT NULL,  -- پسورد هش‌شده
    avatar_path VARCHAR(100),              -- مسیر عکس کاربر
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Ratings_comments (
    rid INT PRIMARY KEY AUTO_INCREMENT,
    mid INT,
    uid INT,
    rate FLOAT,
    comment_text TEXT,
    FOREIGN KEY (mid) REFERENCES Movies(mid),
    FOREIGN KEY (uid) REFERENCES Users(uid)
);

CREATE TABLE Movies_cast (
    mid INT,
    aid INT,
    role_in_movie VARCHAR(50),
    PRIMARY KEY (mid, aid),
    FOREIGN KEY (mid) REFERENCES Movies(mid),
    FOREIGN KEY (aid) REFERENCES Actors(aid)
);

CREATE TABLE Movies_genres (
    mid INT,
    gid INT,
    PRIMARY KEY (mid, gid),
    FOREIGN KEY (mid) REFERENCES Movies(mid),
    FOREIGN KEY (gid) REFERENCES Genres(gid)
);