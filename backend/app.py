# app.py

import os
from flask import Flask, request, jsonify
from flask_cors import CORS
import logging
import dlib
import cv2
import numpy as np

# Import feature extraction functions
from feature_extraction import initialize_dlib_models, return_features_mean_personX, save_features_to_csv

app = Flask(__name__)
CORS(app)

# Define the uploads folder path relative to the backend folder
UPLOAD_FOLDER = os.path.join(os.path.dirname(__file__), 'uploads')
if not os.path.exists(UPLOAD_FOLDER):
    try:
        os.makedirs(UPLOAD_FOLDER)
        print(f"Directory created: {UPLOAD_FOLDER}")
    except Exception as e:
        print(f"Failed to create directory: {e}")

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@app.route('/register-student', methods=['POST'])
def register_student():
    if 'capturedImage' not in request.files:
        return jsonify({"error": "No file part"}), 400

    file = request.files['capturedImage']
    name = request.form.get('name')
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400

    if file:
        filename = 'captured_image.jpg'
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        print(f"Saving file to: {filepath}")  # Debug line
        try:
            file.save(filepath)
        except Exception as e:
            return jsonify({"error": f"Failed to save file: {e}"}), 500

        # Initialize Dlib models
        path_dlib = os.path.join(os.path.dirname(__file__),"data", 'data_dlib')
        features_file = os.path.join(os.path.dirname(__file__), 'data', 'features_all.csv')
        if not os.path.exists(path_dlib):
            return jsonify({"error": f"Dlib data path {path_dlib} does not exist."}), 500

        # Process the image
        detector, predictor, face_reco_model = initialize_dlib_models(path_dlib)
        features_mean_personX = return_features_mean_personX(filepath, detector, predictor, face_reco_model)

        # Save the features to a CSV file
        try:
            save_features_to_csv(features_mean_personX, name, features_file)
        except Exception as e:
            return jsonify({"error": str(e)}), 500

        # Return the features and name as JSON
        features_response = {
            "name": name,
            "features": features_mean_personX.tolist()  # Convert numpy array to list
        }
        return jsonify({"message": "Student registered successfully", "data": features_response}), 200
# Initialize Dlib components
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor('data/data_dlib/shape_predictor_68_face_landmarks.dat')
face_reco_model = dlib.face_recognition_model_v1("data/data_dlib/dlib_face_recognition_resnet_model_v1.dat")

@app.route('/recognize', methods=['POST'])
def recognize_face():
    file = request.files['image']
    np_arr = np.frombuffer(file.read(), np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)

    faces = detector(img, 0)
    face_features = []

    for face in faces:
        shape = predictor(img, face)
        face_descriptor = face_reco_model.compute_face_descriptor(img, shape)
        face_features.append(np.array(face_descriptor).tolist())

    return jsonify({'face_features': face_features})


if __name__ == '__main__':
    app.run(port=3000)