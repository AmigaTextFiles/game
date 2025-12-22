// GMenuBack.h: interface for the GMenuBack class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GMENUBACK_H__F643B760_8165_11D4_8F75_CD8F543B9614__INCLUDED_)
#define AFX_GMENUBACK_H__F643B760_8165_11D4_8F75_CD8F543B9614__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

extern BITMAP* b_menu;

class GMenuBack  
{
public:
	void Screen();
	void Release();
	void Click();
	void Stop();
	void Start();
	void Acquire();
	virtual void Clear();
	virtual void Destroy();
	virtual bool LoadGFX();
	virtual void FadeOut();
	virtual void Flip();
	GMenuBack();
	virtual ~GMenuBack();

	BITMAP *m_back;

private:
	DATAFILE *m_dat;

};

#endif // !defined(AFX_GMENUBACK_H__F643B760_8165_11D4_8F75_CD8F543B9614__INCLUDED_)
