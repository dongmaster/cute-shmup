import QtQuick 2.3

Rectangle {
    id: bullet
    width: 10
    height: 18
    color: "orange"

    Behavior on y {
        NumberAnimation {
            easing.type: Easing.Linear
            duration: 2000
        }
    }

    Behavior on x {
        NumberAnimation {
            easing.type: Easing.Linear
            duration: 2000
        }
    }

    property int bulletlimit: -1000

    Item {
        Component.onCompleted: {
            function rnum(input) {
                return Math.floor(Math.random() * input + 1);
            }

            function rnum2(min, max) { //Provides a random number between two values
                return Math.floor(Math.random() * (max+1 - min) ) + min;
            }
/*
            bullet.y = root.height / 2;
            bullet.x = root.widht / 2;
*/

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
        id: bullet_timer
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if(bullet.x === root.width / 2) {
                for(var i = 0; i < root.enemy_array.length; i++) {
                    root.enemy_array[i].health -= 50;
                }

                bullet.destroy();
                // Here we get the index of this bullets position in the bullet_array array.
                var bullet_index = root.bullet_array.indexOf(bullet);
                // We then use that variable to remove this bullet from the bullet_array array.
                remove(root.bullet_array, root.bullet_array[bullet_index]);
            }
        }
    }
}
