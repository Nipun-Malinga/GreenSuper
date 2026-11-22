// Admin sidebar collapse toggle; the state is remembered in localStorage.
const body = document.querySelector("body"),
    sidebar = body.querySelector("nav.sidebar"),
    sidebarToggle = body.querySelector(".sidebar-toggle");

if (sidebar) {
    let getStatus = localStorage.getItem("status");
    if (getStatus && getStatus === "close") {
        sidebar.classList.toggle("close");
    }

    if (sidebarToggle) {
        sidebarToggle.addEventListener("click", () => {
            sidebar.classList.toggle("close");
            if (sidebar.classList.contains("close")) {
                localStorage.setItem("status", "close");
            } else {
                localStorage.setItem("status", "open");
            }
        })
    }
}
