var playground;


function PlayGround(selector) {
    this.el = null;
    this.centerX = 400;
    this.centerY = 350;
    this.radius = 300;
    this.selector = selector;

    this.pairingData = [];
    this.playersData = [];

    this.connectionScale = d3.scaleLinear()
        .domain([0, 200])
        .range([0, 50]);

    this.init = function () {
        playground = this;
        this.el = d3.select(this.selector);
    };

    this.load = function (pairingData) {
        this.pairingData = pairingData;
        this.validPairsData = this.getValidPairs(pairingData);
        this.playersData = this.getPlayerNames(pairingData);
        this.clear();
        this.setGround();
        this.setPairing();
        this.setPlayers();
    };

    this.clear = function () {
        $(this.selector).children().remove();
    }

    this.setPairing = function () {
        this.el.selectAll(".connect")
            .data(playground.validPairsData)
            .enter().append("path")
            .attr("class", "connect")
            .attr("d", function (d) {
                var fromIndex = _.indexOf(playground.playersData, d[0]),
                    fromCoordinates = playground.getPlayerCoordinates(fromIndex);
                var toIndex = (d[1] == "") ? fromIndex : _.indexOf(playground.playersData, d[1]),
                    toCoordinates = playground.getPlayerCoordinates(toIndex);
                return "M " + fromCoordinates.x + " " + fromCoordinates.y + " Q 400 350 " +
                    toCoordinates.x + " " + toCoordinates.y;
            })
            .attr("id", function(d) {return d.join('_')})
            .attr("stroke-width", function (d) {
                return playground.connectionScale(d[2])
            })
            .attr("data-from", function (d) {
                return d[0]
            })
            .attr("data-to", function (d) {
                return d[1]
            });
    };

    this.setGround = function () {
        this.el.append("circle")
            .attr("cx", this.centerX)
            .attr("cy", this.centerY)
            .attr("r", this.radius)
            .style("fill-opacity", 0.05);
    };

    this.setPlayers = function () {
        var colors = d3.scaleOrdinal(d3.schemeCategory20);
        var players = this.el.selectAll(".players")
            .data(playground.playersData)
            .enter()
            .append("g");
        players.append("circle")
            .attr("cx", function (d, i) {
                return playground.getPlayerCoordinates(i).x
            })
            .attr("cy", function (d, i) {
                return playground.getPlayerCoordinates(i).y
            })
            .attr("fill", colors)
            .attr("stroke-width", function (d) {
                return playground.connectionScale(playground.getSoloContribution(d))
            })
            .attr("class", "player")
            .attr("id", function (d) {
                return d
            })
            .on('mouseover', this.mouseOver)
            .on('mouseout', this.mouseOut)
        players.append("text")
            .attr("class", "player_names")
            .text(function (d) {
                return d
            })
            .attr("x", function (d, i) {
                return playground.getPlayerCoordinates(i).x + 2
            })
            .attr("y", function (d, i) {
                return playground.getPlayerCoordinates(i).y + 3
            })
            .attr("fill", "#000000");
    };

    this.getAllPairsContaining = function(name) {
        return _.filter(this.validPairsData, function(pair) {
            return pair.indexOf(name) >= 0
        });
    };

    this.toggleClass = function toggleClass(newClass, pair) {
        for(ii = 0; ii < 2; ii++) {
            d3.selectAll($("#" + pair[ii]))
                .attr("class", newClass)    
        }
    }

    this.mouseOut = function(id) {
        var connectedPairs = playground.getAllPairsContaining(id);
        connectedPairs.forEach(function(pair) {
            playground.toggleClass("player", pair);
            var pairId = pair.join('_');
            d3.selectAll($("#" + pairId))
            .attr("class", "connect")
            .style("stroke-width", function(d) {return playground.connectionScale(d[2])})
        })
        d3.selectAll($("#" + id))
        .attr("class", "player")
    }

    this.mouseOver = function (id) {
        var connectedPairs = playground.getAllPairsContaining(id);
        connectedPairs.forEach(function(pair) {
            playground.toggleClass("playerLarge", pair)
            var pairId = pair.join('_');
            d3.selectAll($("#" + pairId))
            .attr("class", "connectLarge")
            .style("stroke-width", function(d) {return playground.connectionScale(d[2])})
        })
        d3.selectAll($("#" + id))
        .attr("class", "playerLarge")
    };

    this.updateConnectorsPath = function (playerId, newPoint) {
        playground.el
            .selectAll(".connect[data-from='" + playerId + "']")
            .attr("d", function (d) {
                    return playground.replaceFromInPath($(this).attr("d"), newPoint);
                }
            );
        playground.el
            .selectAll(".connect[data-to='" + playerId + "']")
            .attr("d", function (d) {
                    return playground.replaceToInPath($(this).attr("d"), newPoint);
                }
            );
    }

    this.getCollidingPlayer = function (player) {
        var svg = $("svg")[0];
        var rectangle = svg.createSVGRect();
        rectangle.x = player.attr("cx");
        rectangle.y = player.attr("cy");
        rectangle.width = player.attr("r");
        rectangle.height = player.attr("r");
        var allElements = svg.getIntersectionList(rectangle, null);
        return _.filter(allElements, function (elem) {
            return $(elem).attr("class") == "player" && $(elem).attr("id") != player.attr("id")
        });
    }

    this.replaceFromInPath = function (path, from) {
        var parts = path.split(" ");
        parts[1] = from[0];
        parts[2] = from[1];
        return parts.join(" ");
    }

    this.replaceToInPath = function (path, to) {
        var parts = path.split(" ");
        parts[6] = to[0];
        parts[7] = to[1];
        return parts.join(" ");

    }

    this.closestPointOnCircumference = function () {
        var vx = d3.event.x - this.centerX,
            vy = d3.event.y - this.centerY,
            magV = Math.sqrt(vx * vx + vy * vy);
        return [(this.centerX + vx / magV * this.radius), (this.centerY + vy / magV * this.radius)];
    };

    this.getPlayerCoordinates = function (index) {
        var distanceInDegrees = 2 * Math.PI / playground.playersData.length;
        return {
            x: (playground.radius * Math.sin(distanceInDegrees * index) + playground.centerX),
            y: (playground.radius * Math.cos(distanceInDegrees * index) + playground.centerY)
        }
    };

    this.getValidPairs = function (pairingData) {
        return _.filter(pairingData, function (data) {
            return (!_.isEmpty(data[0]) && !_.isEmpty(data[1]));
        })
    };

    this.getPlayerNames = function (pairingData) {
        var playerNames = [];
        _.each(pairingData, function (data) {
            playerNames.push(data[0]);
            playerNames.push(data[1]);
        });
        playerNames = _.compact(playerNames);
        return _.sortBy(_.uniq(playerNames), function (d) {
            return d
        });
    };

    this.getSoloContribution = function (name) {
        var contrib = _.find(this.pairingData, function (data) {
            return ((data[0] == name && _.isEmpty(data[1])) || (data[1] == name && _.isEmpty(data[0])));
        });
        return contrib ? contrib[2] : 1;
    };

    this.init();
}
