$(document).ready(function () {
    var playground = new PlayGround(".area");
    var pairingData = [];
    var renderMatrix = function (days) {
        $('#no_of_days').text(days);
        hideMatrix();
        showLoader();
        $.get('/data/' + days).done(function (data) {
            pairingData = JSON.parse(data);
            playground.load(pairingData);
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
        var names = [];
        names = pairingData.map(function(p){ return p[0] });
        names = names.concat(pairingData.map(function(p){ return p[1] }));
        names = _.uniq(names).filter(function(n) {return n != ""});

      $('.authors').empty();
      var sortedNames = names.sort(function (a, b) {
        if (a > b) return 1;
        if (b > a) return -1;
        return 0;
      });
      _.each(sortedNames, function (name) {
        $('.authors').append("<input type='checkbox' checked='true' name='" + name + "'><label for='" + name + "'>" + name + "</label></br>");
      });

      $(".authors_container").show();
    };

    var hideLoader = function () {
        $('.loaderContainer').hide();
    };

    var showLoader = function () {
        $('.loaderContainer').show();
    };

    $('#visualize').on('click', function () {
        $(".authors_container").hide();
        renderMatrix($('#days').val())
    });

    renderMatrix($('#days').val());

    $('#reset').click(function () {
      _.each($('input[type="checkbox"]'), function (e) {
        e.checked = false;
      });
    });

    $('#render').click(function (e) {
      var checked = _.filter($('input[type="checkbox"]'), function (e) {
        return e.checked
      });
      var names = _.map(checked, function (checkbox) {
        return checkbox.name
      });

      var filteredPairingData = _.filter(pairingData, function (data) {
        return _.include(names, data[0]) || _.include(names, data[1])
      });

      playground.load(filteredPairingData);
    });
});
