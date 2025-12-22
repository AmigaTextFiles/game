/*--- Filename: "logfile.cpp" ---
  
  Author: Dennis Busch (http://www.dennisbusch.de)
*/

#include "logfile.hpp"

/*starts new logfile

  fileName, the name of the logfile to use for all lines written to it
  logName, the name of the log itself
*/
Logfile::Logfile(string fileName, string logName)
{
  this->fileName = fileName.c_str();
  this->logName = logName.c_str();
  
  writeStartMessage();
}

Logfile::~Logfile()
{
  writeEndMessage();
}

/*writes a message to the logfile

  logActive, set to false to not do anything
  msgType, influences the prefix of the message \sa Logging::logMsgType
  msg, the message to write to the logfile
  returns, true if anything was written
*/
bool Logfile::Writeline(bool logActive, Logging::logMsgType msgType, string msg)
{
  if(!logActive) // don't do anything if log flag of caller is not enabled
    return false;
  
  // open/append to file
  FILE* lf = fopen(fileName.c_str(), "a");
  if(lf == NULL)
    return false;
    
  // get time
  time_t currentTime = time(NULL);
  tm *ptr_timeParts = localtime(&currentTime);
  
  // convert time to string
  char timeString[64];
  strftime(&timeString[0], 64, "%H:%M:%S ", ptr_timeParts);
  
  // write message to log
  string message;
  message.clear();
  message.append(timeString); 
  
  clock_t clockTicks = clock();
  char msecsSinceStart[32];
  sprintf(&msecsSinceStart[0], "%12.12u", (unsigned int)(clockTicks * 1000 / CLOCKS_PER_SEC));
  
  message.append(msecsSinceStart);
  
  switch(msgType)
  {
    case Logging::logMsg:
      message.append(" [msg] ");
    break;
    case Logging::logProgress:
      message.append(" [{..] ");
    break;
    case Logging::logProgressOk:
      message.append(" [}ok] ");
    break;
    case Logging::logProgressError:
      message.append(" [}!!] ");
    break;
    case Logging::logError:
      message.append(" [!!!] ");
    break;
    default:
      message.append(" [msg] ");
    break;
  }
  
  message.append(msg);
  
  fprintf(lf, "%s\n", message.c_str());
  
  // close file
  fclose(lf);
  return true;
}

void Logfile::writeStartMessage()
{
  // open/create file
  FILE* lf = fopen(fileName.c_str(), "w");
  if(lf == NULL)
    return;
  
  // get time
  time_t currentTime = time(NULL);
  tm *ptr_timeParts = localtime(&currentTime);
  
  // convert time to string
  char timeString[64];
  strftime(&timeString[0], 64, "%d.%m.%Y %H:%M:%S", ptr_timeParts);
  
  // write message to log
  string message;
  message.clear();
  message.append(timeString); message.append(" [msg] '"); message.append(logName); message.append("' log started");
  fprintf(lf, "%s\n", message.c_str());
  
  // close file
  fclose(lf);
}

void Logfile::writeEndMessage()
{
  // open/append to file
  FILE* lf = fopen(fileName.c_str(), "a");
  if(lf == NULL)
    return;
  
  // get time
  time_t currentTime = time(NULL);
  tm *ptr_timeParts = localtime(&currentTime);
  
  // convert time to string
  char timeString[64];
  strftime(&timeString[0], 64, "%d.%m.%Y %H:%M:%S", ptr_timeParts);
  
  // write message to log
  string message;
  message.clear();
  message.append(timeString); message.append(" [msg] '"); message.append(logName); message.append("' log finished");
  fprintf(lf, "%s\n", message.c_str());
  
  // close file
  fclose(lf);
}
