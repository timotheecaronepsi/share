#!/bin/bash

# Configuration des variables
BACKUP_DIR="/var/www/html/share/backups"                                # Répertoire pour stocker le fichier de sauvegarde
REMOTE_USER="nom_utilisateur_distant"                                   # Nom d'utilisateur du serveur distant
REMOTE_HOST="ip_ou_nom_du_serveur_distant"                              # Adresse IP ou nom du serveur distant
REMOTE_BACKUP_DIR="/var/www/html/share/backups"                         # Répertoire de sauvegarde sur le serveur distant
ENCRYPTED_FILE="$BACKUP_DIR/dbshare_2024-11-04-00-08.sql.enc"           # Chemin du fichier de sauvegarde chiffré local
DECRYPTED_FILE="$BACKUP_DIR/dbshare_2024-11-04-00-08.sql"               # Chemin du fichier SQL déchiffré
DB_NAME="dbshare"                                                       # Nom de la base de données à restaurer
DB_USER="login8078"                                                     # Nom d'utilisateur MariaDB
DB_PASS="crxDrPAvplynKfo"                                               # Mot de passe MariaDB
ENCRYPTION_PASSWORD="share"                                             # Mot de passe pour le chiffrement


# Récupérer le fichier de sauvegarde chiffré depuis le serveur distant
scp "$REMOTE_USER@$REMOTE_HOST:$REMOTE_BACKUP_DIR/$(basename "$ENCRYPTED_FILE")" "$BACKUP_DIR/"

# Vérification du transfert
if [ $? -eq 0 ]; then
    echo "Transfert du fichier de sauvegarde depuis le serveur distant réussi."
else
    echo "Erreur lors du transfert du fichier de sauvegarde depuis le serveur distant."
    exit 1
fi

# Déchiffrement du fichier de sauvegarde
openssl enc -d -aes-256-cbc -in "$ENCRYPTED_FILE" -out "$DECRYPTED_FILE" -k "$ENCRYPTION_PASSWORD"

# Vérification de l'opération de déchiffrement
if [ $? -eq 0 ]; then
    echo "Déchiffrement réussi : $DECRYPTED_FILE"
else
    echo "Erreur lors du déchiffrement du fichier de sauvegarde"
    exit 1
fi

# Restauration de la base de données
mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$DECRYPTED_FILE"

# Vérification de l'opération de restauration
if [ $? -eq 0 ]; then
    echo "La base de données $DB_NAME a été restaurée avec succès à partir de la sauvegarde."
    # Optionnel : supprimer le fichier déchiffré pour des raisons de sécurité
    rm "$DECRYPTED_FILE"
else
    echo "Erreur lors de la restauration de la base de données $DB_NAME"
    exit 1
fi