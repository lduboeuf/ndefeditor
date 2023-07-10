// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "nfcmanager.h"

#include <QNearFieldManager>
#include <QDebug>

#include "nfctarget.h"

NfcManager::NfcManager(QObject *parent) : QObject(parent)
{
    m_manager = new QNearFieldManager(this);

    connect(m_manager, &QNearFieldManager::targetDetected, this, [this](QNearFieldTarget *target) {
        auto jsTarget = new NfcTarget(target);
        qDebug() << "kikou targetDetected ";
        QQmlEngine::setObjectOwnership(jsTarget, QQmlEngine::JavaScriptOwnership);
        Q_EMIT targetDetected(jsTarget);
    });
}

void NfcManager::startTargetDetection(int mode)
{
    //m_manager->setTargetAccessModes(TargetAccessModes::::NdefAccess);
    if (mode == 0) {
        m_manager->setTargetAccessModes(QNearFieldManager::NdefReadTargetAccess);
    } else {
        m_manager->setTargetAccessModes(QNearFieldManager::NdefWriteTargetAccess);

    }

    m_manager->startTargetDetection();
}


void NfcManager::stopTargetDetection()
{
    m_manager->setTargetAccessModes(QNearFieldManager::NoTargetAccess);
    m_manager->stopTargetDetection();
}
