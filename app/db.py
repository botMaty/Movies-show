from sqlalchemy import create_engine, text
from sqlalchemy.engine import Result
from .config import Config
from datetime import date
import bcrypt

connection_string = Config.SQLALCHEMY_DATABASE_URI

# ساخت engine
engine = create_engine(connection_string)


def search_movies(mname: str):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text("SELECT * FROM Movies WHERE mname LIKE :q ORDER BY mname"),
            {"q": f"%{mname}%"}
        )
    movies = [dict(row._mapping) for row in result]
    return movies
        
def get_director(did:int):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT * FROM Directors WHERE Directors.did = :did"),
            {"did": did}
        )
    director = result.fetchone()
    if director:
        return dict(director._mapping)
    else:
        return None

def get_movie_genres(mid:int):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT gname FROM Genres JOIN Movies_genres ON Genres.gid = Movies_genres.gid WHERE Movies_genres.mid = :mid"), 
            {"mid": mid}
        )
    return [r.gname for r in result]
        
def get_movie_cast(mid:int):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT Actors.*, role_in_movie FROM Actors JOIN Movies_cast ON Actors.aid = Movies_cast.aid WHERE Movies_cast.mid = :mid"), 
            {"mid": mid}
        )
    actors = [dict(row._mapping) for row in result]
    return actors

def get_movies_name_by_did(did:int):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT mname FROM Movies WHERE Movies.did = :did"), 
            {"did": did}
        )
    return [m.mname for m in result]

def get_user_by_password(email:str, password:str):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT uid, uname, bio, registration_date, password_hash, avatar_path, email FROM Users WHERE Users.email = :email"), 
            {"email": email}
        )
    user = result.fetchone()
    if user:
        stored_hash = user.password_hash.encode('utf-8')  # هش ذخیره‌شده
        input_password = password.encode('utf-8')         # رمز وارد شده

        if bcrypt.checkpw(input_password, stored_hash):
            user = dict(user._mapping)
            user.pop('password_hash')
            return user
        else:
            return 'incorrect password'
    else:
        return 'not found'
    
def add_user(uname:str ,email:str, password:str):
    if not uname or not email or len(password) < 8:
        return 'invalid data'

    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT uid FROM Users WHERE Users.email = :email"), 
            {"email": email}
        )
    if result.fetchone():
        return 'email already used'
    else:
        today_str = date.today().isoformat()
        hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
        query = text("""
            INSERT INTO Users (uname, email, bio, registration_date, password_hash, avatar_path)
            VALUES (:uname, :email, :bio, :registration_date, :password_hash, :avatar_path)
            """)
        params = {
            "uname": uname,
            "email": email,
            "bio": '',
            "registration_date": today_str,
            "password_hash": hashed.decode(),
            "avatar_path": "/photo/none.jpg"
        }
        with engine.connect() as connection:
            connection.execute(query, params)
            connection.commit()
        
        with engine.connect() as connection:
            result: Result = connection.execute(
                text(f"SELECT uid, uname, bio, registration_date, avatar_path, email FROM Users WHERE Users.email = :email"), 
                {"email": email}
            )
            return dict(result.fetchone()._mapping)

def get_rating_comment(uid:int, mid:int):
    with engine.connect() as connection:
        result: Result = connection.execute(
            text(f"SELECT * FROM Ratings_comments WHERE Ratings_comments.uid = :uid AND Ratings_comments.mid = :mid"),
            {"uid": uid, "mid": mid}
        )
    rating_comment = result.fetchone()
    if rating_comment:
        return dict(rating_comment._mapping)
    else:
        return None

def save_rating_comment(uid: int, mid: int, rate: float, comment_text: str):
    params = {
        "uid": uid,
        "mid": mid,
        "rate": rate,
        "comment_text": comment_text
    }
    is_available = get_rating_comment(uid, mid)
    if is_available:
        with engine.begin() as connection:  # تراکنش خودکار commit
            connection.execute(
                text("UPDATE Ratings_comments SET rate = :rate, comment_text = :comment_text WHERE uid = :uid AND mid = :mid"),
                params
            )
    else:
        with engine.begin() as connection:
            connection.execute(
                text("INSERT INTO Ratings_comments (uid, mid, rate, comment_text) VALUES (:uid, :mid, :rate, :comment_text)"),
                params
            )