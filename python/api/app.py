import sys
import os
from flask import Flask, request, jsonify
from flask_cors import CORS
# Ajouter le chemin vers predict.py
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '../scripts')))
from predict import predict_vehicle

app = Flask(__name__)
CORS(app)

@app.route('/predict', methods=['POST'])
def predict():
    try:
        file = request.files['file']
        image_path = f"../images/{file.filename}"
        file.save(image_path)

        # Appeler la fonction predict_vehicle
        result = predict_vehicle(image_path)
        return jsonify({"result": result})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
