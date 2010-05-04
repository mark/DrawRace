class DRControlPoint {
    
    static var BOX    = 0;
    static var CIRCLE = 1

    var ribs:Array;
    var curve:DRCurve;
    
    static var nextId = 0;
    var id:Number;

    static var allPoints = new Array();
    
    var x:Number;
    var y:Number;
    
    var style:Number;
    
    var clip:MovieClip;
    
    function DRControlPoint(rib:DRRib, curve:DRCurve, x:Number, y:Number, style:Number) {
        this.id = nextId++;

        this.ribs = [rib];
        this.curve = curve;
        this.x = x;
        this.y = y;
        
        this.style = (style == null) ? BOX : style;
        
        curve.addPoint(this);
        allPoints.push(this);
    }
    
    function display(parent:MovieClip) {
        clip = parent.createEmptyMovieClip("ControlPoint_" + id, id);
        draw();
    }
    
    function draw() {
        clip.clear();
        clip._x = x;
        clip._y = y;
        
        if (style == BOX) {
            clip.lineStyle(0.5, 0x000000, 100);
            clip.drawSquare(0.0, 0.0, 6.0);
        } else if (style == CIRCLE) {
            clip.lineStyle(0.5, 0x990000, 100);
            clip.drawCircle(0.0, 0.0, 3.0);
        }
    }
    
    function isClickOn(x:Number, y:Number) {
        return Math.abs(x - this.x) <= 5.0 && Math.abs(y - this.y) <= 5.0;
    }
    
    function shiftTo(x:Number, y:Number) {
        this.x = x;
        this.y = y;
    }
    
    function moveTo(x:Number, y:Number, unevenWidth:Boolean) {
        shiftTo(x, y);
        
        for (var i = 0; i < ribs.length; i++) {
            ribs[i].controlPointMoved(this, unevenWidth);
        }
    }
    
    function addRibs(newRibs:Array) {
        ribs = ribs.concat(newRibs);
    }
    
    function replaceWith(other:DRControlPoint) {
        // Remove the clip for this control point
        clip.removeMovieClip();

        // And take it out of the curve
        curve.replaceControlPoint(this, other);

        // And replace it in all of the ribs
        for (var i = 0; i < ribs.length; i++) {
            other.addRibs(ribs);
            ribs[i].replaceControlPoint(this, other);
        }
        
        // And remove it from the list of all control points
        for (var i = 0; i < allPoints.length; i++) {
            if (allPoints[i] == this) {
                allPoints.splice(i, 1);
                break;
            }
        }
    }

    function cornerize() {
        trace("!")
        curve.doubleControlPoint(this);
    }
}