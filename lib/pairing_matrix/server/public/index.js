$(document).ready(function () {
    var playground = new PlayGround(".area");
    var renderMatrix = function (days) {
        $.get('/data/' + days).done(function (data) {
            playground.load(JSON.parse(data));
        }).fail(function () {
            alert('error occurred!')
        });
    };

    $('#visualize').on('click', function () {
        renderMatrix($('#days').val())
    });

    renderMatrix($('#days').val());
});
