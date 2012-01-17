BMAdapter = {
    CONTAINER : "container",
    instance : null,
    
    defined : {
        
    },    
    methods : {
        loadInstance : function(cnt){
            return (BMAdapter.instance = new BMap.Map(cnt)); // 创建地图实例            
        },
        newPoint : function(x, y){
            return new BMap.Point(x, y);
        },
        setCenterAndZoom : function(map, pnt, zo){
            map.centerAndZoom(pnt, zo);
        },
        init : function(){     
            var methods = BMAdapter.methods;
            var map = methods.loadInstance(BMAdapter.CONTAINER);
            var point = methods.newPoint(116.404, 39.915); // 创建点坐标
            methods.setCenterAndZoom(map, point, 16);
            map.addControl(new BMap.NavigationControl());  
            map.addControl(new BMap.ScaleControl());  
            map.addControl(new BMap.OverviewMapControl());  
            map.addControl(new BMap.MapTypeControl());  
            map.setCurrentCity("北京"); // 仅当设置城市信息时，MapTypeControl的切换功能才能可用 
        } 
    }    
}

window.onload = function(){
    BMAdapter.methods.init();
}