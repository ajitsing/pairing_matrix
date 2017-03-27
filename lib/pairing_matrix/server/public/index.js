$(document).ready(function () {
    var playground = new PlayGround(".area");
    var renderMatrix = function (days) {
        hideMatrix();
        showLoader();
        $.get('/data/' + days).done(function (data) {
            playground.load(JSON.parse(data));
            hideLoader();
            showMatrix();
        }).fail(function () {
            alert('error occurred!');
            hideLoader();
            showMatrix();
        });
    };

    var hideMatrix = function () {
        $('.viz_container').hide();
    };

    var showMatrix = function () {
        $('.viz_container').show();
    };

    var hideLoader = function () {
        $('.loaderContainer').hide();
    };

    var showLoader = function () {
        $('.loaderContainer').show();
    };

    $('#visualize').on('click', function () {
        renderMatrix($('#days').val())
    });

    renderMatrix($('#days').val());
});
