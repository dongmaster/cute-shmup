import QtQuick 2.0

Rectangle {
    id: color_block
    width: 100
    height: 62
    z: 2
    color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1);

    Timer {
        // Auto Death
        interval: 500
        running: true
        repeat: true

        onTriggered: {

        color_block.destroy();

        }
    }
}
