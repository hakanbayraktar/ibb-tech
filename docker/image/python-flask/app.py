from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='mydb', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return f'Hello! This site has been visited {count} times.'

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
