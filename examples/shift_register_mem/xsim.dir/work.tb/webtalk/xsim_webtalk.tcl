webtalk_init -webtalk_dir D:/vik/RTL_design/dsn_verif/examples/shift_register_mem/xsim.dir/work.tb/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Tue Nov 19 10:54:44 2019" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2019.1 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2552052" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "WIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "4eaf1bbe-4475-4ca0-a229-d9b0a8038b36" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "11ad3a11-c920-4954-a57e-ad6eaaa723a5" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "6" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Windows Server 2016 or Windows 10" -context "user_environment"
webtalk_add_data -client project -key os_release -value "major release  (build 9200)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "AMD A8-7410 APU with AMD Radeon R5 Graphics    " -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "2196 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "11.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key runall -value "true" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key runtime -value "960 ns" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "0" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.03_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "5416_KB" -context "xsim\\usage"
webtalk_transmit -clientid 3930322900 -regid "" -xml D:/vik/RTL_design/dsn_verif/examples/shift_register_mem/xsim.dir/work.tb/webtalk/usage_statistics_ext_xsim.xml -html D:/vik/RTL_design/dsn_verif/examples/shift_register_mem/xsim.dir/work.tb/webtalk/usage_statistics_ext_xsim.html -wdm D:/vik/RTL_design/dsn_verif/examples/shift_register_mem/xsim.dir/work.tb/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
