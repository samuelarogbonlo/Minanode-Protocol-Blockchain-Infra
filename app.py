from flask_apscheduler import APScheduler
from flask import Flask, jsonify
from metric_scraper import fetch_families, get_families


app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
fetch_families()


scheduler = APScheduler()
scheduler.api_enabled = True
scheduler.init_app(app)


@scheduler.task('cron',  minute='*')
def fetch_families_each_minute():
    fetch_families()

scheduler.start()

@app.route("/")
def hello_world():
    return jsonify(get_families())