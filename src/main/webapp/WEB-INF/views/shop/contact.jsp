<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>
<!--Main Section-->
<main class="container-page py-12">
    <div class="text-center">
        <h1 class="text-4xl font-bold">Contact Us</h1>
        <p class="mt-2 text-slate-500">We'd love to hear from you.</p>
    </div>

    <div class="mx-auto mt-10 grid max-w-5xl items-center gap-8 md:grid-cols-2">
        <div class="card p-6">
            <img src="./images/main/contact/icon12.png" alt="" class="mx-auto w-full max-w-sm">
        </div>
        <div class="space-y-6">
            <div class="card flex items-center gap-4 p-6">
                <img src="./images/main/contact/email.png" alt="" class="size-12">
                <div>
                    <p class="text-sm font-medium text-slate-500">E-mail</p>
                    <a href="mailto:greensuper@gmail.com" class="text-lg font-semibold text-brand-700 hover:underline">greensuper@gmail.com</a>
                </div>
            </div>
            <div class="card p-6">
                <h3 class="font-semibold">Follow Us</h3>
                <div class="mt-4 flex gap-4">
                    <a href="#" aria-label="Facebook"><img src="./images/main/contact/f.png" alt="Facebook" class="size-10 transition hover:scale-110"></a>
                    <a href="#" aria-label="Instagram"><img src="./images/main/contact/i.png" alt="Instagram" class="size-10 transition hover:scale-110"></a>
                    <a href="#" aria-label="Twitter"><img src="./images/main/contact/t.png" alt="Twitter" class="size-10 transition hover:scale-110"></a>
                    <a href="#" aria-label="WhatsApp"><img src="./images/main/contact/w.png" alt="WhatsApp" class="size-10 transition hover:scale-110"></a>
                </div>
            </div>
        </div>
    </div>
</main>
<!--Footer-->
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
