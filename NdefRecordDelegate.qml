// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import NdefEditor 1.0

SwipeDelegate {
    property int index
    property int recordType
    property string recordText

    id: delegate

    contentItem: ColumnLayout {
        Label {
            text: qsTr("Record %L1 - %2").arg(model.index + 1).arg(
                    delegate.describeRecordType(model.recordType))
            font.bold: true
        }

        Label {
            text: model.recordText
            elide: Text.ElideRight
            maximumLineCount: 1
            Layout.fillWidth: true
        }
    }

    swipe.left: Button {
        text: qsTr("Delete")
        padding: 12
        height: delegate.height
        anchors.left: delegate.left
        onClicked: delegate.deleteClicked()
    }

    swipe.right: Row {
        anchors { top: parent.top;bottom: parent.bottom; right: parent.right }
        Button {
            visible: model.recordType === NdefMessageModel.UriRecord
            text: qsTr("Open")
            padding: 12
            height: delegate.height
            onClicked: Qt.openUrlExternally(model.recordText)
        }
        Button {
            text: qsTr("Copy")
            padding: 12
            height: delegate.height

            onClicked: {
                clipBoard.setText(model.recordText)
                swipe.close()
            }
        }
    }

    function describeRecordType(type) {
        switch (type) {
        case NdefMessageModel.TextRecord: return qsTr("Text")
        case NdefMessageModel.UriRecord: return qsTr("URI")
        default: return qsTr("Other")
        }
    }

    signal deleteClicked()
}
