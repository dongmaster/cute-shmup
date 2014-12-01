import QtQuick 2.0

Item {
    id: explosion
    width: 100
    height: 100

    Rectangle {
        id: one
        width: 10
        height: 10
        //source: 'base/heart_blackgreengradient.png'
        color: 'aqua'
        radius: 50
        border.width: 1
        border.color: 'black'

        Behavior on x {
            NumberAnimation {
                easing.type: Easing.Linear
                duration: 500
            }
        }

        Behavior on y {
            NumberAnimation {
                easing.type: Easing.Linear
                duration: 500
            }
        }

        function rnum2(min, max) { //Provides a random number between two values
            return Math.floor(Math.random() * (max+1 - min) ) + min;
        }


        Component.onCompleted: {
            one.y = rnum2(-200, 200);
            one.x = rnum2(-200 ,200);
        }
    }
}
