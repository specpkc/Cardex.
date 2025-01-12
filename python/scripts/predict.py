from roboflow import Roboflow

# Initialisation de Roboflow avec ta clé API
api_key = "CxMs0B91fsKZttCxS2zI"
rf = Roboflow(api_key=api_key)
project = rf.workspace().project("car_project-yyjf0")
model = project.version(1).model

def predict_vehicle(image_path):
    """
    Fonction pour analyser une image avec Roboflow.
    """
    try:
        # Analyse l'image et retourne le résultat
        result = model.predict(image_path, confidence=40, overlap=30).json()
        return result
    except Exception as e:
        # En cas d'erreur, retourne un message d'erreur
        return {"error": str(e)}
