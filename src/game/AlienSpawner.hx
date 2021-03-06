package game;

import engine.managers.EntityManager;
import engine.managers.GameManager;
import engine.managers.TimeManager;
import game.*;
import engine.*;
import h2d.Object;
import h2d.col.*;

class AlienSpawner extends Object {

    var waves : List<Void -> Bool>;
    var currentWave : Void -> Bool;
    var timer : Float = 0.5;

    public override function new() {
        super(Main.currentScene);

        waves = new List<Void -> Bool>();

        waves.push(firstWave);

        currentWave = waves.pop();
    }

    public function update() {
        timer -= TimeManager.instance.deltaTime;
        if(currentWave()) {
            currentWave = waves.length > 0 ? waves.pop() : end;
        }
    }

    private function firstWave() : Bool {

        if (timer <= 0) {
            timer += 0.5;
            spawn();
        }

        return false;
    }

    private function end() : Bool {
        return false;
    }

    private function spawn() {
        var e = EntityManager.instance.getFirstEntityOfType(Alien, false);
        var l : Alien;
        if(e != null){
            l  = cast(e, Alien);
            l.activate();
        }
        else {
            l = new Alien(Main.currentScene);
            EntityManager.instance.add(l);
        }
        l.movementFunction = l.sinusoid;
        l.sinusoid(0);
    }
}