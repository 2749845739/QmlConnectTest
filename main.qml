import QtQuick 2.15
import QtQuick.Window 2.15

import QtQuick.Controls 2.2

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("main.qml")


    TextField {
        color:"white"

        Rectangle{
            width:parent.width
            height: parent.height
            color:"blue"
        }
    }



       Rectangle{
           width:50
           height: 50
           color:"red"
           anchors.centerIn: parent
       }


}
