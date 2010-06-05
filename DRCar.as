class DRCar {

    static var car:DRCar;
    
    var cursor:DRVector;
    
    // Car parts:
    
    var chassis:DRChassis;        
    var wheel:DRWheel;
    var throttle:DRThrottle;
    
    function DRCar() {
        DRCar.car = this;
    }

    function moveTowards() {
        cursor = DRVector.mouse().minus( car.chassis.position );
        
        throttle.accelerate();
        wheel.turn();
        chassis.move();
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