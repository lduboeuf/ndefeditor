// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ndefmessagemodel.h"
#include "nfcmanager.h"
#include "nfctarget.h"
#include "clipboard.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QIcon::setThemeName("ndefeditor");
    QCoreApplication::setOrganizationName("ndefeditor.lduboeuf");
    QCoreApplication::setApplicationName("ndefeditor");

    QQmlApplicationEngine engine;

    qmlRegisterType<NdefMessageModel> ("NdefEditor", 1, 0, "NdefMessageModel");
    qmlRegisterType<NfcManager> ("NdefEditor", 1, 0, "NfcManager");
    qmlRegisterUncreatableType<NfcTarget> ("NdefEditor", 1, 0, "NfcTarget", "Created by NfcManager");

    ClipBoard clipBoard;
    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("clipBoard", &clipBoard);

    const QUrl url(QStringLiteral("qrc:/qt/qml/NdefEditor/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
