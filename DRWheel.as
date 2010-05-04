class DRWheel {

    static var MAX_TURN  = 2.0;
    
    var car:DRCar;
    
    var facing:Number;
    var turn:String;
    
    function DRWheel(car:DRCar) {
        this.car = car;
        this.facing = 0.0;
    }
    
    function turnTowards(x:Number, y:Number) {
        var direction = Math.atan2(y, x) * 180.0 / Math.PI;
        
        var newDirection:Number;

        // Normalize the two directions
        while (facing > direction) { direction += 360.0; }
        
        if (direction - facing < 180.0) {
            // Turn counterclockwise
            newDirection = facing + MAX_TURN;
            if (newDirection > direction) newDirection = direction;
            turn = "counterclockwise";
        } else {
            // Turn clockwise
            newDirection = facing - MAX_TURN;
            if (newDirection < direction) newDirection = direction;
            turn = "clockwise";
        }
        
        if (newDirection <   0.0) newDirection += 360.0;
        if (newDirection > 360.0) newDirection -= 360.0;

        facing = newDirection;
    }
    
    function normalY():Number {
        return Math.sin( facing * Math.PI / 180.0 );
    }
    
    function normalX():Number {
        return Math.cos( facing * Math.PI / 180.0 );
    }

}