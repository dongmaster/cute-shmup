import QtQuick 2.3
import QtQuick.Window 2.2
import QtMultimedia 5.0
import "js.js" as JS

Window {
    id: window_root
    visible: true
    width: 800
    height: 700

    Rectangle {
        id: root
        visible: true
        color: "black"
        width: parent.width
        height: parent.height
        focus: true

        property var enemy_array: []
        property var bullet_array: []

        property bool boss_mode: falsezzzzzzz

        property bool enemy2_allow: false

        property int level: 1

        Keys.onPressed: {
            if(event.key === Qt.Key_Z && player.can_shoot === true) {
                JS.shooting = true;
                //console.log(enemy_array, bullet_array);
            }

            if(event.key === Qt.Key_X) {
                JS.special_ability();
            }

            if(event.key === Qt.Key_C) {
                JS.create_boss2();
            }

            if(event.key === Qt.Key_F) {
                fps.visible = true;
            }

            if(event.key === Qt.Key_G) {
                JS.toggle_god();
            }

            if(event.key === Qt.Key_P) {
                JS.restart();
            }
        }

        Keys.onReleased: {
            if(event.key === Qt.Key_Z) {
                JS.shooting = false;
            }
        }

        Text {
            id: fps
            text: '0'
            font.pointSize: 20
            color: 'white'
            visible: false
            y: 670
            z: 11
        }

        Timer {
            interval: 1
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                JS.fpscounter++;
            }
        }

        Timer {
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                fps.text = JS.fpscounter;
                JS.fpscounter = 0;
            }
        }




        Rectangle {
            id: hitbox
            color: "purple"
            width: player.width / 4
            height: player.height / 4
            z: 6

            Rectangle {
                id: player
                width: 40
                height: 50
                color: "lime"
                z: 3

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                property int health: 10
                property double score: 0

                property bool can_shoot: true
                property bool god: false

                Rectangle {
                    color: "purple"
                    width: player.width / 4
                    height: player.height / 4

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Text {
            id: player_health_text
            text: "HP: " + player.health
            font.pointSize: 16
            color: "white"

            Text {
                id: score_text
                text: "Score: " + player.score
                font.pointSize: 14
                color: "white"

                y: parent.y + parent.height
            }
        }

        Text {
            id: game_over_text
            text: "GAME OVER"
            font.pointSize: 24
            visible: false
            color: "white"
            anchors.centerIn: parent
        }

        MouseArea {
            id: mousearea
            anchors.fill: parent
            hoverEnabled: true

            onMouseXChanged: {
                hitbox.x = mouse.x - hitbox.width / 2;

                if(mouse.y <= 150) {
                    JS.punish();
                }
            }

            onMouseYChanged: {
                hitbox.y = mouse.y - hitbox.height / 2;
            }
        }

        Timer {
            id: game_loop_bullets
            interval: 100
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                if(JS.shooting === true) {
                    JS.shoot();
                }

                if(player.health <= 0) {
                    player.visible = false;
                    game_over_text.visible = true;
                    player.can_shoot = false;
                }
            }
        }

        Timer {
            id: game_loop
            interval: 1
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                JS.check_collision();
            }
        }

        Timer {
            id: enemy1_spawner
            interval: 800
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                JS.create_enemy();
            }
        }

        Timer {
            id: enemy2_spawner
            interval: 10000
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                if(root.enemy2_allow === true) {
                    JS.create_enemy2();
                } else {
                    root.enemy2_allow = true;
                }
            }
        }

        Timer {
            id: level_switch
            interval: 30000
            running: true
            repeat: true

            onTriggered: {
                if(root.level === 1 && root.boss_mode === false) {
                    JS.create_boss();
                } else if(root.level === 2 && root.boss_mode === false) {
                    JS.create_boss2();
                }
            }
        }

        MediaPlayer {
            id: music
            source: 'music1.ogg'
            autoPlay: true
            loops: Animation.Infinite

            Component.onCompleted: {
                music.play();
            }
        }


        Timer {
            id: color_switcher
            interval: 100
            running: true
            repeat: true

            onTriggered: {
                //root.color = Qt.rgba(Math.random(), Math.random(), 0, 1);
                Qt.createComponent('color_block.qml').createObject(root, {"x": JS.rnum(root.width), "y": JS.rnum(root.height)});
            }
        }
    }
}
