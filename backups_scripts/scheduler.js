const cron = require('node-cron');
const { exec } = require('child_process');

// Planifiez le script pour qu'il s'exécute toutes les minutes
cron.schedule('* * * * *', () => {
    exec('/bin/bash /var/www/html/share/backups_scripts/dump_database.sh', (error, stdout, stderr) => {
        if (error) {
            console.error(`Erreur lors de l'exécution du script : ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Erreur : ${stderr}`);
            return;
        }
        console.log(`Sortie : ${stdout}`);
    });
});

console.log('Scheduler démarré. Le script sera exécuté toutes les minutes.');