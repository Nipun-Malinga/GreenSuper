/*
 * Admin "shell" navigation: keeps the sidebar on screen and swaps only the
 * page content (<section class="dashboard">) when moving between admin pages.
 *
 * - Clicks on links to admin_*.jsp pages are fetched in the background; the
 *   new page's .dashboard replaces the current one, and the URL/title update.
 * - Back/Forward work. Pages with a form are restored from memory, so what you
 *   typed survives "Try again" on the failure page; list pages are re-fetched
 *   so they are always fresh.
 * - Anything unexpected (expired session, server error, non-admin page,
 *   old browser) falls back to a normal full page load.
 * - Add data-full-reload to a link to opt it out.
 */
(function () {
    if (!window.fetch || !window.DOMParser || !window.history.pushState) return;

    const SHELL = "section.dashboard";

    // Which sidebar entry each page belongs to.
    const SECTION_OF = {
        "admin.jsp": "admin.jsp",
        "admin_categories.jsp": "admin_categories.jsp",
        "admin_add_category.jsp": "admin_categories.jsp",
        "admin_manage_category.jsp": "admin_categories.jsp",
        "admin_products.jsp": "admin_products.jsp",
        "admin_add_product.jsp": "admin_products.jsp",
        "admin_manage_product.jsp": "admin_products.jsp",
        "admin_customers.jsp": "admin_customers.jsp",
        "admin_orders.jsp": "admin_orders.jsp"
    };

    // Form pages kept in memory for Back/Forward, keyed by history entry id.
    const snapshots = new Map();
    const MAX_SNAPSHOTS = 10;
    let entryId = 0;
    let currentId = null; // history entry id of the page on screen
    let inFlight = null;

    function pageName(url) {
        return new URL(url, location.href).pathname.split("/").pop();
    }

    function isAdminPage(url) {
        const name = pageName(url);
        return name.startsWith("admin") && name.endsWith(".jsp") && name !== "admin_login.jsp";
    }

    function markActive(url) {
        const section = SECTION_OF[pageName(url)];
        document.querySelectorAll(".sidebar a.admin-link").forEach(function (link) {
            if (section && pageName(link.href) === section) {
                link.setAttribute("aria-current", "page");
            } else {
                link.removeAttribute("aria-current");
            }
        });
    }

    function newEntryId() {
        entryId += 1;
        return Date.now() + "-" + entryId;
    }

    function rememberCurrent() {
        const current = document.querySelector(SHELL);
        if (!current || !currentId || !current.querySelector("form[data-async-form]")) return;
        snapshots.set(currentId, { node: current, title: document.title, url: current.dataset.url || location.href });
        while (snapshots.size > MAX_SNAPSHOTS) {
            snapshots.delete(snapshots.keys().next().value);
        }
    }

    function show(node, title, url) {
        const current = document.querySelector(SHELL);
        current.replaceWith(node);
        node.removeAttribute("aria-busy");
        node.dataset.url = url;
        document.title = title;
        markActive(url);
        window.scrollTo(0, 0);
        if (window.initAdminForms) window.initAdminForms(node);
        const heading = node.querySelector("h1");
        if (heading) {
            heading.setAttribute("tabindex", "-1");
            heading.focus({ preventScroll: true });
        }
    }

    async function navigate(url, options) {
        const push = !options || options.push !== false;
        const current = document.querySelector(SHELL);
        if (!current) {
            location.href = url;
            return;
        }

        if (inFlight) inFlight.abort();
        const controller = new AbortController();
        inFlight = controller;
        current.setAttribute("aria-busy", "true");

        try {
            const res = await fetch(url, { credentials: "same-origin", signal: controller.signal });

            // Expired session (redirected to login), server errors, etc.: do a real page load.
            if (!res.ok || !isAdminPage(res.url)) {
                location.href = res.ok ? res.url : url;
                return;
            }

            const doc = new DOMParser().parseFromString(await res.text(), "text/html");
            const next = doc.querySelector(SHELL);
            if (!next) {
                location.href = url;
                return;
            }

            if (push) {
                rememberCurrent();
                currentId = newEntryId();
                history.pushState({ adminNavId: currentId }, "", res.url);
            } else if (res.url !== location.href) {
                history.replaceState(history.state, "", res.url);
            }
            show(document.adoptNode(next), doc.title, res.url);
        } catch (err) {
            if (err.name !== "AbortError") location.href = url;
        } finally {
            if (inFlight === controller) inFlight = null;
            current.removeAttribute("aria-busy");
        }
    }

    // Intercept clicks on links to other admin pages.
    document.addEventListener("click", function (event) {
        if (event.defaultPrevented || event.button !== 0 ||
            event.metaKey || event.ctrlKey || event.shiftKey || event.altKey) return;

        const link = event.target.closest("a[href]");
        if (!link || link.target || link.hasAttribute("download") || link.hasAttribute("data-full-reload")) return;

        const url = new URL(link.href, location.href);
        if (url.origin !== location.origin || !isAdminPage(url.href)) return;
        if (url.pathname === location.pathname && url.search === location.search && url.hash) return;

        event.preventDefault();
        navigate(url.href);
    });

    // Back / Forward.
    window.addEventListener("popstate", function (event) {
        const id = event.state && event.state.adminNavId;
        rememberCurrent();          // save the page we are leaving
        currentId = id || newEntryId();
        if (!id) history.replaceState({ adminNavId: currentId }, "", location.href);

        const snapshot = id && snapshots.get(id);
        if (snapshot && snapshot.url === location.href) {
            show(snapshot.node, snapshot.title, snapshot.url);
        } else {
            navigate(location.href, { push: false });
        }
    });

    // Tag the first page so it can be snapshotted too.
    currentId = newEntryId();
    history.replaceState({ adminNavId: currentId }, "", location.href);
    const initial = document.querySelector(SHELL);
    if (initial) initial.dataset.url = location.href;
    markActive(location.href);

    // Used by js/admin_forms.js to move on after a form submit without a reload.
    window.adminNavigate = navigate;
})();
