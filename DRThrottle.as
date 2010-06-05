class DRThrottle {
    
    static var ACCELERATION_FACTOR = 2.5;    
    static var ACCELERATION_RADIUS = 100.0;

    var car:DRCar;
    
    var throttle:Number;

    function DRThrottle(car:DRCar) {
        this.car = car;
        this.throttle = 0.0;
    }
    
    function accelerate() {
        var desiredThrottle = car.cursor.norm() / ACCELERATION_RADIUS;
        if (desiredThrottle > 1.0) desiredThrottle = 1.0;
        
        throttle = ACCELERATION_FACTOR * desiredThrottle;
    }
    
}