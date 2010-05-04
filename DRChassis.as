class DRChassis {
    
    var car:DRCar;
    
    var width:Number;
    var height:Number;
    
    var x:Number;
    var y:Number;
    
    var facing:Number;
    
    var clip:MovieClip;
    
    function DRChassis(car:DRCar) {
        this.car = car;
    }

    function move() {
        var newX = this.x + car.throttle.speed * car.wheel.normalX();
        var newY = this.y + car.throttle.speed * car.wheel.normalY();
        
        
        place(newX, newY);
    }

    function isInPlay():Boolean {
        return clip != null;
    }
    
    function place(x:Number, y:Number, facing:Number) {
        this.x = x;
        this.y = y;

        if (clip == null) {
            clip = DRCourse.course.clip.vehicles.attachMovie("Car", "PlayerCar", 1);
            width = clip._height; // Car is facing sideways
            height = clip._width;
        }
        
        clip._x = x;
        clip._y = y;
        clip._rotation = car.wheel.facing;
    }

}