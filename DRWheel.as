class DRWheel {

    static var MAX_TURN  = 4.5;
    
    var car:DRCar;
    
    var facing:DRVector;
    
    function DRWheel(car:DRCar) {
        this.car = car;
        this.facing = DRVector.zero();
    }
    
    function turn() {        
        var direction = car.cursor;
        
        if (Math.abs( direction.degrees() - facing.degrees()) < MAX_TURN) {
            facing = direction.normal();
        } else {
            if (facing.directionTo(direction) == DRVector.CLOCKWISE) {
                facing = DRVector.inDirection( facing.degrees() - MAX_TURN );
            } else {
                facing = DRVector.inDirection( facing.degrees() + MAX_TURN );
            }
        }
    }
    
}