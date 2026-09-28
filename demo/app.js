const example = document.getElementById("example");
const preview = document.getElementById("preview");
const openPdf = document.getElementById("open-pdf");

example.addEventListener("change", () => {
  preview.src = example.value;
  openPdf.href = example.value;
});
