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

d3.json("data/ch.json", function(error, ch) {
  g.append("g")
    .attr("id", "cantons")
    .selectAll("path")
    .data(topojson.feature(ch, ch.objects.cantons).features)
    .enter().append("path")
    .attr("d", path)
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

    if (!centered)
    {
      d3.json("data/ch.json", function(error, ch) {
        g.append("path")
          .datum(topojson.mesh(ch, ch.objects.districts, function (a, b) {
            return a !== b;
          }))
          .attr("class", "municipality-boundaries")
          .attr("id", "districts")
          .attr("d", path);

      });
    }
    
    centered = d;
    cantonLevel = true;

  } else {
    x = width / 2;
    y = height / 2;
    k = 1;
    centered = null;
    cantonLevel = false;
    g.select("#districts").remove();
    
  }



  g.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  g.transition()
      .duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1.5 / k + "px");

}
