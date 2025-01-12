# Correction et amélioration du scraping Google Images
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import requests

# Variables de configuration
search_queries = ["BMW 116d", "Porsche 718 GTS", "Cayenne", "E90", "Golf 7", "Mazda MX5", "Volkswagen Polo 5", "Mazda RX8"]
images_per_class = 10  # On a réduit pour tester (augmenter après validation)
output_dir = "car_images"
scroll_pause_time = 2  # Pause pour le chargement des images
driver_path = r"C:\Users\mathi\Desktop\TrainingVoiture\chromedriver.exe"

# Configuration du WebDriver
service = Service(driver_path)
driver = webdriver.Chrome(service=service)

# Fonction pour télécharger une image
def download_image(image_url, save_path):
    try:
        img_data = requests.get(image_url, timeout=10).content
        with open(save_path, 'wb') as file:
            file.write(img_data)
    except Exception as e:
        print(f"Erreur lors du téléchargement : {e}")

# Scraping de Google Images
for query in search_queries:
    # Préparer le dossier de sortie
    class_name = query.replace(" ", "_")
    class_dir = os.path.join(output_dir, class_name)
    os.makedirs(class_dir, exist_ok=True)

    # Accéder à Google Images
    driver.get("https://images.google.com/")

    # Accepter les cookies si nécessaire
    try:
        cookie_button = WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Accepter')]"))
        )
        cookie_button.click()
    except Exception:
        print("Pas de pop-up de cookies détectée.")

    # Effectuer la recherche
    search_box = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable((By.NAME, "q"))
    )
    search_box.send_keys(query)
    search_box.send_keys(Keys.RETURN)

    # Scroller pour charger plus d'images
    for _ in range(10):  
        driver.execute_script("window.scrollBy(0, 1000);")
        time.sleep(scroll_pause_time)

    # Récupérer les vignettes
    thumbnails = driver.find_elements(By.CSS_SELECTOR, "img.rg_i")
    print(f"Trouvé {len(thumbnails)} vignettes pour {query}")

    # Télécharger les images
    for index, thumbnail in enumerate(thumbnails[:images_per_class]):
        try:
            # Cliquer sur la vignette pour afficher l'image grande
            thumbnail.click()
            time.sleep(1)

            # Récupérer l'URL de l'image grande
            large_image = WebDriverWait(driver, 5).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "img.n3VNCb"))
            )
            image_url = large_image.get_attribute("src")
            if image_url and image_url.startswith("http"):
                save_path = os.path.join(class_dir, f"{index + 1}.jpg")
                download_image(image_url, save_path)
                print(f"Image {index + 1} téléchargée : {image_url}")
        except Exception as e:
            print(f"Erreur sur l'image {index + 1}: {e}")

driver.quit()
print("Scraping terminé.")