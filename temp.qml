/** Copyright (C) USTC BMEC RFLab - All Rights Reserved.
 ** Unauthorized copying of this file, via any medium is strictly prohibited.
 ** Proprietary and confidential.
 **/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3
import RFLab.LabRoot 1.0
import "."
import "../"

Item{
    id: generalPage
    property var overallJ: ({})
    property string license: ""
    property string attr: ""
    property bool buttonShow : false
    property string licenseStr: ''
    property bool tagBtnVis: Number(userPerm) === UserPerm.Engineer
                             || Number(userPerm) === UserPerm.Clinician
                             || Number(userPerm) === UserPerm.Admin

    ColumnLayout{
        anchors.fill: parent
        spacing: 42
        anchors.topMargin:  24
        anchors.rightMargin:  18
        anchors.leftMargin: 36
        Layout.alignment: Qt.AlignTop
        RowLayout{
            Layout.fillWidth: true
            spacing: 42
            Image{
                width: 220
                height: width
                fillMode: Image.Tile
                sourceSize.width: width
                sourceSize.height: width
                Layout.alignment: Qt.AlignTop
                source: stringS(generalPage.overallJ.icon)
            }
            ColumnLayout{
                Layout.fillWidth: true
                spacing: 18
                Label{
                    font.pixelSize: 32
                    text: stringS(generalPage.overallJ.name) + " "+qsTr("MRI Console")
                    font.bold: true
                    font.capitalization: Font.AllUppercase
                }
                GridLayout{
                    Layout.fillWidth: true
                    columnSpacing: 10
                    columns: 2
                    Label{
                        text: qsTr("Version")
                        opacity: 0.85
                    }
                    Label{
                        text: stringS(generalPage.overallJ.version)
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }
                    Label{
                        text: qsTr("Manuafacturer")
                        opacity: 0.85
                    }
                    Label{
                        text: stringS(generalPage.overallJ.manufacturer)
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }
                    Label{
                        text: qsTr("Address")
                        opacity: 0.85
                    }
                    Label{
                        text: stringS(generalPage.overallJ.addr)
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }
                    Label{
                        text: qsTr("Description")
                        opacity: 0.85
                    }
                    Label{
                        text: stringS(generalPage.overallJ.description)
                        Layout.fillWidth: true
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                    Label{
                        text: qsTr("License")
                        opacity: 0.85
                    }
                    Label{
                        text: stringS(generalPage.licenseStr) +'    '+qsTr('Permission type') +': '+getUserType()
                        Layout.fillWidth: true
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    }
                }
            }
        }


        ColumnLayout{
            id: genLayout
            spacing: 36
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop

            SettingContentDelegate{
                Layout.fillWidth: true
                title: qsTr("GENERAL")
                explanation: qsTr("GENERAL_DISPLAY_EXP")
                mainContent: ColumnLayout{
                    Layout.fillWidth: true
                    spacing: 1
                    RowLayout{
                        Layout.fillWidth: true
                        spacing: 96
                        RowLayout{
                            Layout.fillWidth: true
                            spacing: 32
                            Label{
                                text: qsTr("LANGUAGE")
                                font.pixelSize: 16
                                font.bold: true
                                Layout.maximumWidth: 64
                                Layout.minimumWidth: 64
                            }
                            ComboBox{
                                id: languageCombo
                                model: languageModel
                                Layout.minimumWidth: 200
                                flat: true
                                textRole: "display"
                                popup.closePolicy: Popup.CloseOnPressOutside |
                                                   Popup.CloseOnReleaseOutside | Popup.CloseOnEscape
                                displayText: qsTr(currentText)
                                onActivated: {
                                    qmlVarHolder.streamOptNoReturn(["SET_DISPLAY_LANGUAGE"], [languageModel.get(index).key])
                                }
                            }
                        }

                        RowLayout{
                            Layout.fillWidth: true
                            spacing: 32
                            Label{
                                text: qsTr("THEME")
                                font.pixelSize: 16
                                font.bold: true
                                Layout.maximumWidth: 64
                                Layout.minimumWidth: 64
                            }
                            RowLayout{
                                Layout.alignment: Qt.AlignLeft
                                spacing: 18
                                Label{
                                    text: qsTr("LIGHT")
                                    color: !themeSwitch.checked? "#2ecc71" : Material.theme === Material.Dark ?
                                                                     "white" : "#cd000000"
                                    font.pixelSize: 16
                                    Layout.alignment: Qt.AlignRight
                                }
                                Switch {
                                    id: themeSwitch
                                    onClicked: {
                                        qmlVarHolder.streamOptNoReturn(["SET_THEME_LIGHT"], [!themeSwitch.checked])
                                    }
                                }
                                Label{
                                    text: qsTr("DARK")
                                    color: themeSwitch.checked? "#2ecc71" : Material.theme === Material.Dark ?
                                                                    "white" : "#cd000000"
                                    font.pixelSize: 16
                                    Layout.alignment: Qt.AlignRight
                                }
                            }
                        }
                    }
                    RowLayout{
                        Layout.fillWidth: true
                        spacing: 30
                        RowLayout{
                            Layout.fillWidth: true
                            spacing: 12
                            RoundButton{
                                highlighted: true
                                Material.accent: extService.connected ? Material.Green : Material.Red
                                icon.source: extService.connected ?
                                                 "qrc:/res/iconsX2/hardware/ic_phonelink_white_48dp.png" :
                                                 "qrc:/res/iconsX2/hardware/ic_phonelink_off_white_48dp.png"
                            }
                            Label{
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text:  extService.connected ? qsTr("Service manager is connected.")
                                                            : qsTr("Service manager is disconnected!")
                            }
                        }
                        RowLayout{
                            visible: false
                            Layout.fillWidth: true
                            spacing: 12
                            RoundButton{
                                highlighted: true
                                Material.accent: extService.webRunning ? Material.Green : Material.Red
                                icon.source: extService.webRunning ?
                                                 "qrc:/res/icons/action/ic_verified_user_white_48dp.png"
                                               : "qrc:/res/icons/alert/ic_error_white_48dp.png"
                            }
                            Label{
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                text: extService.webStatus
                            }
                        }
                    }
                }
            }

            SettingContentDelegate{//1
                id: aboutSetting
                Layout.fillWidth: true
                Layout.fillHeight: true
                title: qsTr("UI_ABOUT")
                explanation: ""

                mainContent: ColumnLayout{//2
                    Layout.fillHeight: true
                    spacing: 18

                    RowLayout{
                        Layout.fillWidth: true
                        spacing: 42
                        Button{
                            flat: true
                            text: qsTr("License Terms")
                            Material.foreground: aboutSwipeView.currentIndex === 0 ?
                                                     "Green" : Material.theme === Material.Light ? "black" : "white"
                            onClicked: {
                                aboutSwipeView.currentIndex = 0
                            }
                        }
                        Button{
                            flat: true
                            text: qsTr("Attributions")
                            Material.foreground: aboutSwipeView.currentIndex === 1 ?
                                                     "Green" : Material.theme === Material.Light ? "black" : "white"
                            onClicked: {
                                aboutSwipeView.currentIndex = 1
                            }
                        }
                        Button{
                            flat: true
                            text: qsTr("Components")
                            Material.foreground: aboutSwipeView.currentIndex === 2 ?
                                                     "Green" : Material.theme === Material.Light ? "black" : "white"
                            onClicked: {
                                updateVersion();
                                aboutSwipeView.currentIndex = 2
                            }
                        }
                    }

                    SwipeView{//3
                        id: aboutSwipeView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        interactive: false
                        clip: true
                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            bottomPadding: 1
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                            TextArea{
                                topPadding: 8
                                bottomPadding: 4
                                leftPadding: 12
                                rightPadding: 12
                                readOnly: true
                                selectByMouse: true
                                wrapMode: Text.WrapAnywhere
                                text: generalPage.license
                                textFormat: Text.MarkdownText
                                background: Rectangle {
                                    color: "#212121"
                                    border.color: "#808080"
                                }
                            }
                        }

                        ScrollView {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            bottomPadding: 1
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                            TextArea{
                                topPadding: 8
                                bottomPadding: 4
                                leftPadding: 12
                                rightPadding: 12
                                readOnly: true
                                selectByMouse: true
                                wrapMode: Text.WrapAnywhere
                                text: generalPage.attr
                                textFormat: Text.MarkdownText
                                background: Rectangle {
                                    color: "#212121"
                                    border.color: "#808080"
                                }
                            }
                        }

                        ColumnLayout{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            RowLayout{
                                Layout.fillWidth: true
                                spacing: 18
                                Image{
                                    fillMode: Image.PreserveAspectFit
                                    sourceSize.width: 32
                                    sourceSize.height: 32
                                    source: "qrc:/res/icons/action/ic_search_white_48dp.png"
                                }
                                TextField{
                                    id: jeSearchText
                                    Layout.fillWidth: true
                                    selectByMouse: true
                                    placeholderText: "Table search"
                                }
                            }

                            ColumnLayout{
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 2
                                clip: true
                                Divider{
                                    Layout.fillWidth: true
                                }
                                ListView{
                                    id: paraJsonListView
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    model: verTableModel
                                    interactive: true      /// FIXME Deadlock on scrolling to end
                                    ScrollBar.vertical: ScrollBar { }
                                    spacing: 0
                                    delegate: VerJsonDeg{
                                        width: paraJsonListView.width
                                        name: model.name
                                        branch: model.branch
                                        commit: model.commit
                                        jchild: jsonType(model.jchild) === 'undefined' ? {} : model.jchild
                                    }
                                    }
                                    }

                        }
                    }//3
                }//2
            }//1

            SettingContentDelegate{
                                            Layout.fillWidth: true
                                            title: qsTr("SYSINFO")
                                            explanation: qsTr("SYSINFO_EXP")
                                            mainContent: ColumnLayout{
                                                Layout.fillWidth: true
                                                Layout.fillHeight: true
                                                spacing: 16

                                                GridLayout{
                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    columnSpacing: 50
                                                    rowSpacing: 10
                                                    columns: 2

                                                    CusInfoItem {
                                                        id:item_Modality
                                                        itemLabel:"Modality"
                                                        itemContentPlace:"MRI"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }
                                                    CusInfoItem {
                                                        id:item_Manuafacturer
                                                        itemLabel:"Manuafacturer"
                                                        itemContentPlace:"Fuqing Company"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }

                                                    CusInfoItem {
                                                        id:item_InstitutionName
                                                        itemLabel:"InstitutionName"
                                                        itemContentPlace:"Climber Bay N"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }
                                                    CusInfoItem {
                                                        id:item_InstitutionAddress
                                                        itemLabel:"InstitutionAddress"
                                                        itemContentPlace:"Innovation Industria Garden"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }
                                                    CusInfoItem {
                                                        id:item_StationName
                                                        itemLabel:"StationName"
                                                        itemContentPlace:"RFLab"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }

                                                    CusInfoItem {
                                                        id:item_ThirdPartyUser
                                                        itemLabel:"ThirdPartyUser"
                                                        itemContentPlace:"Magforce"
                                                        onStopEdit:{
                                                            checkSettingChanged()
                                                        }
                                                    }
                                                }
                                            }
                                        }

            Item{
                Layout.fillHeight: true
                visible: !aboutSetting.isExpanded
            }
        }
//    }

                                ExtServiceHelper{
                                    id: extService
                                }

                                ListModel{
                                    id: languageModel
                                }

                                ListModel{
                                    id: verTableModel
                                }

                                Component.onCompleted: {
                                    themeSwitch.checked = Material.theme === Material.Dark
                                    reloadConfig()
                                    /// Init version json object
                                    updateVersion();
                                    initSysInfoConfig()
                                    /// Read license and attributions text content
                                    var licenseQ = qmlVarHolder.streamOptWithReturn(["MAINPW",
                                                                                     "READ_TEXT_FILE"], [":/settings/assets/License.md"])
                                    if( licenseQ && licenseQ.length > 0 ){
                                        generalPage.license = licenseQ[0]
                                    }
                                    var attrQ = qmlVarHolder.streamOptWithReturn(["MAINPW",
                                                                                  "READ_TEXT_FILE"], [":/settings/assets/Attributions.md"])
                                    if( attrQ && attrQ.length > 0 ){
                                        generalPage.attr = attrQ[0]
                                    }
                                }

                                ///////////////////////////////////
                                function qmlOpt(opt, paraArray){
                                    var optName = opt[0].toString().toUpperCase();
                                    if(optName.localeCompare("SWITCH_IN") === 0 ){
                                        if(buttonShow){
                                            settingsRoot.showButton()
                                        }
                                    }else if(optName.localeCompare("SWITCH_OUT") === 0){
                                        settingsRoot.hideButton()
                                    }else if(optName.localeCompare("ON_RESET_CLICKED") === 0){
                                        initSysInfoConfig()
                                        settingsRoot.hideButton()
                                        buttonShow = false
                                    }else if(optName.localeCompare("ON_SAVE_CLICKED") === 0){
                                        saveSysinfoConfig()
                                        initSysInfoConfig()
                                        settingsRoot.hideButton()
                                        buttonShow = false
                                    }else{
                                        console.log("SettingsGeneral unknown qmlOpt", opt, paraArray)
                                    }
                                }

                                function updateVersion(){
                                    /// update version json object
                                    var verArr = qmlVarHolder.streamOptWithReturn(["MAINPW", "VERSION"], [])
                                    generalPage.overallJ = verArr[0]
                                    verArr.splice(0,1)
                                    setJsonArr(verArr)
                                }

                                function reloadConfig(){
                                    languageModel.clear()
                                    var theme = qmlVarHolder.readJsonFile("config/theme.json")
                                    try{
                                        var availableLang = theme["AvailableLanguages"]
                                        availableLang.forEach(function(lang) {
                                            languageModel.append({display: lang.display, key: lang.key})
                                        })
                                        var currentLanguage = String(theme["Language"]).toLowerCase()
                                        var i;
                                        for( i = 0; i < languageModel.count; i ++ ){
                                            if( currentLanguage === languageModel.get(i).key ){
                                                break;
                                            }
                                        }
                                        languageCombo.currentIndex = i >= languageModel.count ? 0 : i ;
                                    }catch(e){
                                        console.log(e)
                                    }
                                    try{
                                        themeSwitch.checked = !Boolean(theme['LightTheme'])
                                    }catch(err){
                                        console.log(err)
                                    }
                                }

                                function getUserType(){
                                    switch(userPerm){
                                    case UserPerm.Admin: return qsTr('Admin')
                                    case UserPerm.Engineer: return qsTr('Engineer')
                                    case UserPerm.Clinician: return qsTr('Clinician')
                                    case UserPerm.Customer: return qsTr('Customer')
                                    case UserPerm.CustomerAdmin: return qsTr('Customer Admin')
                                    default: return qsTr('Unknown User')
                                    }
                                }

                                function setJsonArr(jsonObj){
                                    verTableModel.clear()
                                    jsonObj.forEach( function(jsonA, index){
                                        var childJ = JSON.stringify(jsonA.children)
                                        verTableModel.append({name: jsonA.name,
                                                                 branch: jsonA.branch,
                                                                 commit: jsonA.commit,
                                                                 dt: jsonA.datetime,
                                                                 build: jsonA.build,
                                                                 jchild: childJ === 'undefined' ? {} : childJ
                                                             })
                                    })
                                }

                                function stringS(str){
                                    if( typeof str == 'object' ||
                                            typeof str == 'undefined' ){
                                        return ''
                                    }
                                    return String(str)
                                }

                                function jsonType(jsonA){
                                    var type = typeof jsonA
                                    if( Array.isArray(jsonA) ){
                                        type = 'array'
                                    }
                                    return type;
                                }

                                function initSysInfoConfig(){
                                    sysinfoConfig = qmlVarHolder.readJsonFile("config/sysInfo.json")
                                    item_Modality.itemContentText = sysinfoConfig.Modality === undefined
                                            ? 1 : sysinfoConfig.Modality
                                    item_Manuafacturer.itemContentText = sysinfoConfig.Manuafacturer === undefined
                                            ? 1 : sysinfoConfig.Manuafacturer
                                    item_InstitutionName.itemContentText = sysinfoConfig.InstitutionName === undefined
                                            ? false : sysinfoConfig.InstitutionName
                                    item_InstitutionAddress.itemContentText = sysinfoConfig.InstitutionAddress === undefined
                                            ? false : sysinfoConfig.InstitutionAddress
                                    item_StationName.itemContentText = sysinfoConfig.StationName === undefined
                                            ? false : sysinfoConfig.StationName
                                    item_ThirdPartyUser.itemContentText = sysinfoConfig.ThirdPartyUser === undefined
                                            ? false :sysinfoConfig.ThirdPartyUser
                                }

                                function checkSettingChanged(){
                                    if(sysinfoConfig.Modality === item_Modality.itemContentText
                                            && sysinfoConfig.Manuafacturer === item_Manuafacturer.itemContentText
                                            && sysinfoConfig.InstitutionName === item_InstitutionName.itemContentText
                                            && sysinfoConfig.InstitutionAddress === item_InstitutionAddress.itemContentText
                                            && sysinfoConfig.StationName === item_StationName.itemContentText
                                            && sysinfoConfig.ThirdPartyUser === item_ThirdPartyUser.itemContentText)
                                    {
                                        buttonInThisPage = false
                                        settingsRoot.hideButton()
                                    }else{
                                        console.log("check changed: true ")
                                        buttonInThisPage = true
                                        settingsRoot.showButton()
                                    }
                                }

                                function saveSysinfoConfig(){
                                    // 写入数组时，需要在这里处理好，再调用setJsonFile
                                    var sysinfoJson = {}
                                    sysinfoJson.Modality = item_Modality.itemContentText
                                    sysinfoJson.Manuafacturer = item_Manuafacturer.itemContentText
                                    sysinfoJson.InstitutionName = item_InstitutionName.itemContentText
                                    sysinfoJson.InstitutionAddress = item_InstitutionAddress.itemContentText
                                    sysinfoJson.StationName = item_StationName.itemContentText
                                    sysinfoJson.ThirdPartyUser =item_ThirdPartyUser.itemContentText
                                    qmlVarHolder.setJsonFile("config/sysInfo.json", sysinfoJson, false)

                                    var msgJson = {}
                                    msgJson.icon ="assets/general.png";
                                    msgJson.title = "General";
                                    msgJson.content  ="General Settings saved successfully";
                                    msgJson.type =  "Information";
                                    settingsRoot.showMessage(msgJson)
                                }

}
