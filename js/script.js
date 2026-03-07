// AI Voice Logic
const micBtn = document.getElementById('mic-btn');
const responseText = document.getElementById('ai-response');

const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
if (SpeechRecognition) {
    const recognition = new SpeechRecognition();

    micBtn.onclick = () => {
        recognition.start();
        responseText.innerText = "System Listening...";
    };

    recognition.onresult = (event) => {
        const command = event.results[0][0].transcript.toLowerCase();
        handleCommand(command);
    };
}

function handleCommand(cmd) {
    if (cmd.includes("show projects")) {
        window.location.href = "#projects";
        responseText.innerText = "Accessing Repositories...";
    } else if (cmd.includes("admin mode")) {
        window.location.href = "#admin";
        responseText.innerText = "Authorized. Root access granted.";
    }
}

// Project Filtering
function filterSelection(c) {
    let x = document.getElementsByClassName("project-card");
    if (c == "all") c = "";
    for (let i = 0; i < x.length; i++) {
        x[i].style.display = x[i].className.includes(c) ? "block" : "none";
    }
}