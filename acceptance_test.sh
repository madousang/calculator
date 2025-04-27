#!/bin/bash

# Tentatives de connexion (jusqu'à 10 fois)
for i in {1..10}; do
    # Essayer de récupérer la réponse avec curl
    response=$(curl -sf http://localhost:8081/sum?a=1\&b=2)

    if [[ $? -eq 0 && -n "$response" ]]; then
        echo "Réponse de l'app : $response"

        # Vérifier que la réponse est 3
        if [ "$response" -eq 3 ]; then
            echo "Test d'acceptance réussi ✅"
            exit 0
        else
            echo "Test échoué ❌ - Mauvaise réponse attendue"
            exit 1
        fi
    else
        echo "App non disponible (tentative $i/10)..."
        sleep 20  # Un peu moins long au début
    fi
done

echo "Erreur : L'application n'a pas répondu correctement après 10 tentatives."
exit 1
