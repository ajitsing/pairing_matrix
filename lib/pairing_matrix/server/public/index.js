$(document).ready(function () {
    var playground = new PlayGround(".area");
    var renderMatrix = function (days) {
        $.get('/data/' + days, function (data, status) {
            if (status == 'success') {
                playground.load(JSON.parse(data));

            } else {
                console.log(data);
                alert('error occurred!')
            }
        })
    };

    $('#visualize').on('click', function () {
        renderMatrix($('#days').val())
    });
});
