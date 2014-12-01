import QtQuick 2.3

Rectangle {
    id: enemy_bullet
    width: 10
    height: 18
    color: "red"
    z: 10

    property bool has_hit_player: false
    property bool auto_death: false

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

    function isColliding(param1, param2) { //Function for handling collision. praise google
        return (param1.x < param2.x + param2.width) && (param1.y < param2.y + param2.height) && (param1.x + param1.width > param2.x) && (param1.y + param1.height > param2.y);
    }

    Item {
        Component.onCompleted: {
            //enemy_bullet.x = rnum(root.width);
            enemy_bullet.y = root.height + 50;
        }
    }

    Timer {
        id: game_loop
        interval: 1
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if(enemy_bullet.y >= root.height + 10) {
                enemy_bullet.destroy();
            }

            if(isColliding(enemy_bullet, hitbox) === true && enemy_bullet.has_hit_player === false && player.can_shoot === true && player.god === false) {
                player.health -= 1;
                enemy_bullet.has_hit_player = true;
                enemy_bullet.destroy();
            }
        }
    }

    Timer {
        // Auto Death
        interval: 6000
        running: true
        repeat: true

        onTriggered: {
                enemy_bullet.destroy();

        }
    }
}
