import QtQuick 2.3

Image {
    id: boss1
    width: 100
    height: 62
    //color: "brown"
    source: "ettnasa.png"

    property int health: 250
    property int score_gain: 3500000
    property bool is_boss: true

    Behavior on y {
        NumberAnimation {
            easing.type: Easing.OutQuad
            duration: 2000
        }
    }

    Behavior on x {
        NumberAnimation {
            easing.type: Easing.OutQuad
            duration: 2000
        }
    }

    function rnum(input) {
        return Math.floor(Math.random() * input + 1)
    }

    function rnum2(min, max) { //Provides a random number between two values
        return Math.floor(Math.random() * (max+1 - min) ) + min;
    }

    property var bullet_array: []

    function enemy_shoot() {
        //for(var i = 0; i < 50; i++) {
            var enemy_bullet = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": boss1.x + boss1.width / 2, "y": boss1.y - 18 + 50});
            enemy_bullet.x = rnum(root.width);
            enemy_bullet.color = "lime";
            bullet_array.push(enemy_bullet);
        //}

        enemy_bullet.x = hitbox.x - hitbox.width / 2
    }

    function remove(arr, item) {
       var i;
       while((i = arr.indexOf(item)) !== -1) {
         arr.splice(i, 1);
       }
    }

    Timer {
        id: shoot_timer
        interval: rnum(50)
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            enemy_shoot();

            shoot_timer.interval = rnum(50);

            //boss1.x = rnum(root.width);

            //enemy1.x = rnum(root.width - enemy1.width);
            //enemy1.y = rnum2(0, 200);
        }
    }

    Timer {
        id: movement_timer
        interval: rnum(2000)
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            movement_timer.interval = rnum(1500);

            boss1.x = rnum(root.width);
            boss1.y = rnum(150) + 25;

            //enemy1.x = rnum(root.width - enemy1.width);
            //enemy1.y = rnum2(0, 200);
        }
    }

    Timer {
        id: bullet_randomization
        interval: 1
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            bullet_array[rnum(bullet_array.length - 1)].x = rnum(root.width + 100);
            remove(bullet_array, bullet_array[0]);
        }
    }

    Item {
        Component.onCompleted: {
            boss1.x = root.width / 2 - boss1.width / 2;
            root.boss_mode = true;
        }
    }
}
