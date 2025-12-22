/* Synchron-Skript für 2 Mancala's auf einem Rechner */

parse arg aufruf kommando spieler feld

if aufruf=1 then
 address 'Mancala.2'
else
 address 'Mancala.1'

options results

callpause 0 3 0

select
when kommando='Undo' then callundo
when kommando='Neu' then callneu
when kommando='Spielende' then callspielende
when kommando='Zug' then callzug feld
otherwise
end

