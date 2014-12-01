import QtQuick 2.3

Rectangle {
    id: bullet
    width: 10
    height: 18
    color: "red"

    property bool has_hit_player: false
    property bool auto_death: false

    Behavior on y {
        NumberAnimation {
            easing.type: Easing.Linear
            duration: 2000
        }
    }

    Behavior on x {
        NumberAnimation {
            easing.type: Easing.Linear
            duration: 10000
        }
    }

    property int bulletlimit: -1000

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
            function rnum(input) {
                return Math.floor(Math.random() * input + 1)
            }

            function rnum2(min, max) { //Provides a random number between two values
                return Math.floor(Math.random() * (max+1 - min) ) + min;
            }

            bullet.x = 10000;


            //Random spread below
            //bullet.x = rnum2(player.x - player.width - rnum(200), player.x + player.width + rnum(200));
        }
    }


    function remove(arr, item) {
       var i;
       while((i = arr.indexOf(item)) !== -1) {
         arr.splice(i, 1);
       }
    }

    Timer {
        id: game_loop
        interval: 1
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if(bullet.x >= 9000) {
                bullet.destroy();
            }

            if(isColliding(bullet, hitbox) === true && bullet.has_hit_player === false && player.can_shoot === true && player.god === false) {
                player.health -= 1;
                bullet.has_hit_player = true;
                bullet.destroy();
            }
        }
    }

    Timer {
        // Auto Death
        interval: 20000
        running: true
        repeat: true

        onTriggered: {
            bullet.destroy();
        }
    }
}
