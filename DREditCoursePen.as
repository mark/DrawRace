class DREditCoursePen extends DRPen {

    var course:DRCourse;

    var currentControlPoint;

    var CHAR_C = 67;
    
    function DREditCoursePen() {
        super("edit");
    }
    
    function onPenDown() {
        course = DRCourse.course;
    }
    
    function onMouseDown() {
        for (var i = 0; i < DRControlPoint.allPoints.length; i++) {
            var controlPoint = DRControlPoint.allPoints[i];

            if (controlPoint.isClickOn(_xmouse, _ymouse)) {
                currentControlPoint = controlPoint;
                return;
            }
        }
    }
    
    function onMouseMove() {
        if (currentControlPoint) {
            currentControlPoint.moveTo(_xmouse, _ymouse, Key.isDown(Key.SHIFT));
        }
    }
    
    function onMouseUp() {
        currentControlPoint = null;
    }
    
    function onKeyDown() {
        // trace(Key.getCode());

        if (Key.isDown(Key.SPACE)) {
            if (currentControlPoint) {
                mergeControlPoints();
            } else {
                course.setVisibility("course");
            }
        }
        if (Key.isDown(Key.ENTER)) {
            var courseDisplay = new DRCourseDisplay(course);
            courseDisplay.display();
            
            switchPen("drive");
        }
        if (currentControlPoint && Key.isDown(CHAR_C)) {
            currentControlPoint.cornerize();
        }
    }
    
    function onKeyUp() {
        course.setVisibility("all");
    }
    
    /*****************
    *                *
    * Action Methods *
    *                *
    *****************/
    
    function mergeControlPoints() {
        for (var i = 0; i < DRControlPoint.allPoints.length; i++) {
            var controlPoint = DRControlPoint.allPoints[i];

            if (controlPoint.isClickOn(_xmouse, _ymouse) && controlPoint != currentControlPoint) {
                controlPoint.replaceWith(currentControlPoint);
            }
        }
    }

}