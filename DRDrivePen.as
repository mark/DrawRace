class DRDrivePen extends DRPen {
    
    static var pen:DRDrivePen;
    
    var course:DRCourse;

    var car:DRCar;
    var cursor:MovieClip;
    
    function DRDrivePen() {
        super("drive");
    }
    
    function onPenDown() {
        this.course = DRCourse.course;
        this.car    = DRCar.car;

        course.setVisibility("course");

        cursor = course.clip.vehicles.attachMovie("Cursor", "Cursor_1", 2);
        cursor._x = _xmouse;
        cursor._y = _ymouse;
    }
    
    function onMouseDown() {
        if (! car.isInPlay()) {
            car.putInPlay(_xmouse, _ymouse);
        }
    }
    
    function onMouseMove() {
        if (car) {
            cursor._x = _xmouse;
            cursor._y = _ymouse;
        }
    }
    
    function onEnterFrame() {
        if (car.isInPlay()) {
            car.moveTowards(_xmouse, _ymouse);
        }
    }
    
}