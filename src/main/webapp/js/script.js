// Admin sidebar collapse toggle; the state is remembered in localStorage.
// The saved state is applied by the inline script in WEB-INF/views/includes/admin/navbar.jsp.
// Delegated on document because the toggle button lives in the page content,
// which js/admin_nav.js swaps without reloading the page.
document.addEventListener("click", (event) => {
    const toggle = event.target.closest(".sidebar-toggle");
    const sidebar = document.querySelector("nav.sidebar");
    if (!toggle || !sidebar) return;

    sidebar.classList.toggle("close");
    try {
        localStorage.setItem("status", sidebar.classList.contains("close") ? "close" : "open");
    } catch (e) { /* storage unavailable: state just won't persist */ }
});
