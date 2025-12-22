// GSShoots.h: interface for the GSShoots class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GSSHOOTS_H__8D21F2CA_6D1D_4C70_B31C_548152D1016D__INCLUDED_)
#define AFX_GSSHOOTS_H__8D21F2CA_6D1D_4C70_B31C_548152D1016D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define MAX_SAMPLES 9

class GSShoots  
{
public:
	void Play(int sound, int mx, int my, int sx, int sy);
	void Play(int sound, int volume, int pan);
	void DestroySFX();
	bool LoadSFX();
	GSShoots();
	virtual ~GSShoots();

private:

	DATAFILE *m_soundsatd;
	int       m_voices[MAX_SAMPLES];
};

#endif // !defined(AFX_GSSHOOTS_H__8D21F2CA_6D1D_4C70_B31C_548152D1016D__INCLUDED_)
