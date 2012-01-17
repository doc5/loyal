Loyal = {
    libs : {
        getNiceVal : function(v1, v2){
            return typeof(v1) == "undefined" ? v2 : v1; 
        },
        getPresentVal : function(v){
            return getNiceVal(v, null);
        }
    }
};