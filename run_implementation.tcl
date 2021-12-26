reset_run impl_1
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
report_utilization -file utilization_impl.rpt
report_timing_summary -file timing_impl.rpt
report_power -file power.rpt
