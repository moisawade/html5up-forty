# Étape 1 : Build (Préparation des fichiers)
FROM alpine:latest AS builder

# Définition du dossier de travail pour regrouper les assets
WORKDIR /app

# Copie de tous les fichiers et dossiers sources dans l'image temporaire
COPY index.html elements.html generic.html landing.html LICENSE.txt README.txt ./
COPY assets/ ./assets/
COPY images/ ./images/

# Étape 2 : Production (Image finale optimisée)
#FROM nginx:alpine
FROM nginxinc/nginx-unprivileged:stable

# Copie uniquement des fichiers préparés depuis l'étape 'builder'
COPY --from=builder /app /usr/share/nginx/html

# Exposition du port HTTP
EXPOSE 80

# Lancement de Nginx
#CMD ["nginx", "-g", "daemon off;"]