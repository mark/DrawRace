class DRCurve {
    
    static var EDGE = 0;
    static var CENTER = 1;
    
    static var STEPS = 5;
    
    static var nextId = 0;
    var id:Number;

    var controlPoints:Array;
    var clip:MovieClip;
    var isLoop:Boolean;
    
    var style:Number;

    var hidden:Boolean;
    
    function DRCurve() {
        this.id = nextId++;

        controlPoints = new Array();
        isLoop = false;
    }
    
    function display(parent:MovieClip, style:Number) {
        clip = parent.createEmptyMovieClip("Curve_" + id, id);
        this.style = style;
        draw();
    }

    function loop() {
        isLoop = true;
        draw();
    }
    
    function addPoint(point:DRControlPoint) {
        controlPoints.push( point );
        
        if (!isLoop && controlPoints.length >= 2) draw();
        if ( isLoop && controlPoints.length >= 3) draw();
    }
    
    function draw() {
        clip.clear();
        
        if (style == EDGE)
            clip.lineStyle(2.0, 0x000000, 100);
        else
            clip.lineStyle(1.0, 0x666666, 100);
        
        var startOfCurve = controlPoints[0]
        clip.moveTo( startOfCurve.x, startOfCurve.y );

        var segments = isLoop ? controlPoints.length : (controlPoints.length - 1);
        
        for (var i = 0; i < segments; i++) {
            var startOfSegment = controlPoints[i];
            var endOfSegment = (i == controlPoints.length - 1) ? controlPoints[0] : controlPoints[i+1];
            
            renderSegment( leftControlPoint(i), startOfSegment, endOfSegment, rightControlPoint(i) );
        }
    }
    
    function leftControlPoint(segment:Number) {
        if (segment == 0) {
            return isLoop ? controlPoints[ controlPoints.length - 1 ] : controlPoints[0];
        } else {
            return controlPoints[ segment - 1 ];
        }
    }

    function rightControlPoint(segment:Number) {
        if (segment == controlPoints.length - 2) {
            return isLoop ? controlPoints[0] : controlPoints[ controlPoints.length - 1 ];
        } else if (segment == controlPoints.length - 1) {
            // isLoop only
            return controlPoints[1];
        } else {
            return controlPoints[ segment + 2 ];
        }
    }
    
    function replaceControlPoint(point:DRControlPoint, withPoint:DRControlPoint) {
        var newControlPoints = [];
        var justAddedWith = false;
        
        for (var i = 0; i < controlPoints.length; i++) {
            if (controlPoints[i] == point || controlPoints[i] == withPoint) {
                if (! justAddedWith) newControlPoints.push(withPoint);
                justAddedWith = true;
            } else {
                newControlPoints.push(controlPoints[i]);
                justAddedWith = false;
            }
        }
        
        controlPoints = newControlPoints;
        draw();
    }
    
    function doubleControlPoint(point:DRControlPoint) {
        for (var i = 0; i < controlPoints.length; i++) {
            if (point == controlPoints[i]) {
                controlPoints.splice(i, 0, point);
                return;
            }
        }
    }
    
    function renderSegment(p1, p2, p3, p4) {
        for (var i = 0; i <= STEPS; i++) {
            var t = i * 1.0 / STEPS;
            renderSegmentFragmentCatmullRom(t, p1, p2, p3, p4);
        }
    }
    
    function renderSegmentFragmentLinear(t, p1, p2, p3, p4) {
        var x = (1 - t) * p2.x + t * p3.x;
        var y = (1 - t) * p2.y + t * p3.y;
        
        clip.lineTo(x, y);
    }

    function catmullRom(t, p1, p2, p3, p4) {
        var p = ( -p1 + 3*p2 - 3*p3 + p4) * t * t * t +
                (2*p1 - 5*p2 + 4*p3 - p4) * t * t +
                ( -p1        +   p3     ) * t +
                (       2*p2            );
        return 0.5 * p;
    }
    
    function renderSegmentFragmentCatmullRom(t, p1, p2, p3, p4) {
        var x = catmullRom(t, p1.x, p2.x, p3.x, p4.x);
        var y = catmullRom(t, p1.y, p2.y, p3.y, p4.y);
        
        clip.lineTo(x, y);
    }
    
}