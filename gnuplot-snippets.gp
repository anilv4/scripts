# Only used for storing gp commands for reuse.

# plotting 5 data points in a single graph
set xdata time
set timefmt "%Y/%m/%d"
set xrange ["2021/03/1":"2021/03/20"]
plot "tC-cV.data" u 1:($2/100000) w lp t "Total Cost",\
"tC-cV.data" u 1:($2/100000):(sprintf("(%.2f)", ($2/100000))) w labels offset char 1,1 notitle,\
"tC-cV.data" u 1:($3/100000) w lp t "Current Value",\
"tC-cV.data" u 1:($3/100000):(sprintf("(%.2f)", ($3/100000))) w labels offset char 1,1 notitle,\
"tC-cV.data" u 1:($3/100000):(sprintf("(%.2f%)", (($3-$2)/$3)*100)) w labels offset char -1,-1 notitle
