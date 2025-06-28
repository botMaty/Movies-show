from flask import Flask, redirect, render_template, request, session, url_for, jsonify
from datetime import datetime
from .config import Config
from .db import *

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    @app.route("/")
    def home():
        return render_template("search.html")

    @app.route('/search', methods=['POST'])
    def search():
        mname = request.form.get('mname', '')

        
        session['movies'] = db.search_movies(mname)

        return render_template("movies.html", movies=session['movies'])

    @app.route('/movie', methods=['POST'])
    def movie_page():
        mid = request.form.get("mid", type=int)
        if mid is None:
            return "Movie ID is None", 400

        # جستجو داخل لیست
        movie = next((m for m in session['movies'] if m['mid'] == mid), None)
        if movie is None:
            return "Movie not found", 404
        
        if ',' in movie['initial_release']:
            movie['initial_release'] = datetime.strptime(movie['initial_release'], "%a, %d %b %Y %H:%M:%S %Z").strftime('%Y-%m-%d')

        director = db.get_director(movie['did'])
        if director:
            session['director'] = director
            dname = director['dname']
        else:
            dname = "Director Not Found"

        genres = db.get_movie_genres(movie['mid'])

        actors = db.get_movie_cast(movie['mid'])

        rating_comment = None
        logged_in = False
        if 'user' in session:
            rating_comment = db.get_rating_comment(uid=session['user']['uid'], mid=mid)
            logged_in = True

        return render_template("movie_page.html", movie=movie, dname=dname, genres=genres, actors=actors, rating_comment=rating_comment, logged_in=logged_in)

    @app.route('/director')
    def director_page():
        if 'director' not in session:
            return "Director not found", 404

        director = session['director']
        movies_name = db.get_movies_name_by_did(director['did'])
        
        return render_template("director_page.html", director=director, movies_name=movies_name)
        
    @app.route('/login_register')
    def login_register():
        if 'user' in session:
            session.pop('user')
        return render_template('login_register.html')

    @app.route('/sign_in', methods=['POST'])
    def sign_in():
        email = request.form.get("login-email", '')
        password = request.form.get("login-password", '')

        message = db.get_user_by_password(email, password)

        if message == 'not found':
            return redirect(url_for('login_register')) # set error
        elif message == 'incorrect password':
            return redirect(url_for('login_register')) # set error
        else:
            session['user'] = message
            return redirect(url_for('home'))
        
    @app.route('/sign_up', methods=['POST'])
    def sign_up():
        uname = request.form.get("register-name", '')
        email = request.form.get("register-email", '')
        password = request.form.get("register-password", '')

        message = db.add_user(uname, email, password)

        if message == 'invalid data':
            return redirect(url_for('login_register')) # set error
        elif message == 'email already used':
            return redirect(url_for('login_register')) # set error
        else:
            session['user'] = message
            return redirect(url_for('home'))
        
    @app.route('/user')
    def user():
        if 'user' in session:
            user = session['user']
            if isinstance(user['registration_date'], str):
                user['registration_date'] = datetime.strptime(user['registration_date'], "%a, %d %b %Y %H:%M:%S %Z").strftime('%Y-%m-%d')
            return render_template('user_page.html', user=user)
        else:
            return redirect(url_for('login_register'))

    @app.route('/logout')
    def logout():
        if 'user' in session:
            session.pop('user')
        return redirect(url_for('home'))

    @app.route('/submit_comment', methods=['POST'])
    def submit_review():
        data = request.get_json()
        rate = float(data.get('rate'))
        comment_text = data.get('comment_text')
        mid = data.get('mid')  # از session یا data بگیر
        uid = session['user']['uid']

        if not uid:
            return jsonify({'success': False, 'message': 'Login required'}), 401

        # ذخیره در دیتابیس
        db.save_rating_comment(uid, mid, rate, comment_text)

        return jsonify({'success': True, 'message': 'Review submitted successfully'})
    
    app.config.update(
        SESSION_COOKIE_SAMESITE='Lax',
        SESSION_COOKIE_SECURE=False,
    )


    return app