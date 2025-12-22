// GMenuBackFading.h: interface for the GMenuBackFading class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GMENUBACKFADING_H__F643B761_8165_11D4_8F75_CD8F543B9614__INCLUDED_)
#define AFX_GMENUBACKFADING_H__F643B761_8165_11D4_8F75_CD8F543B9614__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GMenuBack.h"

class GMenuBackFading : public GMenuBack  
{
public:
	void Zaloha();
	void Destroy();
	bool LoadGFX();
	void FadeOut();
	void Flip();

	GMenuBackFading();
	virtual ~GMenuBackFading();

private:
	bool    m_faded;
	int     m_alpha;
	BITMAP *m_zaloha;
};

#endif // !defined(AFX_GMENUBACKFADING_H__F643B761_8165_11D4_8F75_CD8F543B9614__INCLUDED_)
