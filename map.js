var width = 960,
    height = 500;
 
var path = d3.geo.path()
  .projection(null);
 
var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);
 
d3.json("data/ch.json", function(error, ch) {
  svg.append("path")
    .datum(topojson.feature(ch, ch.objects.country))
    .attr("class", "country")
    .attr("d", path);
 
  svg.append("path")
    .datum(topojson.mesh(ch, ch.objects.municipalities, function(a, b) { return a !== b; }))
    .attr("class", "municipality-boundaries")
    .attr("d", path);
 
  svg.append("path")
    .datum(topojson.mesh(ch, ch.objects.cantons, function(a, b) { return a !== b; }))
    .attr("class", "canton-boundaries")
    .attr("d", path);
});