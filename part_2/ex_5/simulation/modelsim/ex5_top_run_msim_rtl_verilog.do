transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gsp14/Documents/VERI_EIE2/part_2/ex_5 {C:/Users/gsp14/Documents/VERI_EIE2/part_2/ex_5/counter_8.v}

