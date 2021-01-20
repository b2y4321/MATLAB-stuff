function a=minfunc(m,Rs)

rss=m.*Rs-round(m.*Rs,0);

a=sum(rss.^2);