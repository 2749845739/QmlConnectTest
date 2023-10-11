import QtQuick 2.7
import QtQuick.Controls 2.5

Rectangle{
    property int itemHeight:18
    //    signal click()


    implicitWidth: 120
    implicitHeight: control.height + itemHeight * 5
    ComboBox {
        id:control
        //                property Color showContentColor:"blue"    /*Qt.rgba(84/254, 144/254, 214/254,0.3)*/
        //                property Color borderColor:"green" /* Qt.rgba(80/254, 135/254, 200/254,0.8)*/
        //                property var selectFillColor: "red"/*"#68c169"//Qt.rgba(104/254, 193/254, 105/254,0.3)*/
        width: 120
        height: 40
        font.pixelSize: 14
        font.family: "SimHei"
        //        anchors.centerIn: parent




        /*显示的文字*/
        contentItem: Text {
            leftPadding: 10
            text: control.displayText
            font: control.font
            color: "white"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("back click")
                    click()
                    // after add mousearea, The original pop-up event is covered
                    pop.open()
                }
            }


        }

        /*显示的背景*/
        background: Rectangle {
            implicitWidth: control.width
            implicitHeight: control.height
            color: "#1A243D"
            border.color: "#273857"
            border.width: 2
            radius: 8




        }




        /*下拉图标*/
        //        indicator:
        //        Canvas {
        //            id: dnArrow
        //            visible: true
        //            x: control.width - 20
        //            y: (control.height)/2-2
        //            width: 12
        //            height: 7
        //            contextType: "2d"

        //            onPaint: {

        //                context.reset();
        //                context.lineWidth = 1;  //画笔宽度
        //                context.strokeStyle="white";
        //                context.moveTo(0, 0);
        //                context.lineTo(width/2, height);
        //                context.lineTo(width, 0);
        //                context.stroke();
        //                                context.closePath();
        //                context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
        ////                                context.fillStyle = "white";
        ////                                context.fill();
        //            }
        //        }


        Canvas {
            id: dnArrow
            //            visible: false
            visible: true
            x: control.width - 20
            y: (control.height)/2-5
            width: 12
            height: 14
            contextType: "2d"

            onPaint: {

                context.reset();
                context.lineWidth = 1;  //画笔宽度
                context.strokeStyle="white";
                context.moveTo(0, height/2);
                context.lineTo(width/2, height);
                context.lineTo(width, height/2);
                context.stroke();
                context.closePath();
                //                        context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
                //                                context.fillStyle = "white";
                //                                context.fill();
            }
        }

        Canvas {
            id: upArrow
            visible: false
            //            visible: true
            x: control.width - 20
            y: (control.height)/2-5
            width: 12
            height: 14
            contextType: "2d"

            onPaint: {
                context.reset();
                context.lineWidth = 1;  //画笔宽度
                context.strokeStyle="white";
                context.moveTo(0, height/2);
                context.lineTo(width/2, 0);
                context.lineTo(width, height/2);
                context.stroke();
                context.closePath();
                //                                context.fillStyle = "white";
                //                                context.fill();
            }
        }





        model: [" 小麦", " 水稻", " 玉米"]
        /*下拉框的选项*/
        delegate: ItemDelegate {
            width: control.width
            contentItem: Rectangle
            {
                anchors.fill:parent
                color:hovered ? "##273863" : "#242E49"
                // must be implicit  ,can't be height
                implicitHeight:itemHeight
                Text {
                    //                    anchors.centerIn: parent
                    text: modelData
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter
                    font: control.font
                    //                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
            }
            onClicked: { click() }

        }

        /*点击后弹出框背景*/
        popup: Popup {
            id:pop
            y: control.height - 1
            width: control.width
            implicitHeight: listview.contentHeight
            padding: 1

            contentItem: ListView {
                id: listview
                clip: true
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex

                //                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                border.color: "#273857"
                color: "#242E49"
                radius: 2

            }
        }



//        onPressedChanged: {
//            console.log(" pressedChanged ")
//            dnArrow.visible = !dnArrow.visible
//            upArrow.visible  = !upArrow.visible
//        }
    }





        function click(){
            console.log(" function click()")
            dnArrow.visible = !dnArrow.visible
            upArrow.visible  = !upArrow.visible

        }

}
