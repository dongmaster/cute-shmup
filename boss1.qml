import QtQuick 2.3

Image {
    id: boss1
    width: 100
    height: 62
    source: "ettnus.png"

    property int health: 150
    property int score_gain: 750000
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

    function enemy_shoot() {
        for(var i = 0; i < 50; i++) {
            var enemy_bullet = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": boss1.x + boss1.width / 2, "y": boss1.y - 18 + 50});
            enemy_bullet.x = rnum(root.width);
            enemy_bullet.color = "brown";
        }

        enemy_bullet.x = hitbox.x - hitbox.width / 2
    }

    Timer {
        id: shoot_timer
        interval: rnum(2000)
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            enemy_shoot();

            shoot_timer.interval = rnum(1800);

            boss1.x = rnum(root.width);

            //enemy1.x = rnum(root.width - enemy1.width);
            //enemy1.y = rnum2(0, 200);
        }
    }

    Item {
        Component.onCompleted: {
            boss1.x = root.width / 2 - boss1.width / 2;
            root.boss_mode = true;
        }
    }
}
