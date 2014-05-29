$(function() {
  $.simpleWeather({
    woeid: woeid,
    unit: temp,
    success: function(weather) {
			$('#weather').append('<div id="today">\
					<h1>Today</h1>\
					<img class="weatherIcon" src="'+ weather.image + '">\
					<div>' + weather.currently + '</div>\
					<div>' + weather.temp + '&deg;' + temp + '</div>\
					<div>High ' + weather.high + '&deg;' + temp + '</div>\
					<div>Low ' + weather.low + '&deg;' + temp + '</div>\
				</div>\
			<div id="tomorrow">\
					<h1>Tomorrow</h1>\
					<img class="weatherIcon" src="'+ weather.tomorrow.image + '">\
					<div>' + weather.forecast + '</div>\
					<div>High ' + weather.tomorrow.high + '&deg;' + temp + '</div>\
					<div>Low ' + weather.tomorrow.low + '&deg;' + temp + '</div>\
				</div>');
			  },
			    error: function(error) {
			      $("#weather").html('<p>'+error+'</p>');
					}
	});
});