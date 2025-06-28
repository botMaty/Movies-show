import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  # میشه از env هم خوند
    
    # اطلاعات database
    db_inf = "root:1234@localhost:3306/project"

    SQLALCHEMY_DATABASE_URI = (
        f"mysql+pymysql://{db_inf}"
    )
    SESSION_COOKIE_SAMESITE = 'Lax'
    SESSION_COOKIE_SECURE = False
