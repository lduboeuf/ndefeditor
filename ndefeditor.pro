# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

QT += nfc quick quickcontrols2

CONFIG += qmltypes
QML_IMPORT_NAME = NdefEditor
QML_IMPORT_MAJOR_VERSION = 1

TARGET = ndefeditor
TEMPLATE = app

SOURCES += \
    clipboard.cpp \
    main.cpp \
    nfcmanager.cpp \
    nfctarget.cpp \
    ndefmessagemodel.cpp

HEADERS += \
    clipboard.h \
    nfcmanager.h \
    nfctarget.h \
    ndefmessagemodel.h

qml_resources.files = \
    qmldir \
    Main.qml \
    MainWindow.qml \
    NdefRecordDelegate.qml

qml_resources.prefix = /qt/qml/NdefEditor

theme_resources.files = \
    qtquickcontrols2.conf \
    icons/ndefeditor/20x20@2/add.png \
    icons/ndefeditor/20x20@2/arrow_back.png \
    icons/ndefeditor/20x20@2/file_download.png \
    icons/ndefeditor/20x20@2/file_upload.png \
    icons/ndefeditor/20x20@2/link.png \
    icons/ndefeditor/20x20@2/text_snippet.png \
    icons/ndefeditor/20x20@3/add.png \
    icons/ndefeditor/20x20@3/arrow_back.png \
    icons/ndefeditor/20x20@3/file_download.png \
    icons/ndefeditor/20x20@3/file_upload.png \
    icons/ndefeditor/20x20@3/link.png \
    icons/ndefeditor/20x20@3/text_snippet.png \
    icons/ndefeditor/20x20@4/add.png \
    icons/ndefeditor/20x20@4/arrow_back.png \
    icons/ndefeditor/20x20@4/file_download.png \
    icons/ndefeditor/20x20@4/file_upload.png \
    icons/ndefeditor/20x20@4/link.png \
    icons/ndefeditor/20x20@4/text_snippet.png \
    icons/ndefeditor/20x20/add.png \
    icons/ndefeditor/20x20/arrow_back.png \
    icons/ndefeditor/20x20/file_download.png \
    icons/ndefeditor/20x20/file_upload.png \
    icons/ndefeditor/20x20/link.png \
    icons/ndefeditor/20x20/text_snippet.png \
    icons/ndefeditor/index.theme

theme_resources.prefix = /

RESOURCES += qml_resources theme_resources



ios: QMAKE_INFO_PLIST = Info.qmake.plist

#target.path = $$[QT_INSTALL_EXAMPLES]/nfc/ndefeditor
INSTALLS += target


UBUNTU_TOUCH {
    message("building for Ubuntu Touch")
    target.path = /

    # figure out the current build architecture
    CLICK_ARCH=$$system(dpkg-architecture -qDEB_HOST_ARCH)

    # substitute the architecture in the manifest file
    QMAKE_SUBSTITUTES += $$PWD/manifest.json.in
    manifest.files = manifest.json
    manifest.path = /
    INSTALLS += manifest


    click_files.path = /
    click_files.files = manifest.json ndefeditor.apparmor ndefeditor.desktop

    logo.path = /icons
    logo.files = $$PWD/icons/ndefeditor.png

    INSTALLS+=click_files logo
}


