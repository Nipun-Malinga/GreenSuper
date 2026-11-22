<%-- Product card. Statically included inside a loop that declares `product` (org.example.greensuper.models.Product). --%>
<%!
    // Admin-entered text: escape before writing into HTML.
    private static String esc(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
                .replace("\"", "&quot;").replace("'", "&#39;");
    }
%>
<%
    String cardName = esc(product.getProductName());
    String cardDescription = esc(product.getDescription() == null ? "" : product.getDescription().trim());
    boolean cardOutOfStock = product.getQuantity() <= 0;
    boolean cardLowStock = !cardOutOfStock && product.getQuantity() <= 5;
%>
<article class="group card card-hover flex flex-col overflow-hidden">
    <div class="relative aspect-[4/3] overflow-hidden bg-slate-100">
        <img src="./uploadedImages/product/<%= product.getImageName() %>" alt="<%= cardName %>" loading="lazy"
             class="size-full object-cover transition duration-500 group-hover:scale-105 <%= cardOutOfStock ? "opacity-60 grayscale" : "" %>" />
        <% if (cardOutOfStock) { %>
        <span class="absolute top-3 left-3 rounded-full bg-slate-900/80 px-2.5 py-1 text-[0.7rem] font-semibold text-white backdrop-blur">Out of stock</span>
        <% } else if (cardLowStock) { %>
        <span class="absolute top-3 left-3 rounded-full bg-amber-100 px-2.5 py-1 text-[0.7rem] font-semibold text-amber-800 ring-1 ring-amber-200">Only <%= product.getQuantity() %> left</span>
        <% } %>
    </div>

    <div class="flex flex-1 flex-col p-4">
        <div class="mb-3">
            <h3 class="line-clamp-2 text-sm font-semibold sm:text-base" title="<%= cardName %>"><%= cardName %></h3>
            <% if (!cardDescription.isEmpty()) { %>
            <p class="mt-1 line-clamp-2 text-xs leading-relaxed text-slate-500 sm:text-sm" title="<%= cardDescription %>"><%= cardDescription %></p>
            <% } %>
        </div>

        <div class="mt-auto flex items-center justify-between gap-2 border-t border-slate-100 pt-3">
            <p class="price text-lg"><small>Rs.</small><%= String.format("%,.2f", product.getPrice()) %></p>
            <% if (cardOutOfStock) { %>
            <button type="button" class="btn btn-outline size-10 shrink-0 rounded-full p-0 sm:w-auto sm:px-4" disabled aria-label="<%= cardName %> is out of stock">
                <i class="fa fa-ban"></i><span class="hidden sm:inline">Sold out</span>
            </button>
            <% } else { %>
            <button type="button" class="btn btn-primary size-10 shrink-0 rounded-full p-0 sm:w-auto sm:px-4"
                    onclick="AddToCart(<%= product.getProductId() %>)" aria-label="Add <%= cardName %> to cart">
                <i class="fa fa-cart-plus"></i><span class="hidden sm:inline">Add</span>
            </button>
            <% } %>
        </div>
        <span id="product<%= product.getProductId() %>" class="mt-3 rounded-lg bg-brand-50 py-1.5 text-center text-xs font-semibold text-brand-700 empty:hidden"></span>
    </div>
</article>
