$(document).ready(function () {
    var playground = new PlayGround(".area");
    $.get('/data/2017-03-10', function (data, status) {
        if (status == 'success') {
            playground.load(JSON.parse(data));

        } else {
            console.log(data);
            alert('error occurred!')
        }
    })
});
