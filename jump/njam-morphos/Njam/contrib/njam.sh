#!/bin/bash
WM="none"
if [ -f "${HOME}/.wm_style" ] ; then
        WM=`cat ${HOME}/.wm_style`
fi

if [ "${WM}" = "none" ] && [ -f "${HOME}/.wmrc" ] ; then
        WM=`cat ${HOME}/.wmrc`
fi
if [ "${WM}" = "none" ] && [ -f "/etc/sysconfig/desktop" ] ; then
        . /etc/sysconfig/desktop
        WM=`echo ${DESKTOP} | tr [A-Z] [a-z]`
fi

if [ "${WM}" = "gnome" ] ; then
        SOUND=esddsp
elif [ "${WM}" = "kde" ] ; then
        SOUND=artsdsp
else
        SOUND=""
fi

${SOUND} /usr/games/njam/njam $*
