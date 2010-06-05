class DRChassis {
 
    static var FRICTION = 0.3;
    
    var car:DRCar;
    
    var width:Number;
    var height:Number;

    var position:DRVector;
    var velocity:DRVector;
    
    var clip:MovieClip;
    
    function DRChassis(car:DRCar) {
        this.car = car;
        this.position = DRVector.zero();
        this.velocity = DRVector.zero();
    }

    function move() {
        var direction = car.wheel.facing;
        
        // Modify velocity:
        velocity.scale_bang( 1.0 - FRICTION );
        velocity.plus_bang( direction.scale( car.throttle.throttle ) );
        
        // Move car:
        position.plus_bang( velocity );        
        place(position.x(), position.y());
    }

    function isInPlay():Boolean {
        return clip != null;
    }
    
    function place(x:Number, y:Number, facing:Number) {
        //this.x = x;
        //this.y = y;

        if (clip == null) {
            clip = DRCourse.course.clip.vehicles.attachMovie("Car", "PlayerCar", 1);
            width = clip._height; // Car is facing sideways
            height = clip._width;
            clip._x = x;
            clip._y = y;
            position = new DRVector(x, y);
        }
        
        clip._x = x;
        clip._y = y;
        clip._rotation = car.wheel.facing.degrees();
    }

}