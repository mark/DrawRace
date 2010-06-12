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
}