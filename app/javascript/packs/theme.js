const getSavedTheme = () => localStorage.getItem("tui-theme") || "dark";

const applyTheme = (theme) => {
  document.documentElement.setAttribute("data-theme", theme);
  const label = document.getElementById("theme-toggle-label");
  if (label) {
    label.textContent = `[theme: ${theme}]`;
  }
};

document.addEventListener("turbo:load", () => {
  applyTheme(getSavedTheme());
});

document.addEventListener("click", (e) => {
  const btn = e.target.closest("#theme-toggle-btn");
  if (!btn) return;

  e.preventDefault();
  const current = document.documentElement.getAttribute("data-theme") || getSavedTheme();
  const next = current === "dark" ? "light" : "dark";
  localStorage.setItem("tui-theme", next);
  applyTheme(next);
});
