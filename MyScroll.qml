import QtQuick 2.15
import QtQuick.Controls 2.2

Item {

    Rectangle {
        id: frame
        clip: true
        width: 160
        height: 160
        border.color: "black"
        anchors.centerIn: parent

        Text {
            id: content
            text: "ABC"
            font.pixelSize: 160
            x: -hbar.position * width
            y: -vbar.position * height
        }

        ScrollBar {
            id: vbar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Vertical
            size: frame.height / content.height
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        ScrollBar {
            id: hbar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Horizontal
            size: frame.width / content.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }

}
