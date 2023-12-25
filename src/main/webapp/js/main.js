function cart(productId) {
    $.ajax({
        method: 'GET',
        url: 'cart',
        data: {
            productId: productId
        },
        success: function (response) {
        }
    })
}