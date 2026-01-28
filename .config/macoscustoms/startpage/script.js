// ==============================
// Objects
// ==============================
const searchInput    = document.getElementById("searchInput");
const settingsButton = document.getElementById("settingsButton");
const settingsPanel  = document.getElementById("settingsPanel");
const engineSelect   = document.getElementById("engineSelect");

// ==============================
// Search engines
// ==============================
const engines = {
    duckduckgo: "https://duckduckgo.com/?q=",
    google:     "https://www.google.com/search?q=",
    yandex:     "https://yandex.com/search/?text=",
    startpage:  "https://www.startpage.com/do/search?q=",
    perplexity: "https://www.perplexity.ai/search?q="
};

/* Load saved engine */
const savedEngine =
    localStorage.getItem("searchEngine") || "duckduckgo";

engineSelect.value = savedEngine;

/* Autofocus */
window.addEventListener("load", () => {
    searchInput.focus();
});

/* Save engine */
engineSelect.addEventListener("change", () => {
    localStorage.setItem(
        "searchEngine",
        engineSelect.value
    );
});

// ==============================
// Settings toggle
// ==============================
let settingsHover = false;
let hideTimeout = null;

settingsButton.addEventListener("mouseenter", () => {
    settingsHover = true;
    settingsPanel.classList.add("visible");
    
    // Отменяем предыдущий таймер скрытия
    if (hideTimeout) {
        clearTimeout(hideTimeout);
        hideTimeout = null;
    }
});

settingsPanel.addEventListener("mouseenter", () => {
    settingsHover = true;
    
    // Отменяем предыдущий таймер скрытия
    if (hideTimeout) {
        clearTimeout(hideTimeout);
        hideTimeout = null;
    }
});

settingsButton.addEventListener("mouseleave", () => {
    settingsHover = false;
    hideSettingsLater();
});

settingsPanel.addEventListener("mouseleave", () => {
    settingsHover = false;
    hideSettingsLater();
});

function hideSettingsLater() {
    // Отменяем предыдущий таймер, если он есть
    if (hideTimeout) {
        clearTimeout(hideTimeout);
    }
    
    // Устанавливаем новый таймер
    hideTimeout = setTimeout(() => {
        if (!settingsHover) {
            settingsPanel.classList.remove("visible");
        }
        hideTimeout = null;
    }, 120);
}

// ==============================
// Dumb typing
// ==============================
document.addEventListener("keydown", (event) => {
    const active = document.activeElement;

    if (active === searchInput) {
        return;
    }

    if (
        event.ctrlKey ||
        event.metaKey ||
        event.altKey
    ) {
        return;
    }

    if (event.key === "Backspace") {
        event.preventDefault();
        searchInput.focus();
        searchInput.value =
            searchInput.value.slice(0, -1);
        return;
    }

    if (event.key.length !== 1) {
        return;
    }

    event.preventDefault();
    searchInput.focus();
    searchInput.value += event.key;
});

// ==============================
// Search
// ==============================
searchInput.addEventListener("keydown", (event) => {
    if (event.key === "Enter") {
        const query = searchInput.value.trim();

        if (!query) {
            return;
        }

        const engine =
            localStorage.getItem("searchEngine") ||
            "duckduckgo";

        window.location.href =
            engines[engine] +
            encodeURIComponent(query);
    }
});
