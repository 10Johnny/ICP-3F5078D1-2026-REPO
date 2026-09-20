from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

VERSION = os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT = os.getenv("APP_ENV", "development")


@app.route("/")
def home():
    return jsonify({
        "application": "ICP DevOps Demo",
        "version": VERSION,
        "environment": ENVIRONMENT,
        "hostname": socket.gethostname(),
        "status": "running"
    })


@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200


@app.route("/ready")
def ready():
    return jsonify({"status": "ready"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
