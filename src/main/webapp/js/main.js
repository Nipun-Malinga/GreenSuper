function getCategoryID(categoryId) {
    $.ajax({
        type: 'GET',
        url: 'productView',
        data: {
            categoryId: categoryId,
        }, success: function (response) {
            console.log(response)
            window.location.href = response;
        }, error: function (status, error) {
            console.log("Error", status, error);
        }
    })
}
