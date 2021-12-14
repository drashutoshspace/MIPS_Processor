reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1
open_run synth_1
report_utilization -file utilization_synth.rpt
report_timing_summary -file timing_synth.rpt
