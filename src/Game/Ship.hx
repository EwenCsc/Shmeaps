package game;

import game.*;
import engine.*;
import engine.managers.*;
import haxe_helper.*;


/** Player and Aliens
 *  TODO: Shooting lasers
 *  TODO: Stats like life, speed, power etc etc
 */
class Ship extends Entity {

    private var laserAnimationData : AnimationDatas;
    private var lasers = new List<Laser>();
    private var life : Float;
    private var moveSpeed : Float;

    private var shootingCooldown : Float;
    private var currentShootingTimer : Float;

    public var onCollide : Delegate;

    public function new(_parent:h2d.Object, _animDatas:AnimationDatas, _laserAnimDatas:AnimationDatas) {
        super(_parent, _animDatas);
        laserAnimationData = _laserAnimDatas;
        shootingCooldown = 0.1;
        currentShootingTimer = 0;
        
        // Test Delegate
        // var annon = function() { trace("._."); };
        // onCollide = new Delegate();
        // onCollide += annon;
        // onCollide.addassign(annon);
        // onCollide.invoke();
    }

    public override function update() {

        super.update();
        currentShootingTimer -= TimeManager.instance.deltaTime;
        if (currentShootingTimer <= 0) 
            currentShootingTimer = 0;
        for (l in lasers) {
            l.update();
            if(l.toDestroy) {
                lasers.remove(l);
                removeChild(l); 
                l.remove(); 
            }
        }
    }

    private function shoot() {
        if (currentShootingTimer == 0) {
            currentShootingTimer = shootingCooldown;
            lasers.add(new Laser(getScene(), localPosition, laserAnimationData));
        }
    }

    public function receiveDamage(_damage:Float) {
        
    }
}