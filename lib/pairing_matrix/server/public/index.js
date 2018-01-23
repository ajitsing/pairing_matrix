$(document).ready(function () {
    var playground = new PlayGround(".area");
    var pairingData = [];
    var renderMatrix = function () {
        var days = $('#days').val();
        hideMatrix();
        showLoader();
        $.get('/data/' + days + "?cache_enabled=" + isCachingEnabled()).done(function (data) {
            pairingData = JSON.parse(data);
            playground.load(pairingData);
            hideLoader();
            showMatrix();
        }).fail(function () {
            alert('Error fetching data from server!');
            hideLoader();
            showMatrix();
        });
    };

    var hideMatrix = function () {
        $(".authors_container").hide();
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
        $('.authors').append("<input type='checkbox' class='author' checked='true' name='" + name + "'><label for='" + name + "'>" + name + "</label></br>");
      });

      $(".authors_container").show();
    };

    var hideLoader = function () {
        $('.loaderContainer').hide();
    };

    var showLoader = function () {
        $('.loaderContainer').show();
    };

    var enableCaching = function () {
        $('.cache-toggle').bootstrapToggle('on');
    };

    var isCachingEnabled = function () {
        return $('.cache-toggle').prop('checked');
    };

    var updateDays = function(days) {
      var $days = $('#days');
      $days.val(days);
    };

    $('#visualize').on('click', function () {
        renderMatrix()
    });

    $('#a_week').on('click', function () {
        updateDays('7');
        renderMatrix()
    });

    $('#two_weeks').on('click', function () {
        updateDays('14');
        renderMatrix()
    });

    $('#a_month').on('click', function () {
        updateDays('30');
        renderMatrix()
    });

    $('#two_months').on('click', function () {
        updateDays('60');
        renderMatrix()
    });

    $('#reset').click(function () {
      _.each($('.author'), function (e) {
        e.checked = false;
      });
    });

    $('#render').click(function (e) {
      var checked = _.filter($('.author'), function (e) {
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

    enableCaching();
    renderMatrix();
});
