import QtQuick 2.0

Rectangle {

    id: rect
    width: 100
    height: 100

    signal send
    onSend: console.log("onSend")

    //    TapHandler {

    //    }
}
