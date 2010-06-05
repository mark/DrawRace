class DRVector {
    
    /************
    *           *
    * Constants *
    *           *
    ************/
    
    static var CLOCKWISE        = 1000;
    static var COUNTERCLOCKWISE = 2000;
    
    /*********************
    *                    *
    * Instance Variables *
    *                    *
    *********************/
    
    var _x:Number;
    var _y:Number;
    
    /**********************
    *                     *
    * Vector Constructors *
    *                     *
    **********************/
    
    function DRVector(x:Number, y:Number) {
        this._x = x;
        this._y = y;
    }

    static function mouse():DRVector {
        return new DRVector(_xmouse, _ymouse);
    }

    static function zero():DRVector {
        return new DRVector(0.0, 0.0);
    }
    
    static function unitX():DRVector {
        return new DRVector(1.0, 0.0);
    }
    
    static function unitY():DRVector {
        return new DRVector(0.0, 1.0);
    }
    
    static function inDirection(degrees:Number, scale:Number):DRVector {
        var factor = scale ? scale : 1.0;
        var rads = degrees * Math.PI / 180.0;
        return new DRVector( factor * Math.cos(rads), factor * Math.sin(rads) );
    }
    
    /*******************
    *                  *
    * Atomic Functions *
    *                  *
    *******************/
    
    function x():Number {
        return _x;
    }
    
    function y():Number {
        return _y;
    }
    
    function norm():Number {
        return Math.sqrt(x() * x() + y() * y());
    }
    
    function normal():DRVector {
        if (norm() == 0.0)
            return DRVector.zero();
        else
            return new DRVector(x() / norm(), y() / norm());
    }
    
    /*************
    *            *
    * Operations *
    *            *
    *************/
    
    function inverse():DRVector {
        return new DRVector( -x(), -y() );
    }
    
    function plus(force:DRVector):DRVector {
        return new DRVector(x() + force.x(), y() + force.y());
    }

    function plus_bang(force:DRVector):DRVector {
        _x += force.x();
        _y += force.y();
        
        return this;
    }
    
    function minus(force:DRVector):DRVector {
        return new DRVector(x() - force.x(), y() - force.y());
    }

    function scale(scalar:Number):DRVector {
        return new DRVector(x() * scalar, y() * scalar);
    }

    function scale_bang(scalar:Number):DRVector {
        _x *= scalar;
        _y *= scalar;
        
        return this;
    }
    
    /******************
    *                 *
    * Angle Functions *
    *                 *
    ******************/
    
    function degrees():Number {
        var degs = radians() * 180.0 / Math.PI;
        while (degs >= 360.0) { degs -= 360.0 }
        while (degs <    0.0) { degs += 360.0 }
        return degs;
    }
    
    function radians():Number {
        return Math.atan2(y(), x());
    }

    /*******************
    *                  *
    * Helper Functions *
    *                  *
    *******************/
    
    function directionTo(force:DRVector):Number {
        var to = force.degrees();
        if (to < degrees()) { to += 360.0 }
        
        if (to - degrees() < 180.0) {
            return DRVector.COUNTERCLOCKWISE;
        } else {
            return DRVector.CLOCKWISE;
        }
    }
    
    function cropNorm(max:Number):DRVector {
        var n = norm();
        
        if (n > max)
            return scale_bang( max / n );
        else
            return this;
    }
    
}