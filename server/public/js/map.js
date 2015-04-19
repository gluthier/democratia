var width = 960,
    height = 500,
    centered;

var cantonLevel = false;

var path = d3.geo.path()
    .projection(null);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

svg.append("rect")
    .attr("class", "background")
    .attr("width", width)
    .attr("height", height)
    .on("click", clicked);

var g = svg.append("g");

d3.json("data/ch-cantons-lakes.json", function(error, ch) {
  g.append("g")
    .attr("id", "cantons")
    .selectAll("path")
    .data(topojson.feature(ch, ch.objects.cantons).features)
    .enter().append("path")
    .attr("d", path)
    .attr("class","canton-click")
    .on("click", clicked);


  g.append("path")
      .datum(topojson.mesh(ch, ch.objects.cantons, function(a, b) { return a !== b; }))
      .attr("id", "cantons-borders")
      .attr("d", path);


  g.append("g")
    .attr("class", "lakes")
    .selectAll("path")
    .data(topojson.feature(ch, ch.objects.lakes).features)
    .enter().append("path")
    .attr("d", path);
});

function clicked(d) {
  var x, y, k;

  if (d && centered !== d) {
    var centroid = path.centroid(d);
    x = centroid[0];
    y = centroid[1];
    k = 4;

    if (!centered) { // We zoom on a canton
        d3.json("data/ch-districts-lakes.json", function (error, ch) {
            g.append("path")
                .datum(topojson.mesh(ch, ch.objects.districts, function (a, b) {
                    return a !== b;
                }))
                .attr("class", "municipality-boundaries")
                .attr("id", "districts")
                .attr("d", path)
                .on("click", clicked);

        });

    } else if(centered.properties.type === "canton" && d.properties.type === "district") { // We are focusing a District
        d3.json("data/" + centered.properties.abbr.toLowerCase() + "-municipalities-lakes.json", function (error, ch) {
            g.append("path")
                .datum(topojson.mesh(ch, ch.objects.municipalities, function (a, b) {
                    return a !== b;
                }))
                .attr("class", "municipality-boundaries")
                .attr("id", "districts")
                .attr("d", path)
                .on("click", clicked);

        });
    } else if(centered.properties.type === "district" && d.properties.type === "municipality") { // We are focusing a municipality

    }

    $.ajax({
      url: 'http://ex0ns.me:3000/cantons/' + d.properties.name + '/users',
      type: 'GET',
      crossDomain: true,
      success: function(data) {
          $('#personTable').html(data);
      }
    });

    centered = d;
    cantonLevel = true;

  } else {
    x = width / 2;
    y = height / 2;
    k = 1;
    centered = null;
    cantonLevel = false;
    g.select("#districts").remove();
    $('#personTable').html("<p id=\"ux_info\">Cliquez sur un canton pour afficher ces conseillers-ères.</p>");
  }



  g.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  g.transition()
      .duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1.5 / k + "px");

}
