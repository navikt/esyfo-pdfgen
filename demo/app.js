const example = document.getElementById("example");
const preview = document.getElementById("preview");
const openPdf = document.getElementById("open-pdf");

// Wonderwall only redirects top-level navigations to login; other requests get 401.
function login() {
    const redirect = window.location.pathname + window.location.search;
    window.location.assign(`/oauth2/login?redirect=${encodeURIComponent(redirect)}`);
}

let objectUrl;
let latest = 0;
async function show(url) {
    const request = ++latest;
    openPdf.href = url;

    const response = await fetch(url, { credentials: "same-origin" });

    if (request !== latest) return;

    if (response.status === 401) {
        login();
        return;
    }

    if (!response.ok) {
        preview.src = url;
        return;
    }

    const blob = await response.blob();
    if (request !== latest) return;

    if (objectUrl) URL.revokeObjectURL(objectUrl);

    objectUrl = URL.createObjectURL(blob);
    preview.src = objectUrl;
}

example.addEventListener("change", () => show(example.value));
show(example.value);
