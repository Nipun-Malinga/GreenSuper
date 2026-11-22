<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>

<%-- Sized to fit the viewport: <main> fills the space between navbar and footer. --%>
<main class="container-page flex flex-1 items-center py-4 sm:py-6 lg:py-10">
    <div class="grid w-full items-center gap-4 sm:gap-6 lg:grid-cols-2 lg:gap-14">
        <div>
            <span class="eyebrow"><i class="fa fa-leaf"></i> About Green Super</span>
            <h1 class="mt-1 text-2xl sm:mt-2 font-bold sm:text-4xl lg:text-5xl">Where sustainability meets <span class="text-brand-600">convenience.</span></h1>
            <p class="mt-2 text-sm leading-normal text-slate-600 sm:mt-4 sm:text-base sm:leading-relaxed lg:text-lg">
                We are dedicated to providing eco-conscious consumers with a diverse range of responsibly sourced products.
                Our commitment to reducing environmental impact extends from our carefully curated selection to our eco-friendly practices.
                We believe that every small, conscious choice contributes to a greener, healthier planet.
                Join us in making a positive impact through mindful shopping.
            </p>
            <div class="mt-4 flex flex-wrap gap-3 sm:mt-6">
                <a href="categories.jsp" class="btn btn-primary rounded-full px-6 max-sm:py-2">Start shopping <i class="fa fa-arrow-right"></i></a>
                <a href="contact.jsp" class="btn btn-outline rounded-full px-6 max-sm:py-2">Get in touch</a>
            </div>
        </div>

        <div class="rounded-3xl bg-gradient-to-br from-brand-700 to-brand-900 p-3 shadow-lg sm:p-8">
            <ul class="grid grid-cols-3 gap-2 sm:gap-3 lg:grid-cols-1 lg:gap-4">
                <li class="flex flex-col items-center gap-2 rounded-2xl bg-white/10 p-2.5 sm:p-3 text-center ring-1 ring-white/15 lg:flex-row lg:items-start lg:gap-4 lg:p-5 lg:text-left">
                    <span class="grid size-8 shrink-0 sm:size-10 place-items-center rounded-xl bg-white text-brand-700 lg:size-12 lg:text-xl"><i class="fa fa-leaf"></i></span>
                    <div>
                        <h2 class="text-xs font-semibold text-white sm:text-sm lg:text-base">Responsibly sourced</h2>
                        <p class="mt-1 hidden text-sm text-brand-100 lg:block">Products chosen with care for the people and places that grow them.</p>
                    </div>
                </li>
                <li class="flex flex-col items-center gap-2 rounded-2xl bg-white/10 p-2.5 sm:p-3 text-center ring-1 ring-white/15 lg:flex-row lg:items-start lg:gap-4 lg:p-5 lg:text-left">
                    <span class="grid size-8 shrink-0 sm:size-10 place-items-center rounded-xl bg-white text-brand-700 lg:size-12 lg:text-xl"><i class="fa fa-recycle"></i></span>
                    <div>
                        <h2 class="text-xs font-semibold text-white sm:text-sm lg:text-base">Eco-friendly practices</h2>
                        <p class="mt-1 hidden text-sm text-brand-100 lg:block">Less waste and lower impact, from our shelves to your doorstep.</p>
                    </div>
                </li>
                <li class="flex flex-col items-center gap-2 rounded-2xl bg-white/10 p-2.5 sm:p-3 text-center ring-1 ring-white/15 lg:flex-row lg:items-start lg:gap-4 lg:p-5 lg:text-left">
                    <span class="grid size-8 shrink-0 sm:size-10 place-items-center rounded-xl bg-white text-brand-700 lg:size-12 lg:text-xl"><i class="fa fa-heart"></i></span>
                    <div>
                        <h2 class="text-xs font-semibold text-white sm:text-sm lg:text-base">Mindful shopping</h2>
                        <p class="mt-1 hidden text-sm text-brand-100 lg:block">Every small, conscious choice adds up to a healthier planet.</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
