class DRCourseDisplay {
    
    var course:DRCourse;
    var clip:MovieClip;
    
    function DRCourseDisplay(course:DRCourse) {
        this.course = course;
        this.clip = course.clip.display;
    }
    
    function display() {
        clip.clear();

        fillCurve(course.forwardCurve,  0x999999);
        fillCurve(course.backwardCurve, 0xffffff);
        
        for (var i = 0; i < 100; i++) {
            drawCourseLine();
        }
    }
    
    function fillCurve(curve:DRCurve, color:Number) {
        clip.beginFill(color);
        
        var startingPoint = curve.parameterize(0.0);
        
        clip.moveTo(startingPoint.x, startingPoint.y);
        
        for (var i = 0; i < curve.curveLength(); i++) {
            for (var j = 0.0; j < 1.0; j += 0.2) {
                var point = curve.parameterize(i+j);
                
                clip.lineTo(point.x, point.y);
            }
        }

        clip.endFill();
    }
    
    function drawCourseLine() {
        var across = Math.random();
        
        var outside = course.forwardCurve;
        var inside  = course.backwardCurve;
        
        var start  = Math.random() * (outside.curveLength() + 1.0);
        var length = Math.random() * 5.0 + 3.0;
        
        var grey = Math.floor(255 * Math.random());
        var color = grey | grey << 8 | grey << 16;
        clip.lineStyle(2.0, color, 70);
        
        for (var i = 0.0; i <= 1.0; i += 0.1) {
            var distance = start + length * i;
            if (distance > (outside.curveLength())) distance -= (outside.curveLength());
            
            var outsidePoint = outside.parameterize(distance);
            var insidePoint  = inside.parameterize(distance);
            
            var blend = blendPoints(outsidePoint, insidePoint, across);
            
            if (i == 0.0) {
                clip.moveTo(blend.x, blend.y);
            } else {
                clip.lineTo(blend.x, blend.y);
            }
        }
    }
    
    function blendPoints(point1:Object, point2:Object, fraction:Number):Object {
        var x = point1.x * fraction + point2.x * (1 - fraction);
        var y = point1.y * fraction + point2.y * (1 - fraction);
        
        return { x: x, y: y };
    }
}