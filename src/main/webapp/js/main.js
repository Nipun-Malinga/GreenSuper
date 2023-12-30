function AddToCart(productId) {
    $.ajax({
        method: 'GET',
        url: 'cart',
        data: {
            productId: productId
        },
        success: function (response) {
            if(response === "productAdded") {
                document.getElementById("product" + productId).innerHTML = "<span> Product Added </span>";

            } else if (response === "productExists") {
                document.getElementById("product" + productId).innerHTML = "<span> Product Exist </span>";
            }
        }
    })
}

function login(event) {
    event.preventDefault();

    $.ajax({
        method: 'post',
        url: 'login',
        data: {

        }
    })
}
