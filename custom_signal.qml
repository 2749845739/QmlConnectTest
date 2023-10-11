import QtQuick 2.0

Item {
    width: 600
    height: 100

    Rectangle {
        id: rect1
        width: 100
        height: 100
        color: "lightblue"

        Text {
            id: text1
            anchors.centerIn: parent
            text: "custom \n signal"
        }
    }

    Rectangle {
        id: rect2
        width: 100
        height: 100
        anchors.right: parent.right
        color: "lightblue"

        // 01: argu of function can be like
        function changeColor(obj, col) {
            //            obj.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            obj.color = col
        }

        Text {
            id: text2
            anchors.centerIn: parent
            text: "cuntom \n functin"
        }
    }

    Component {
        id: colorComponent

        Rectangle {
            id: colorMaker
            width: 100
            height: 100

            signal colorMakt(color col)

            MouseArea {
                anchors.fill: parent
                // call the custom signal
                onClicked: colorMaker.colorMakt(colorMaker.color)
            }
        }
    }

    Loader {
        id: redLoader
        anchors.left: rect1.right
        anchors.leftMargin: 50
        // 02: ource:qml      sourceComponent:compo
        sourceComponent: colorComponent
        onLoaded: item.color = "red"
    }

    Loader {
        id: greenLoader
        anchors.right: rect2.left
        anchors.rightMargin: 50
        sourceComponent: colorComponent
        onLoaded: item.color = "green"
    }

    Connections {
        target: redLoader.item
        // handler = on<Signal> !!!
        // don't forget  argument
        function onColorMakt(col) {
            rect2.changeColor(rect2, col)
            text1.color = col
        }
    }

    Connections {
        target: greenLoader.item
        function onColorMakt(col) {
            rect2.changeColor(rect2, col)
            text1.color = col
        }
    }
}
