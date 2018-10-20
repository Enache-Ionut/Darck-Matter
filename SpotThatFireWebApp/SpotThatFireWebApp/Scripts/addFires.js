$(document).ready(function () {
    addFire.init();
});

var locations = [];
var wps = [];
var addFire = {
    init: function () {
        addFire.showExistingFires();
    },

    showExistingFires: function () {
        for (var l = 0; l < locations.length; l++) {
            var point = { lat: locations[l].Latitude, lng: locations[l].Longitude };
            var map = new google.maps.Map(
                document.getElementById('map'), { zoom: 4, center: point, disableDefaultUI: true });
            var marker = new google.maps.Marker({ position: uluru, map: map });
           
        }
    },

    reportFire: function () {

    }


    

};