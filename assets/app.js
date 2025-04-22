import './styles/app.css';

document.addEventListener("DOMContentLoaded", function () {
    let captchaText = "";

    function generateCaptchaText(length = 5) {
        const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        let text = "";
        for (let i = 0; i < length; i++) {
            text += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        return text;
    }

    function drawCaptcha(text) {
        const canvas = document.getElementById("captchaCanvas");
        const ctx = canvas.getContext("2d");

        // Fond
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "#e0e0e0"; // un gris un peu plus foncé
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        // Bruit
        for (let i = 0; i < 10; i++) {
            ctx.strokeStyle = `rgba(0,0,0,${Math.random()})`;
            ctx.beginPath();
            ctx.moveTo(Math.random() * canvas.width, Math.random() * canvas.height);
            ctx.lineTo(Math.random() * canvas.width, Math.random() * canvas.height);
            ctx.stroke();
        }

        // Texte
        ctx.font = "28px Arial";
        ctx.fillStyle = "black";
        ctx.setTransform(1, 0, 0, 1, 0, 0); // reset transform
        for (let i = 0; i < text.length; i++) {
            const angle = (Math.random() - 0.5) * 0.4;
            ctx.setTransform(Math.cos(angle), Math.sin(angle), -Math.sin(angle), Math.cos(angle), 10 + i * 25, 35);
            ctx.fillText(text[i], 0, 0);
        }

        ctx.setTransform(1, 0, 0, 1, 0, 0); // reset transform
    }

    function generateNewCaptcha() {
        captchaText = generateCaptchaText();
        drawCaptcha(captchaText);
    }

    // Initial captcha
    generateNewCaptcha();

    // Refresh
    document.getElementById("refreshCaptcha").addEventListener("click", generateNewCaptcha);

    // Validation à la soumission
    const form = document.getElementById("registration_form");
    form.addEventListener("submit", function (e) {
        const input = document.getElementById("captchaInput").value.trim();
        const error = document.getElementById("captchaError");

        if (input.toUpperCase() !== captchaText.toUpperCase()) {
            e.preventDefault();
            error.classList.remove("d-none");
        } else {
            error.classList.add("d-none");
        }
    });
});