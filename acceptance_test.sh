#!/bin/bash

# Récupérer dynamiquement le port exposé par le service calculator via Docker Compose
CALCULATOR_PORT=$(docker-compose port calculator 8080 | cut -d: -f2)

# Tentatives de connexion (jusqu'à 10 fois)
for i in {1..10}; do
    response=$(curl -sf http://localhost:${CALCULATOR_PORT}/sum?a=1\&b=2)

    if [[ $? -eq 0 && -n "$response" ]]; then
        echo "Réponse de l'app : $response"

        if [ "$response" -eq 3 ]; then
            echo "Test d'acceptance réussi ✅"
            exit 0
        else
            echo "Test échoué ❌ - Mauvaise réponse attendue"
            exit 1
        fi
    else
        echo "App non disponible (tentative $i/10)..."
        sleep 5
    fi
done

echo "Erreur : L'application n'a pas répondu correctement après 10 tentatives."
exit 1
