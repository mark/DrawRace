class DRDrawCoursePen extends DRPen {
    
    static var INTERVAL = 20.0;
    static var TRAIL_LENGTH = 8;

    var firstX:Number;
    var firstY:Number;
    
    var lastX:Number;
    var lastY:Number;
    
    var mousePath:Array;
    
    var course:DRCourse;
    
    function DRDrawCoursePen() {
        super("draw");
    }

    function onPenDown() {
        course = DRCourse.course;
    }
    
    function onMouseDown() {
        if (lastX == null) {
            firstX = _xmouse;
            firstY = _ymouse;
            
            mousePath = [ [_xmouse, _ymouse] ];
            addPoint(_xmouse, _ymouse);
        } else {
            finish();
        }
        
    }
    
    function onMouseMove() {
        if (lastX == null) return;
        
        var dx = lastX - _xmouse;
        var dy = lastY - _ymouse;
        var distSqr = dx * dx + dy * dy;
        
        if (distSqr >= INTERVAL * INTERVAL) {
            addPoint(_xmouse, _ymouse);
        }
        
        mousePath.push( [_xmouse, _ymouse] );
        while (mousePath.length > TRAIL_LENGTH) {
            mousePath.shift();
        }
    }
    
    function onKeyDown(){
        // SHIFT ==> constrain in one dimension
    }
    
    function addPoint(x:Number, y:Number) {
        course.addPoint(x, y, mousePath[0][0], mousePath[0][1]);
        
        lastX = _xmouse;
        lastY = _ymouse;
    }

    function finish() {
        addPoint(firstX, firstY);
        
        lastX = null;
        lastY = null;

        course.loop();
        
        switchPen("edit");
    }

}