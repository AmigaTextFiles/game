/*--- Filename: "logfile.hpp" ---

  Author: Dennis Busch (http://www.dennisbusch.de)
*/

#include <string>
#include <iostream>
using namespace std;
#include <stdio.h>
#include <time.h>

#if !defined(_logfile_HEAD_INCLUDED)
#define _logfile_HEAD_INCLUDED

namespace Logging
{
  /*log message type
    influences the prefix of a message in the logfile    
  */
  enum logMsgType
  {
    logMsg = 0,        // prefix "[msg]"
    logProgress,       // prefix "[{..]"
    logProgressOk,     // prefix "[}ok]"
    logProgressError,  // prefix "[}!!]"
    logError           // prefix "[!!!]"
  };
}

class Logfile;
typedef Logfile* ptrLogfile;

/*a simple class for writing log messages to a file
  Automatically appends timestamps in front of each message.
*/
class Logfile
{
  private:
    string fileName; // the filename of the underlying file
    string logName;  // the name of the log itself
    
    void writeStartMessage(); // writes a log start message to the log file
    void writeEndMessage(); // writes a log end message to the log file

  public:
    Logfile(string fileName, string logName);
    ~Logfile();
    
    // writes the given message to the end of the logfile
    bool Writeline(bool logActive, Logging::logMsgType msgType, string message);
};

#endif // #if !defined(_logfile_HEAD_INCLUDED)
