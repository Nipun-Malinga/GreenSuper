<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>
<!--Main Section-->
<%-- Sized to fit the viewport: <main> fills the space between navbar and footer. --%>
<main class="container-page flex flex-1 items-center py-6 lg:py-10">
    <div class="mx-auto grid w-full max-w-5xl items-center gap-6 md:grid-cols-2 lg:gap-12">
        <div class="card hidden p-6 md:block">
            <img src="./images/main/contact/icon12.png" alt="" class="mx-auto max-h-[45vh] w-full max-w-sm object-contain">
        </div>
        <div>
            <span class="eyebrow"><i class="fa fa-envelope"></i> Contact Us</span>
            <h1 class="page-title mt-2">We'd love to hear from you.</h1>
            <p class="lead mt-2">Questions about an order, a product, or just want to say hi? Reach out any time.</p>

            <div class="mt-5 space-y-3 sm:mt-6 sm:space-y-4">
                <a href="mailto:greensuper@gmail.com" class="group card card-hover flex items-center gap-4 p-5">
                    <img src="./images/main/contact/email.png" alt="" class="size-11">
                    <div class="min-w-0">
                        <p class="text-sm font-medium text-slate-500">E-mail</p>
                        <p class="truncate text-base font-semibold text-brand-700 group-hover:underline sm:text-lg">greensuper@gmail.com</p>
                    </div>
                    <i class="fa fa-arrow-right ml-auto text-slate-400 transition-transform group-hover:translate-x-0.5 group-hover:text-brand-600"></i>
                </a>
                <div class="card p-5">
                    <h2 class="text-sm font-medium text-slate-500">Follow Us</h2>
                    <div class="mt-3 flex gap-4">
                        <a href="#" aria-label="Facebook"><img src="./images/main/contact/f.png" alt="Facebook" class="size-10 transition hover:scale-110"></a>
                        <a href="#" aria-label="Instagram"><img src="./images/main/contact/i.png" alt="Instagram" class="size-10 transition hover:scale-110"></a>
                        <a href="#" aria-label="Twitter"><img src="./images/main/contact/t.png" alt="Twitter" class="size-10 transition hover:scale-110"></a>
                        <a href="#" aria-label="WhatsApp"><img src="./images/main/contact/w.png" alt="WhatsApp" class="size-10 transition hover:scale-110"></a>
                    </div>
                </div>
                <a href="feedback.jsp" class="inline-flex items-center gap-2 text-sm font-semibold text-brand-700 hover:underline"><i class="fa fa-comment-dots"></i> Already ordered? Leave us feedback</a>
            </div>
        </div>
    </div>
</main>
<!--Footer-->
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
