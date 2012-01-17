//http://code.google.com/intl/zh-CN/apis/maps/documentation/javascript/reference.html
//api-refer
GoogleMapAdapter = {
    CONTAINER : "container",
    map : null
}

window.onload = function(){
    var adapter = GoogleMapAdapter;        
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var myOptions = {
        zoom: 8,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.TERRAIN,
        mapTypeControl: true, //地图类型
        navigationControl: true, //导航
        scaleControl: true //比例尺

    };
    adapter.map = new google.maps.Map(document.getElementById(adapter.CONTAINER), myOptions);    
}