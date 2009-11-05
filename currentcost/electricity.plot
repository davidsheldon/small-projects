set terminal png  picsize 1024 600

set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"

set output "electricity.png"
plot "2009-07-23-power.log" using 1:4

