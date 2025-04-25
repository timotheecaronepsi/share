import './styles/app.css';      //import app.css (ne pas enlever!!!)

/* JS du captacha */
document.addEventListener("DOMContentLoaded", function () {
    let captchaText = "";

    function generateCaptchaText(length = 5) {
        const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        let text = "";
        for (let i = 0; i < length; i++) {
            text += chars.charAt(Math.floor(Math.random() * chars.length));     // le random sert à choisir au hasard dans les caractères dans chars
        }
        return text;
    }

    function drawCaptcha(text) {
        const canvas = document.getElementById("captchaCanvas");
        const ctx = canvas.getContext("2d");

        ctx.clearRect(0, 0, canvas.width, canvas.height);   //0, 0 = x, y        // clear l'ancien captcha pour le rafraichisseur
        ctx.fillStyle = "#e0e0e0";                                               // couleur de fond cu canvas
        ctx.fillRect(0, 0, canvas.width, canvas.height);                         // Remplis le canvas

        // Bruit visuel (les lignes en noir)
        for (let i = 0; i < 10; i++) {
            ctx.strokeStyle = `rgba(0,0,0,${Math.random()})`;          // définie la couleur (noir = 0,0,0,) et la transparence en random
            ctx.beginPath();                                                                //Création du chemin
            ctx.moveTo(Math.random() * canvas.width, Math.random() * canvas.height);        // Point de départ
            ctx.lineTo(Math.random() * canvas.width, Math.random() * canvas.height);        // Point d'arrivé
            ctx.stroke();                                                                   // Dessine entre les deux points
        }

        // Texte
        ctx.font = "28px Arial";
        ctx.fillStyle = "black";
        ctx.setTransform(1, 0, 0, 1, 0, 0);     // reset le rotate translate etc... car garder en mémoire à chaque canvas
        for (let i = 0; i < text.length; i++) {             // on dessine chaque lettre séparement pour pouvoir lui mettre un angle différent
            const angle = (Math.random() - 0.5) * 0.4;
            ctx.setTransform(Math.cos(angle), Math.sin(angle), -Math.sin(angle), Math.cos(angle), 10 + i * 25, 35);     // utilisation de matrice 2D
            ctx.fillText(text[i], 0, 0);            // affiche donc la lettre a la position donné
        }

        ctx.setTransform(1, 0, 0, 1, 0, 0);     // reset le rotate translate etc... car garder en mémoire à chaque canvas
    }

    function generateNewCaptcha() {
        captchaText = generateCaptchaText();
        drawCaptcha(captchaText);
    }

    // Initialise le captcha dés que la page est chargé
    generateNewCaptcha();

    // Refresh du captcha
    document.getElementById("refreshCaptcha").addEventListener("click", generateNewCaptcha);    // ajout d'un event listener sur le bouton ↻

    // Validation à la soumission
    const form = document.getElementById("registration_form");      // On passe l'id du form venant de la vue
    form.addEventListener("submit", function (e) {                           // on ajoute un event listener sur le submit
        const input = document.getElementById("captchaInput").value.trim();  // on récupère la valeur du captcha dans le form et trim enlève les espaces
        const error = document.getElementById("captchaError");              // récupère le message d'erreur dans le html

        if (input.toUpperCase() !== captchaText.toUpperCase()) {            // vérifier que le captcha est bon
            e.preventDefault();                                             //empèche l'envoie du formulaire
            error.classList.remove("d-none");               // affiche le message d'erreur (enlève la classe bootstrap pour afficher l'erreur)
        } else {
            error.classList.add("d-none");                  // si il est bon on cache le message d'erreur (toujours avec bootsrap)
        }
    });
});