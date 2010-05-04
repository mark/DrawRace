class DRRib {

    static var RIB_WIDTH = 100;

    static var nextId = 0;
    var id:Number;
    
    var course:DRCourse;
    
    var forwardWidth:Number;
    var ratio:Number;
    var angle:Number;
    
    var centerHandle:  DRControlPoint;
    var forwardHandle: DRControlPoint;
    var backwardHandle:DRControlPoint;
    
    var clip:MovieClip;
    
    function DRRib(course:DRCourse, x:Number, y:Number, angle:Number) {
        this.id = nextId++;
        
        this.course = course;
        this.angle  = angle;
        this.forwardWidth  = RIB_WIDTH / 2.0;
        this.ratio = 1.0;
         
        centerHandle = new DRControlPoint(this, course.drawCurve, x, y, DRControlPoint.CIRCLE);
        
        if (angle || angle == 0.0) {
            forwardHandle  = new DRControlPoint(this, course.forwardCurve,  x, y, DRControlPoint.BOX);
            backwardHandle = new DRControlPoint(this, course.backwardCurve, x, y, DRControlPoint.BOX);
            
            updateHandles();
            
            course.forwardCurve.draw();
            course.backwardCurve.draw();
        }
    }
    
    function x():Number { return centerHandle.x; }
    function y():Number { return centerHandle.y; }
    
    function updateHandles() {
        var forwardAngle = angle + Math.PI / 2.0;
        var backwardAngle = angle - Math.PI / 2.0;

        var forwardX  = x() + forwardWidth * Math.cos(forwardAngle);
        var forwardY  = y() + forwardWidth * Math.sin(forwardAngle);
        
        forwardHandle.shiftTo(forwardX, forwardY);
        
        var backwardX = x() + ratio * forwardWidth * Math.cos(backwardAngle);
        var backwardY = y() + ratio * forwardWidth * Math.sin(backwardAngle);
        
        backwardHandle.shiftTo(backwardX, backwardY);
    }
    
    function display(ribs:MovieClip, controlPoints:MovieClip) {
        clip = ribs.createEmptyMovieClip("Rib_" + id, id);

        centerHandle.display(controlPoints);
        forwardHandle.display(controlPoints);
        backwardHandle.display(controlPoints);
        
        draw();
    }
    
    function draw() {
        clip.clear();
        clip.lineStyle(1.0, 0x000000, 50);

        clip.moveTo(forwardHandle.x,  forwardHandle.y );
        clip.lineTo(backwardHandle.x, backwardHandle.y);
        
        forwardHandle.draw();
        backwardHandle.draw();
        centerHandle.draw();
    }

    function controlPointMoved(point:DRControlPoint, unevenWidth:Boolean) {
        if (point == forwardHandle || point == backwardHandle) {
            var dx = x() - point.x;
            var dy = y() - point.y;
            var length = Math.sqrt(dx * dx + dy * dy);
            
            if (unevenWidth) {
                if (point == forwardHandle) {
                    forwardWidth = length;
                }
                
                if (point == backwardHandle) {
                    ratio = length / forwardWidth;
                }
            } else {
                if (point == forwardHandle) {
                    forwardWidth = length;
                }
                
                if (point == backwardHandle) {
                    forwardWidth = length / ratio;
                }
            }
            
            var angleOffset = (point == forwardHandle) ? Math.PI / 2.0 : -Math.PI / 2.0;
            angle = Math.atan2(dy, dx) + angleOffset;
        }
        
        updateHandles();
        course.ribMoved(this);
    }

    function replaceControlPoint(point:DRControlPoint, otherPoint:DRControlPoint) {
        if (point == forwardHandle) {
            forwardHandle = otherPoint;
        } else if (point == backwardHandle) {
            backwardHandle = otherPoint;
        } else if (point == centerHandle) {
            centerHandle = otherPoint;
        }
        
        controlPointMoved(otherPoint, false);
    }
}