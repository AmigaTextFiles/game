;batch2 - relocates WS2: to ram:
if not exists ram:missions
copy c:copy to ram:
ram:copy c:makedir to ram:
ram:makedir ram:bob_abks
ram:makedir ram:missions
ram:copy ws2:bob_abks/#? to ram:bob_abks
ram:copy ws2:missions/#? to ram:missions
ram:copy ws2:#? to ram:
list ram:          ;forces the removal of WS2 so that it can be
assign ws2: ram:   ;reassigned by this line to the ram drive...
endif
