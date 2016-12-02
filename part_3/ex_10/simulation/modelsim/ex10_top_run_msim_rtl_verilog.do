transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gsp14/VERI/VERI_EIE2/part_3/mylib {C:/Users/gsp14/VERI/VERI_EIE2/part_3/mylib/spi2dac.v}

