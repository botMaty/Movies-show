<h1>🎬 Movie Database Web App</h1>

<p>
    A simple web application for managing and browsing a movie database. Users can sign up, log in, view movies along with their actors and directors, leave comments, and rate them.
</p>

<hr>

<h2>🚀 Features</h2>
<ul>
  <li>🧾 User registration and login (with password hashing)</li>
  <li>🎥 Browse movies, actors, and directors</li>
  <li>💬 Leave reviews and star ratings for movies</li>
  <li>🔍 Search functionality (optional)</li>
  <li>📚 Fully connected to a MySQL database</li>
  <li>🧩 Built with Flask, SQLAlchemy, and Jinja2 templates</li>
</ul>

<hr>

<p>Built with:
  <ul>
    <li>Python 3.x</li>
    <li>Flask 3.1.1</li>
    <li>SQLAlchemy 2.0</li>
    <li>MySQL (via PyMySQL)</li>
    <li>HTML / CSS / Jinja2</li>
    <li>bcrypt (for password hashing)</li>
  </ul>
</p>

<hr>

<h2>⚙️ Installation</h2>
<ol>
  <li><strong>Clone the repository</strong>
    <pre><code>git clone https://github.com/botMaty/Movies-show.git
cd Movies-show</code></pre>
  </li>

  <li><strong>Create a virtual environment (optional but recommended)</strong>
    <pre><code>python -m venv venv
source venv/bin/activate  # On Windows use venv\Scripts\activate</code></pre>
  </li>

  <li><strong>Install dependencies</strong>
    <pre><code>pip install -r requirements.txt</code></pre>
  </li>

  <li><strong>Install dependencies</strong>
    <pre><code>pip install -r requirements.txt</code></pre>
  </li>

  <li><strong>Configure the database in config.py</strong>
    <pre><code>db_inf = "..."</code></pre>
  </li>

  <li><strong>Open your browser</strong> and go to <a href="http://127.0.0.1:5000">http://127.0.0.1:5000</a>
  </li>
</ol>

<hr>

<h2>🛢️ SQL Queries</h2>
<p>You can use the <strong>queries</strong> folder to create tables, and add data.</p>

<hr>

<h2>📁 File Structure</h2>
<pre>
Movies_show
├── app
│   ├── config.py
│   ├── db.py
│   ├── __init__.py
│   ├── static
│   │   ├── css
│   │   ├── js
│   │   └── photo
│   └── templates
├── queries
├── README.md
├── requirements.txt
└── run.py
</pre>

<hr>

<h2>📜 License</h2>
<p>This project is licensed under the <strong>MIT License</strong>.</p>

<hr>

<p>This is a simple project made for learning purposes in a university database course.</p>
