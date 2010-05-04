class DRCourse {

    static var course:DRCourse;
    
    var forwardCurve: DRCurve;
    var backwardCurve:DRCurve;
    var drawCurve:    DRCurve;
    
    var clip:MovieClip;
    
    var ribs:Array;
    
    function DRCourse() {
        forwardCurve  = new DRCurve();
        backwardCurve = new DRCurve();
        drawCurve     = new DRCurve();
        
        ribs = new Array();

        display();
        
        DRCourse.course = this;
    }
    
    function display() {
        clip = _root.createEmptyMovieClip("Course", 0);
        
        clip.createEmptyMovieClip("ribs", 0);
        clip.createEmptyMovieClip("curves", 1);
        clip.createEmptyMovieClip("controlPoints", 2);
        clip.createEmptyMovieClip("vehicles", 3);
        
        forwardCurve.display( clip.curves, DRCurve.EDGE );
        backwardCurve.display( clip.curves, DRCurve.EDGE );
        drawCurve.display( clip.curves, DRCurve.CENTER );
    }
    
    function addPoint(x:Number, y:Number, trailX:Number, trailY:Number) {
        var lastRib = ribs[ ribs.length - 1 ];

        // var lastX = trailX;
        // var lastY = trailY;

        var lastX = lastRib.centerHandle.x;
        var lastY = lastRib.centerHandle.y;
        
        var angle = Math.atan2(lastY - y, lastX - x);
        if (angle < 0) angle += 2.0 * Math.PI;
        
        var newRib = new DRRib(this, x, y, angle);
        
        ribs.push(newRib);
        newRib.display(clip.ribs, clip.controlPoints);
    }
    
    function loop() {
        ribs.shift();
        forwardCurve.loop();
        backwardCurve.loop();
        drawCurve.controlPoints.shift();
        drawCurve.loop();
    }
    
    function draw(style:String) {
        forwardCurve.draw();
        backwardCurve.draw();
        drawCurve.draw();

        for (var i = 0; i < ribs.length; i++) {
            ribs[i].draw();
        }
    }
    
    function setVisibility(visibility:String) {
        if (visibility == "all") {
            clip.ribs._alpha          = 100;
            clip.curves._alpha        = 100;
            clip.controlPoints._alpha = 100;
            drawCurve.clip._alpha     = 100;
        } else if (visibility == "course") {
            clip.ribs._alpha          = 0
            clip.curves._alpha        = 100;
            clip.controlPoints._alpha = 0;
            drawCurve.clip._alpha     = 0;
        }
    }
    
    function ribMoved(rib:DRRib) {
        draw();
    }

}