#ifndef CLIPBOARD_H
#define CLIPBOARD_H


#include <QObject>

class ClipBoard: public QObject
{
    Q_OBJECT

public:
    ClipBoard(QObject *parent = nullptr);

    Q_INVOKABLE void setText(const QString &from);
    Q_INVOKABLE QString text();
};

#endif // CLIPBOARD_H
