import QtQuick 2.3

Image {
    id: enemy1
    width: 70
    height: 40
    //color: "lime"
    z: 3
    source: "fiende.1.png"

    property int health: 10
    property int score_gain: 10000
    property bool is_boss: false

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

    function enemy_shoot() {
        var enemy_bullet = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": enemy1.x + enemy1.width / 2, "y": enemy1.y - 18 + 50});
        enemy_bullet.x = hitbox.x - hitbox.width / 2
        //enemy_bullet.y = hitbox.y - hitbox.height / 2
    }

    function rnum(input) {
        return Math.floor(Math.random() * input + 1)
    }

    function rnum2(min, max) { //Provides a random number between two values
        return Math.floor(Math.random() * (max+1 - min) ) + min;
    }

    Timer {
        id: shoot_timer
        interval: 1300
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            enemy_shoot();

            enemy1.x = rnum(root.width - enemy1.width);
            enemy1.y = rnum2(0, 200);
        }
    }
}
