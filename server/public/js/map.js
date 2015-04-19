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
    .attr("height", height);

var g = svg; //svg.append("g");

d3.json("data/ch-cantons-lakes.json", function(error, ch){


    var cantons = topojson.feature(ch, ch.objects.cantons);
    var lakes = topojson.feature(ch, ch.objects.lakes);

    svg.selectAll(".canton")
        .data(cantons.features)
        .enter()
        .append("path")
        .attr("class", "canton")
        .attr("d", path)
        .on("click", clicked);

    svg.append("path")
        .datum(lakes)
        .attr("class", "lake")
        .attr("d", path);

});

function clicked(d) {
  var x, y, k;
    console.log(d);
  if (d && centered !== d) {
    var centroid = path.centroid(d);
    x = centroid[0];
    y = centroid[1];
    k = 4;

    if (!centered) {
        //d3.select(this).on("click", null);
        console.log("First time");
        d3.json("data/ch-districts-lakes.json", function (error, ch) {
            var districts = topojson.feature(ch, ch.objects.districts);
            var lakes = topojson.feature(ch, ch.objects.lakes);

            svg.selectAll(".district")
                .data(districts.features)
                .enter()
                .append("path")
                .attr("class", "district")
                .attr("d", path)
                .on("click", clicked);

            svg.append("path")
                .datum(lakes)
                .attr("class", "lake")
                .attr("d", path);

        });


    } else if(centered.properties.type === "canton" && d.properties.type === "district") { // We are focusing a District
        console.log("Second time");

        d3.json("data/ch-municipalities-lakes.json", function (error, ch) {

            var municipalities = topojson.feature(ch, ch.objects.municipalities);
            var lakes = topojson.feature(ch, ch.objects.lakes);

           svg.selectAll(".municipality")
                .data(municipalities.features)
                .enter()
                .append("path")
                .attr("class", "municipality")
                .attr("d", path)
                .on("click", clicked);

           svg.append("path")
                .datum(lakes)
                .attr("class", "lake")
                .attr("d", path);


        });
    } else if(centered.properties.type === "district" && d.properties.type === "municipality") { // We are focusing a municipality
        console.log("test3");
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
    $('#personTable').html("<p id=\"ux_info\">Cliquez sur un canton pour afficher ses conseillers-ères.</p>");
  }



  g.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  svg.transition()
      .duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1.5 / k + "px");

}

$('body').on('click','.ask',function(data){
    var id = $(data.target).attr('data-user-id');
    $.ajax({
        url: 'http://localhost:3000/users/' + id,
        type: 'GET',
        crossDomain: true,
        success: function(data) {
            $('#personTable').html(data);
        }
    });
});
