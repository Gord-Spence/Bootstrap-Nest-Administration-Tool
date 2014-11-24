$(function () { 
    Highcharts.setOptions({
        global: {
            timezoneOffset: <?= $date_offset; ?> * 60
        }
    });
    $('#chart_nest_stats').highcharts('StockChart', {
        chart_nest_stats: {
            type: 'line',
            zoomType: 'xy',
            renderTo: chart_nest_stats
        },
        title: {
            text: 'Nest Temperature Statistics'
        },
        credits: {
        	enabled: false
        },
        xAxis: {
            type: 'datetime'
        },
	    rangeSelector: {
	    	selected: 1,
	    	buttons: [{
		    type: 'hour',
    		count: 1,
    		text: '1h'
		}, {
    		type: 'hour',
    		count: 3,
		    text: '3h'
		}, {
		    type: 'hour',
    		count: 6,
    		text: '6h'
    	}, {
    		type: 'hour',
    		count: 12,
    		text: '12h'
    	}, {
    		type: 'day',
    		count: 1,
    		text: '1d'
		}, {
			type: 'month',
			count: 1,
			text: '1m'
		}, {
    		type: 'ytd',
    		text: 'YTD'
		}, {
    		type: 'year',
    		count: 1,
    		text: '1y'
		}, {
    		type: 'all',
    		text: 'All'
		}],
	    },
        yAxis:[{
            title: {
                text: 'Temperature °<?= $scale; ?>' 
        }}, {
       	    title: {
                text: 'Relative Humidity %'
            },
	    	opposite: false
	    }],	    
        plotOptions: {
            line: {
                marker: {
                    enabled: false
                }
            },
            series: {
                connectNulls: false
            }
        },
        series: [{
            name: 'Inside Temperature',
	    	type: 'spline',
	    	color: 'orange',
            data: [<?php echo join($data_temp, ','); ?>]
        }, {
            name: 'Outside Temperature (<span style="color:blue">below freezing</span>)',
	    	type: 'spline',
	    	color: 'red',
            threshold: <?= $freezing_point; ?>,
	    	negativeColor: 'blue',
            data: [<?php echo join($data_outside_temp, ','); ?>]
        }, {
            name: 'Thermostat Setpoint',
	    	type: 'line',
            step: 'left',
	    	color: '#50B432',
            data: [<?php echo join($data_setpoint, ','); ?>]
        }, {
            name: 'Inside Humidity',
	    	type: 'spline',
	    	yAxis: 1,
            data: [<?php echo join($data_humidity, ','); ?>]
        }, {
        	name: 'Outside Humidity',
	    	type: 'spline',
	    	color: '#6AF9C4',
	    	yAxis: 1,
        	data: [<?php echo join($data_outside_humidity, ','); ?>]
        }, {
            name: 'Cooling',
            step: 'left',
            lineWidth: 0,
	    	type: 'area',
			threshold: <?= $base_room_temp; ?>,
	    	fillOpacity: 0.5,
	    	color: '#058DC7',
            data: [<?php echo join($data_cooling, ','); ?>]
        }, {
            name: 'Heating',
            step: 'left',
	    	lineWidth: 0,
	    	type: 'area',
	    	threshold: <?= $base_room_temp; ?>,
	    	fillOpacity: 0.5,
	    	color: '#FF9655',
            data: [<?php echo join($data_heating, ','); ?>]
        }],
        legend: {
			enabled: true,
			borderWidth: 1,
			backgroundColor: '#FFFFFF',
			shadow: true
		}
    });
});
