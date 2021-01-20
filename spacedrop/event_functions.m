function [value,isterminal,direction] = event_functions(t,v)

dend=0;
value=v(2)-dend;%When position=0
isterminal=1;%Yes, we terminate
direction=0;%Both dir