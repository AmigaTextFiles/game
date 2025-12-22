#ifndef CONFIG_H
#define CONFIG_H

class Config
{
private:
  struct ConfigEl
  {
    ConfigEl* next;
    char* name;
    char* val;
  };

  ConfigEl* first;

  void add (char* name, char* val);
  ConfigEl* get (char* name);

public:
  Config (char* filename);
  ~Config ();

  int get_int (char* name, int def = 0);
  char* get_str (char* name, char* def = "");
  int get_yesno (char* name, int def = 0);
};

class CrystConfig : public Config
{
public:
  CrystConfig (char* filename);
};

extern CrystConfig config;


#endif /*CONFIG_H*/
