#ifndef TIMELOGHISTORY_H
#define TIMELOGHISTORY_H

#include <QObject>
#include <QSet>

#include "TimeLogEntry.h"

class TimeLogHistoryWorker;

class TimeLogHistory : public QObject
{
    Q_OBJECT
public:
    explicit TimeLogHistory(QObject *parent = 0);
    ~TimeLogHistory();

    bool init();
    qlonglong size() const;
    QSet<QString> categories() const;

public slots:
    void insert(const TimeLogEntry &data);
    void remove(const QUuid &uuid);
    void edit(const TimeLogEntry &data);

    void getHistory(const QDateTime &begin = QDateTime::fromTime_t(0),
                    const QDateTime &end = QDateTime::currentDateTime(),
                    const QString &category = QString()) const;
    void getHistory(const uint limit,
                    const QDateTime &until = QDateTime::currentDateTime()) const;

signals:
    void error(const QString &errorText) const;
    void dataAvailable(QVector<TimeLogEntry> data) const;

private:
    TimeLogHistoryWorker *m_worker;
};

#endif // TIMELOGHISTORY_H
