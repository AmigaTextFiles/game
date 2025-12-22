/** @file
    @brief		算術クラス
    @author		Noriyuki Lee
    @since		2003.07.01
*/

#ifndef ___LUNAMATH_H___
#define ___LUNAMATH_H___

/**
   @brief 算術クラス LunaMath で使っていた関数の互換品
   @todo -
   @bug -
*/

class LunaMath
{
private:

public:
  static void Initialize( int );
  static float Sin( long Angle );
  static float Cos( long Angle );
  static long Atan( long Dx, long Dy );
  static long Rand( long Start, long End );
  static float RandF( void );
};

#endif // ___LUNAMATH_H___

