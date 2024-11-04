#!/bin/bash

# Configuration des variables
TIMESTAMP=$(date +'%Y-%m-%d-%H-%M')                             # Horodatage pour différencier les fichiers de sauvegarde
BACKUP_DIR="/var/www/html/share/backups"                        # Chemin où les sauvegardes seront stockées
DB_NAME="dbshare"                                               # Nom de la base de données à sauvegarder
DB_USER="login8078"                                             # Nom d'utilisateur de la base de données
DB_PASS="crxDrPAvplynKfo"                                       # Mot de passe de la base de données
DUMP_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql"             # Nom du fichier de sauvegarde
ENCRYPTED_FILE="$BACKUP_DIR/${DB_NAME}_${TIMESTAMP}.sql.enc"    # Nom du fichier chiffré
ENCRYPTION_PASSWORD="share"                                     # Mot de passe pour le chiffrement
CHECKSUM_FILE="$ENCRYPTED_FILE.sha256"                          # Fichier de somme de contrôle

# # Détails du serveur distant
# REMOTE_USER="user_remote"                                       # Nom d'utilisateur du serveur distant
# REMOTE_HOST="host_remote"                                       # Adresse IP ou nom de domaine du serveur distant
# REMOTE_DIR="/var/www/html/share/backup"                         # Répertoire de destination sur le serveur distant

# Exportation de la base de données
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DUMP_FILE"

# Vérification de l'opération de dump
if [ $? -eq 0 ]; then
    echo "La sauvegarde de la base de données $DB_NAME a réussi : $DUMP_FILE"
else
    echo "Erreur lors de la sauvegarde de la base de données $DB_NAME"
    exit 1
fi

# Chiffrement du fichier de sauvegarde
openssl enc -aes-256-cbc -salt -in "$DUMP_FILE" -out "$ENCRYPTED_FILE" -k "$ENCRYPTION_PASSWORD"

# Vérification de l'opération de chiffrement
if [ $? -eq 0 ]; then
    echo "Le fichier de sauvegarde a été chiffré avec succès : $ENCRYPTED_FILE"
    # Supprime le fichier non chiffré
    rm "$DUMP_FILE"
else
    echo "Erreur lors du chiffrement du fichier de sauvegarde"
    exit 1
fi

# Génération de la somme de contrôle du fichier chiffré
# sha256sum "$ENCRYPTED_FILE" > "$CHECKSUM_FILE"

# # Envoi du fichier chiffré et de la somme de contrôle vers le serveur distant
# scp "$ENCRYPTED_FILE" #"$CHECKSUM_FILE" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# # Vérification de l'envoi
# if [ $? -eq 0 ]; then
#     echo "Le fichier de sauvegarde chiffré et le fichier de somme de contrôle ont été envoyés avec succès"
#     # Supprime les fichiers locaux après l'envoi
#     rm "$ENCRYPTED_FILE" "$CHECKSUM_FILE"
# else
#     echo "Erreur lors de l'envoi des fichiers vers le serveur distant"
#     exit 1
# fi

# # Commande pour vérifier l'intégrité sur le serveur distant
# ssh "$REMOTE_USER@$REMOTE_HOST" << EOF
# cd "$REMOTE_DIR"
# # Calculer la somme de contrôle du fichier reçu
# sha256sum -c "$(basename "$CHECKSUM_FILE")" --status
# if [ $? -eq 0 ]; then
#     echo "Vérification réussie : le fichier reçu est identique à celui envoyé."
# else
#     echo "Échec de la vérification : le fichier reçu est différent de celui envoyé."
#     exit 1
# fi
# EOF