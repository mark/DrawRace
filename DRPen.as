class DRPen {
    
    static var pens:Object = new Object();
    static var currentPen:DRPen;
    
    function DRPen(name:String) {
        DRPen.pens[name] = this;
    }
    
    static function setPen(penName:String) {
        var newPen = DRPen.pens[penName];

        if (newPen) {
            currentPen = newPen;
            
            Mouse.addListener(newPen);
            Key.addListener(newPen);
            
            _root.onEnterFrame = function() { newPen.onEnterFrame(); }
            
            newPen.onPenDown();
        }
        
    }
    
    function switchPen(penName:String) {
        var newPen = DRPen.pens[penName];
        
        if (newPen) {
            currentPen = newPen;
            
            Mouse.removeListener(this);
            Mouse.addListener(newPen);
            Key.removeListener(this);
            Key.addListener(newPen);
            
            _root.onEnterFrame = function() { newPen.onEnterFrame(); }
            
            onPenUp();
            newPen.onPenDown();
            
            return newPen;
        }
    }
 
    // Event Handlers:
    
    function onEnterFrame() {}
    
    function onPenDown()    {}
    function onPenUp()      {}
                            
    function onMouseDown()  {}
    function onMouseMove()  {}
    function onMouseUp()    {}
                            
    function onKeyDown()    {}
    function onKeyUp()      {}

}