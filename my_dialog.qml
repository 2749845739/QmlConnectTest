import QtQuick 2.15
import QtQuick.Controls 2.5

Rectangle {

    id: root
    implicitWidth: 500
    implicitHeight: 300

    border.color: "#273857"
    border.width: 2
    radius: 8

    Rectangle {
        id: title_rec
        width: parent.width
        height: 50
        anchors {
            top: parent.top
            topMargin: 0
        }
        color: "#303C56"

        Text {
            id: title
            color: "white"
            font.pixelSize: 18
        }
    }

    Rectangle {
        width: parent.width - 4
        height: root.height - title.height - 20
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: title_rec.bottom
            topMargin: 0
        }
        color: "white"

        Text {
            id: content
            color: "white"
            font.pixelSize: 16
        }
    }
}
