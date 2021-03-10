#include "systemcontroller.h"

SystemController::SystemController(QObject *parent)
    : QObject(parent)
    , m_currentSystemTemperature( 65 )
    , m_targetTemp( 70 )
    , m_systemStatusMessage( "Heating..." )
    , m_systemState( HEATING )
{
}

int SystemController::currentSystemTemperature() const
{
    return m_currentSystemTemperature;
}

int SystemController::targetTemp() const
{
    return m_targetTemp;
}

QString SystemController::systemStatusMessage() const
{
    return m_systemStatusMessage;
}

SystemController::HeatSelectState SystemController::systemState() const
{
    return m_systemState;
}

void SystemController::setCurrentSystemTemperature(int currentSystemTemperature)
{
    if (m_currentSystemTemperature == currentSystemTemperature)
        return;

    m_currentSystemTemperature = currentSystemTemperature;
    emit currentSystemTemperatureChanged(m_currentSystemTemperature);
}

void SystemController::setTargetTemp(int targetTemp)
{
    if (m_targetTemp == targetTemp)
        return;

    m_targetTemp = targetTemp;
    emit targetTempChanged(m_targetTemp);
    checkSystemStatus();
}

void SystemController::setSystemStatusMessage(QString systemStatusMessage)
{
    if (m_systemStatusMessage == systemStatusMessage)
        return;

    m_systemStatusMessage = systemStatusMessage;
    emit systemStatusMessageChanged(m_systemStatusMessage);
}

void SystemController::setSystemState(SystemController::HeatSelectState systemState)
{
    if (m_systemState == systemState)
        return;

    m_systemState = systemState;
    emit systemStateChanged(m_systemState);
    checkSystemStatus();
}

void SystemController::checkSystemStatus()
{
    if ( ( m_currentSystemTemperature < m_targetTemp ) && ( m_systemState == HEATING) )
        setSystemStatusMessage("Heating...");
    else if ( ( m_currentSystemTemperature > m_targetTemp ) && ( m_systemState == COOLING) )
        setSystemStatusMessage( "Cooling..." );
    else if ( m_systemState == AUTO ) {
        if ( ( m_currentSystemTemperature < m_targetTemp ) )
            setSystemStatusMessage("Heating...");
        else if ( ( m_currentSystemTemperature > m_targetTemp ))
            setSystemStatusMessage("Cooling...");
        else
            setSystemStatusMessage("Holding...");
    }
    else
        setSystemStatusMessage("Holding...");
}
