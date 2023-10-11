import QtQuick 2.0

Rectangle {
    id: rect
    width: 100
    height: 100


    MouseArea{
        id:mou
        anchors.fill: parent
    }

    // qml can receive any signal from the specified object
    Connections {
        target: mou
        function onClicked(){
            rect.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1)
            console.log("receive clicked ")

        }
    }
}
