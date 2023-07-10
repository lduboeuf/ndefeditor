#include "clipboard.h"

#include <QClipboard>
#include <QGuiApplication>

ClipBoard::ClipBoard(QObject *parent) : QObject(parent)
{
}


void ClipBoard::setText(const QString &from)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(from);
}

QString ClipBoard::text()
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    return clipboard->text();

}
