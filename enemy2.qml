import QtQuick 2.3

Image {
    id: enemy2
    width: 40
    height: 70
    z: 3
    //color: "orange"
    source: "sfiende.png"

    property int health: 25
    property int score_gain: 40000
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
        var enemy_bullet1 = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": enemy2.x + enemy2.width / 2, "y": enemy2.y - 18 + 50});
        var enemy_bullet2 = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": enemy2.x + enemy2.width / 2, "y": enemy2.y - 18 + 50});
        var enemy_bullet3 = Qt.createComponent('enemy_bullet.qml').createObject(root, {"x": enemy2.x + enemy2.width / 2, "y": enemy2.y - 18 + 50});

        enemy_bullet2.x = enemy2.x - enemy2.width - 300;
        enemy_bullet3.x = enemy2.x + enemy2.width + 300;
    }

    function rnum(input) {
        return Math.floor(Math.random() * input + 1)
    }

    function rnum2(min, max) { //Provides a random number between two values
        return Math.floor(Math.random() * (max+1 - min) ) + min;
    }

    Timer {
        id: shoot_timer
        interval: 1200
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            enemy_shoot();

            enemy2.x = rnum(root.width - enemy2.width);
            enemy2.y = rnum2(0, 200);
        }
    }
}
