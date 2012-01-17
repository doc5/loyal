function openAppWindow(clicker, opts){
    if(typeof(clicker) == 'undefined'){
        return true;
    }
    var options = Loyal.libs.getNiceVal(opts, {});
    var pageURL = Loyal.libs.getNiceVal(options.href, clicker.href);
    if(Loyal.libs.getNiceVal(pageURL, null) == null){
        return false;
    }
    var name = Loyal.libs.getNiceVal(options.name, pageURL); 
    var sHeight = window.screen.height;
    var sWidth = window.screen.width;   
    var height = Loyal.libs.getNiceVal(options.height, sHeight / 2);
    var width = Loyal.libs.getNiceVal(options.width, sWidth / 2);
    var top = Loyal.libs.getNiceVal(options.top, (sHeight - height) / 2);
    var left = Loyal.libs.getNiceVal(options.left, (sWidth - width) / 2);
    
    var params = ('left=' + left + ',top=' + top + ",height=" + height + ",width=" + width) 
                    + ",toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no";
    window.open(pageURL, name, params, true).focus();    
    return false;
}
