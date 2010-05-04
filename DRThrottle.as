class DRThrottle {
    
    static var MAX_SPEED = 6.0;
    static var MAX_ACCEL = 1.0;
    static var MAX_BRAKE = 0.25;
    
    static var ACCELERATION_RADIUS = 100.0;

    var car:DRCar;
    
    var speed:Number;

    function DRThrottle(car:DRCar) {
        this.car = car;
        this.speed = 0.0;
    }
    
    function speedTowards(x:Number, y:Number) {
        var length = Math.sqrt(x * x + y * y);

        var desiredSpeed = MAX_SPEED * length / ACCELERATION_RADIUS;

        if (speed > desiredSpeed) {
            speed -= MAX_BRAKE;
            if (speed < desiredSpeed) speed = desiredSpeed;
        } else {
            speed += MAX_ACCEL;
            if (speed > desiredSpeed) speed = desiredSpeed;
        }

        if (speed > MAX_SPEED) speed = MAX_SPEED;
        if (speed < 0.0) speed = 0.0;
    }
    
}