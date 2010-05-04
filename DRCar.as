class DRCar {

    static var car:DRCar;
    
    var chassis:DRChassis;        
    var wheel:DRWheel;
    var throttle:DRThrottle;
    
    function DRCar() {
        DRCar.car = this;
    }

    function moveTowards(x:Number, y:Number) {
        var dx = x - chassis.x;
        var dy = y - chassis.y;
        
        wheel.turnTowards(dx, dy);        
        throttle.speedTowards(dx, dy);
        
        chassis.move(throttle, wheel);
    }
    
    function isInPlay():Boolean {
        return chassis.isInPlay();
    }
    
    function putInPlay(x:Number, y:Number) {
        wheel    = new DRWheel(this);
        throttle = new DRThrottle(this);
        chassis  = new DRChassis(this);
        
        chassis.place(x, y, 0.0);
    }

}