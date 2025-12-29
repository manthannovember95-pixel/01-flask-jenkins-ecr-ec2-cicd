from flask import Flask, jsonify

def create_app():
    app = Flask(__name__)

    @app.get("/")
    def home():
        return jsonify(message="Flask CI/CD running", version="1.0.0")

    @app.get("/health")
    def health():
        return jsonify(status="ok")

    return app
