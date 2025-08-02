import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', '1234')  # میشه از env هم خوند
    
    # اطلاعات database
    db_config = {
        "user": "root",
        "password": "1234",
        "host": "localhost",
        "port": 3306,
        "database": "project"
    }

    SQLALCHEMY_DATABASE_URI = (
        f"mysql+pymysql://{db_config['user']}:{db_config['password']}"
        f"@{db_config['host']}:{db_config['port']}/{db_config['database']}"
    )
    
    SESSION_COOKIE_SAMESITE = 'Lax'
    SESSION_COOKIE_SECURE = False




