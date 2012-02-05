Loyal = {
    libs : {
        getNiceVal : function(v1, v2){
            return typeof(v1) == "undefined" ? v2 : v1; 
        },
        getPresentVal : function(v){
            return getNiceVal(v, null);
        },        
        openAppWindow : function (clicker, opts){
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
        },
        isIE : function(){
            return typeof(window.ActiveXObject) != 'undefined';
        },
        getNodesByAttr : function(attribute, value, nodeRefer){
            var nodesResult = [], //结果数组
            nodeRefer = (nodeRefer) ? nodeRefer : document, //无参照节点则设参照节点为document
            nodesCollection = nodeRefer.getElementsByTagName("*"); //获取参照节点下所有节点

            //通过attribute筛选进数组
            for(var i=nodesCollection.length-1; i>=0; i--){
                var node = nodesCollection[i];
                if(attribute === "className" || attribute === "class"){ //当属性为class样式时，因IE支持不一样的字符，不用getAttribute方法，直接用点符号取className属性值
                    if(node.className === value){
                        nodesResult.push(node);
                    }
                }else{ //为其他属性时,正常getAttribute取值
                    if(node.getAttribute(attribute) === value){
                        nodesResult.push(node);
                    }
                }
            }

            //返回节点数组
            return nodesResult;
        }
    }
};

window.onload = function(){
    var nodes = Loyal.libs.getNodesByAttr("type", "hidden");
    alert(nodes.length);
    for(var i in nodes){
        nodes[i].style.border = "none";
        nodes[i].style.display = "none";
        nodes[i].style.padding = 0;
    }    
}

/**参数解释
 * attribute:属性名,
 * value:属性值,
 * nodeRefer:参照节点 [可选]
 */