----------------------------------------------------------------
-- Orbotech Ltd. 
-- PCB Division, AOI Department 
-- System(s)      : FUSION
-- Card           : "MVC_2"  
-- Name           : mapping_package.vhd 
-- Author         : Danny Shalom. 
-- Entity description:

-- Version history:
-- Version 1, by Danny Shalom, 1/1/2008 - Initial version.
----------------------------------------------------------------
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.global_package_top.all ;
use work.global_package.all ;
use work.FPGA_DATE.all;


package mapping_package   is   

-- ****************************************************************************
constant    software_version : Integer := 256; 				--1*256 + 0 ;       -- version 1.0
constant 	fpga_time_reg     : integer := conv_integer(FPGA_HOUR & FPGA_MINUTE);
constant 	fpga_date_reg     : integer := conv_integer(FPGA_DAY & FPGA_MONTH & FPGA_YEAR);
-- ****************************************************************************

-- ****************************************************************************
-- MAPPING OF AVALON ADDRESS
-- ****************************************************************************
type        avalon_map_defenition  is  (
        -- version
                GX_algorithm_version_addr,
				MVC_Compilation_TIME_addr,
				MVC_Compilation_DATE_addr,
                software_version_addr,
                machine_addr,
                card_id_addr,
        -- global timing and control
                start_of_scan,
                    start_of_scan_flag,
                    start_of_panel_flag,
                software_reset,
                	application_reset,
                	SDRAM_reset,
                	seriallit_reset,
                error_register,
                error_register_2,
                master_card_select,
        -- y_pixel_generator            
                y_pixel_acceleration_length,                
                y_pixel_y_start_point,                      
                y_pixel_envelope_y_length,                  
                y_pixel_IT_minimum,                         
                y_pixel_AT_time_image,
                y_pixel_synthetic_ENCODER_time,             
                y_pixel_max_error_drift,                    
                y_pixel_K1_lpf_coefficient,                 
                y_pixel_K2_position_coefficient,            
                y_pixel_D_resolution_coefficient,       
                y_pixel_M_resolution_coefficient,       
                y_pixel_resolution_coefficient,         
                y_pixel_max_position_jitter_allowed,    
                y_pixel_follower_enable, 
                y_pixel_follower_start_address,               
                y_pixel_synthetic_IT_mode,              
                y_pixel_filter_bypass,                  
                y_pixel_drift_correction_bypass,        
                y_pixel_table_movement_bypass, 
                y_pixel_exposure_error,         
                y_pixel_drift_error,
                y_pixel_ligth_to_AT_delay,        
                y_pixel_drift_error_y_location,
                y_pixel_number_of_modalities,
                y_pixel_AT_inverter,
                follower_counter,  
                y_pixel_encoder_counter,
                y_pixel_real_minimum_IT,
                y_pixel_real_maximum_IT,
                y_pixel_minimum_T_encoder, 
                y_pixel_filter_size,    
        -- RS232 to camera
                RS232_data_write,
                RS232_data_read,
                RS232_command,
                    RS232_baud_rate,
                    RS232_error_reset,
                RS232_status,
                    rs232_receive_fifo_used,
                    rs232_transmit_fifo_used,
                    rs232_receive_fifo_full,
                    rs232_transmit_fifo_full,
                    rs232_camera_exist,
        -- Camera Interface
                start_pixel_report_application,
                end_pixel_report_application,
                camera_length_application,
                cam_diagnostics_select,
                camera_report_region_error,
        -- camera emulator
                emulator_image_start_address,
                emulator_picture_start_point,
                emulator_picture_x_length,
                emulator_picture_y_length,
                camera_emulator_select_mode,
        -- Compensation
--              compensation_table_start_address,
--              compensation_memory_select,
--              compensation_error,
--              compensation_bypass,
--              compensation_conv_lut_image,
        -- Blurring Y
                blurY_line1_coefficient_value_even,
                blurY_line2_coefficient_value_even,
                blurY_line3_coefficient_value_even,
                blurY_line1_coefficient_value_odd,
                blurY_line2_coefficient_value_odd,
                blurY_line3_coefficient_value_odd,
        -- resampling
                resampling_resolution_select,
                resampling_coefficients_table,
        -- Edge detector DOG 1
                DOG_1_gauss_select,
                    DOG_1_gauss_select_narrow,                                        
                    DOG_1_gauss_select_wide,
                DOG_1_high_sure,
                DOG_1_low_sure,                                        
        -- cell filter 1
				CF_1_config_reg,
                	CF_1_cel_filter_exist,
        			CF_1_matrix_type,
                CF_1_high_grad_sure,
                CF_1_low_grad_sure,
                CF_1_neg_grad_thresh,
                CF_1_pos_grad_thresh,
        -- Edge detector DOG 2
                DOG_2_gauss_select,
                    DOG_2_gauss_select_narrow,                                        
                    DOG_2_gauss_select_wide,
                DOG_2_high_sure,
                DOG_2_low_sure,                                        
        -- cell filter 2
				CF_2_config_reg,
                	CF_2_cel_filter_exist,
        			CF_2_matrix_type,
                CF_2_high_grad_sure,
                CF_2_low_grad_sure,
                CF_2_neg_grad_thresh,
                CF_2_pos_grad_thresh,
        -- SDD calculation 1
                SDD_1_threshold,
                SDD_1_lut_diff_decode_0,
                    SDD_1_lut_diff_0_vector_0,                                      
                    SDD_1_lut_diff_0_vector_135,                                      
                    SDD_1_lut_diff_0_vector_90,                                      
                    SDD_1_lut_diff_0_vector_45,                                      
                SDD_1_lut_diff_decode_1,
                    SDD_1_lut_diff_1_vector_0,                                      
                    SDD_1_lut_diff_1_vector_135,                                      
                    SDD_1_lut_diff_1_vector_90,                                      
                    SDD_1_lut_diff_1_vector_45,
                SDD_1_lut_half_type,
                    SDD_1_lut_half_type_vector_0,                                     
                    SDD_1_lut_half_type_vector_135,                                     
                    SDD_1_lut_half_type_vector_90,                                     
                    SDD_1_lut_half_type_vector_45,                                     
                SDD_1_lut_type,
                    SDD_1_lut_type_vector_0,                                     
                    SDD_1_lut_type_vector_135,                                     
                    SDD_1_lut_type_vector_90,                                     
                    SDD_1_lut_type_vector_45,
                SDD_1_lut_union,
                    SDD_1_lut_union_detect_0,                           
                    SDD_1_lut_union_detect_1,
                    SDD_1_lut_union_detect_2,
                SDD_1_lut_range_enable,
                    SDD_1_lut_range_enable_detect_0,                          
                    SDD_1_lut_range_enable_detect_1,
                    SDD_1_lut_range_enable_detect_2,
                SDD_1_lut_strength,
                    SDD_1_lut_strength_detect_0,                         
                    SDD_1_lut_strength_detect_1,                         
                    SDD_1_lut_strength_detect_2,                         
        -- SDD filter 1
                SDD_1_filter_map_table,
                    SDD_1_filter_map_table_1,
                    SDD_1_filter_map_table_2,
                    SDD_1_filter_map_table_3,
                SDD_1_filter_ch1,
                    SDD_1_filter_weighted_sum_TH_ch1,
                    SDD_1_filter_rep_num_TH_ch1,
                SDD_1_filter_ch2,
                    SDD_1_filter_weighted_sum_TH_ch2,
                    SDD_1_filter_rep_num_TH_ch2,
                SDD_1_filter_ch3,
                    SDD_1_filter_weighted_sum_TH_ch3,
                    SDD_1_filter_rep_num_TH_ch3,
                SDD_1_filter_bin_table_1,
                SDD_1_filter_bin_table_2,
                SDD_1_filter_bin_table_3,
        -- SDD calculation 2
                SDD_2_threshold,
                SDD_2_lut_diff_decode_0,
                    SDD_2_lut_diff_0_vector_0,                                      
                    SDD_2_lut_diff_0_vector_135,                                      
                    SDD_2_lut_diff_0_vector_90,                                      
                    SDD_2_lut_diff_0_vector_45,                                      
                SDD_2_lut_diff_decode_1,
                    SDD_2_lut_diff_1_vector_0,                                      
                    SDD_2_lut_diff_1_vector_135,                                      
                    SDD_2_lut_diff_1_vector_90,                                      
                    SDD_2_lut_diff_1_vector_45,
                SDD_2_lut_half_type,
                    SDD_2_lut_half_type_vector_0,                                     
                    SDD_2_lut_half_type_vector_135,                                     
                    SDD_2_lut_half_type_vector_90,                                     
                    SDD_2_lut_half_type_vector_45,                                     
                SDD_2_lut_type,
                    SDD_2_lut_type_vector_0,                                     
                    SDD_2_lut_type_vector_135,                                     
                    SDD_2_lut_type_vector_90,                                     
                    SDD_2_lut_type_vector_45,
                SDD_2_lut_union,
                    SDD_2_lut_union_detect_0,                           
                    SDD_2_lut_union_detect_1,
                    SDD_2_lut_union_detect_2,
                SDD_2_lut_range_enable,
                    SDD_2_lut_range_enable_detect_0,                          
                    SDD_2_lut_range_enable_detect_1,
                    SDD_2_lut_range_enable_detect_2,
                SDD_2_lut_strength,
                    SDD_2_lut_strength_detect_0,                         
                    SDD_2_lut_strength_detect_1,                         
                    SDD_2_lut_strength_detect_2,                         
        -- SDD filter 2
                SDD_2_filter_map_table,
                    SDD_2_filter_map_table_1,
                    SDD_2_filter_map_table_2,
                    SDD_2_filter_map_table_3,
                SDD_2_filter_ch1,
                    SDD_2_filter_weighted_sum_TH_ch1,
                    SDD_2_filter_rep_num_TH_ch1,
                SDD_2_filter_ch2,
                    SDD_2_filter_weighted_sum_TH_ch2,
                    SDD_2_filter_rep_num_TH_ch2,
                SDD_2_filter_ch3,
                    SDD_2_filter_weighted_sum_TH_ch3,
                    SDD_2_filter_rep_num_TH_ch3,
                SDD_2_filter_bin_table_1,
                SDD_2_filter_bin_table_2,
                SDD_2_filter_bin_table_3,
        -- Black Spots
                black_spots_high_threshold,
                black_spots_low_threshold,
                black_spots_conductor_threshold,
                black_spots_cluster,
                black_spots_report_limit,
                black_spot_overflow,
        -- Blind Via
                Blind_Via_laserdrill_en,
                Blind_Via_config_C, 
                Blind_Via_config_3, 
                Blind_Via_config_5, 
                Blind_Via_config_7, 
                Blind_Via_config_9, 
                Blind_Via_TH0_min_a,
                Blind_Via_TH0_max_a,
                Blind_Via_TH1_min_a,
                Blind_Via_TH1_max_a,
                Blind_Via_TH2_min_a,
                Blind_Via_TH2_max_a,
                Blind_Via_TH3_min_a,
                Blind_Via_TH3_max_a,
                Blind_Via_TH4_min_a,
                Blind_Via_ratio_3_a,
                Blind_Via_ratio_5_a,
                Blind_Via_ratio_7_a,
                Blind_Via_ratio_9_a,
                Blind_Via_TH0_min_b,
                Blind_Via_TH0_max_b,
                Blind_Via_TH1_min_b,
                Blind_Via_TH1_max_b,
                Blind_Via_TH2_min_b,
                Blind_Via_TH2_max_b,
                Blind_Via_TH3_min_b,
                Blind_Via_TH3_max_b,
                Blind_Via_TH4_min_b,
                Blind_Via_ratio_3_b,
                Blind_Via_ratio_5_b,
                Blind_Via_ratio_7_b,
                Blind_Via_ratio_9_b,
        -- organized_gray_picture
                enable_gray_pict_DMA,
                enable_gray_header,
	                enable_gray_header_bit,
	                enable_gray_checksum_bit,
                gray_pict_DMA_overflow,
        -- reports
                enable_reports_1,
                    report_enable_CEL_1,
                    report_enable_SDD_1,
                enable_reports_2,
                    report_enable_CEL_2,
                    report_enable_SDD_2,
                report_CEL_buffer_usage,
                report_SDD_buffer_usage,
                reports_offset_X,
         -- DMA_TX
                tx_dma_1_control_reg,
                    tx_dma_1_start_ch,
                    tx_dma_1_address_is_64,
                    tx_dma_1_test_en,
                    tx_dma_1_end_of_report_latch,
                    tx_dma_1_no_rolling_buffer,
                tx_dma_1_first_pointer_address, 
                tx_dma_1_no_of_pointers,            
                tx_dma_1_pointer_used,          
                tx_dma_1_place_in_sector,
                tx_dma_1_words_counter, 
                tx_dma_1_interrupt_reg,
                    tx_dma_1_EOB_int_en,
                    tx_dma_1_EOR_int_en,
                tx_dma_1_fifo_usage_counter,
			--
                tx_dma_2_control_reg,
                    tx_dma_2_start_ch,
                    tx_dma_2_address_is_64,
                    tx_dma_2_test_en,
                    tx_dma_2_end_of_report_latch,
                    tx_dma_2_no_rolling_buffer,
                tx_dma_2_first_pointer_address, 
                tx_dma_2_no_of_pointers,            
                tx_dma_2_pointer_used,          
                tx_dma_2_place_in_sector,
                tx_dma_2_words_counter,
                tx_dma_2_interrupt_reg, 
                    tx_dma_2_EOB_int_en,
                    tx_dma_2_EOR_int_en,
                tx_dma_2_fifo_usage_counter,
			--
                tx_dma_3_control_reg,
                    tx_dma_3_start_ch,
                    tx_dma_3_address_is_64,
                    tx_dma_3_test_en,
                    tx_dma_3_end_of_report_latch,
                    tx_dma_3_no_rolling_buffer,
                tx_dma_3_first_pointer_address, 
                tx_dma_3_no_of_pointers,            
                tx_dma_3_pointer_used,          
                tx_dma_3_place_in_sector,
                tx_dma_3_words_counter, 
                tx_dma_3_interrupt_reg, 
                    tx_dma_3_EOB_int_en,
                    tx_dma_3_EOR_int_en,
                tx_dma_3_fifo_usage_counter,
			--
                tx_dma_4_control_reg,
                    tx_dma_4_start_ch,
                    tx_dma_4_address_is_64,
                    tx_dma_4_test_en,
                    tx_dma_4_end_of_report_latch,
                    tx_dma_4_no_rolling_buffer,
                tx_dma_4_first_pointer_address, 
                tx_dma_4_no_of_pointers,            
                tx_dma_4_pointer_used,          
                tx_dma_4_place_in_sector,
                tx_dma_4_words_counter, 
                tx_dma_4_interrupt_reg, 
                    tx_dma_4_EOB_int_en,
                    tx_dma_4_EOR_int_en,
                tx_dma_4_fifo_usage_counter,
			--
                tx_dma_5_control_reg,
                    tx_dma_5_start_ch,
                    tx_dma_5_address_is_64,
                    tx_dma_5_test_en,
                    tx_dma_5_end_of_report_latch,
                    tx_dma_5_no_rolling_buffer,
                tx_dma_5_first_pointer_address, 
                tx_dma_5_no_of_pointers,            
                tx_dma_5_pointer_used,          
                tx_dma_5_place_in_sector,
                tx_dma_5_words_counter,
                tx_dma_5_interrupt_reg,
                    tx_dma_5_EOB_int_en,
                    tx_dma_5_EOR_int_en,
                tx_dma_5_fifo_usage_counter,
			--
                tx_dma_6_control_reg,
                    tx_dma_6_start_ch,
                    tx_dma_6_address_is_64,
                    tx_dma_6_test_en,
                    tx_dma_6_end_of_report_latch,
                    tx_dma_6_no_rolling_buffer,
                tx_dma_6_first_pointer_address, 
                tx_dma_6_no_of_pointers,            
                tx_dma_6_pointer_used,          
                tx_dma_6_place_in_sector,
                tx_dma_6_words_counter, 
                tx_dma_6_interrupt_reg,
                    tx_dma_6_EOB_int_en,
                    tx_dma_6_EOR_int_en,
                tx_dma_6_fifo_usage_counter,
			--
                tx_dma_7_control_reg,
                    tx_dma_7_start_ch,
                    tx_dma_7_address_is_64,
                    tx_dma_7_test_en,
                    tx_dma_7_end_of_report_latch,
                    tx_dma_7_no_rolling_buffer,
                tx_dma_7_first_pointer_address, 
                tx_dma_7_no_of_pointers,            
                tx_dma_7_pointer_used,          
                tx_dma_7_place_in_sector,
                tx_dma_7_words_counter, 
                tx_dma_7_interrupt_reg,
                    tx_dma_7_EOB_int_en,
                    tx_dma_7_EOR_int_en,
                tx_dma_7_fifo_usage_counter,
			--
                tx_dma_8_control_reg,
                    tx_dma_8_start_ch,
                    tx_dma_8_address_is_64,
                    tx_dma_8_test_en,
                    tx_dma_8_end_of_report_latch,
                    tx_dma_8_no_rolling_buffer,
                tx_dma_8_first_pointer_address, 
                tx_dma_8_no_of_pointers,            
                tx_dma_8_pointer_used,          
                tx_dma_8_place_in_sector,
                tx_dma_8_words_counter,
                tx_dma_8_interrupt_reg, 
                    tx_dma_8_EOB_int_en,
                    tx_dma_8_EOR_int_en,
                tx_dma_8_fifo_usage_counter,			
        --MSI 
                interrupt_control_reg,
                interrupt_control_status,
                PCIE_ready_utilization,
                PCIE_dma_utilization,
        -- DMA test channel
                DMA_test_data_length,
                DMA_test_data_reset,
                DMA_test_utilization_1,
                DMA_test_utilization_2,
                DMA_test_utilization_3,
                DMA_test_utilization_4,
                DMA_test_utilization_5,
                DMA_test_utilization_6,
                DMA_test_utilization_7,
                DMA_test_utilization_8,
                PCIE_capability,
        -- FPGA temperature monitor
--                alert_threshold,
                GX_temperature,
                temperature_alert,
                    temperature_alert_bit,
                    temperature_fan_on,
		-- test clock for stp
				stp_clock_select,
        -- CRC check
                crc_read_1,
                crc_read_2,
                crc_read_3,
                crc_read_4,
                crc_read_5,
                crc_read_6,
                crc_read_7,
                crc_read_8,
                crc_read_9,
                crc_read_10,
                crc_read_11,
                crc_read_12,
        -- memory address counter
                memory_address_select,
                drv_memory_address_select,
        -- SDRAM port
                nios_sram,
                drv_nios_sram,
                multi_port_A_select,
                start_follower_address,
                start_emulator_red_address,
                start_emulator_blue_address,
                start_emulator_green_address,
                multi_port_error_reg,
        -- SDRAM bist
                sdram_bist_A_enable,
                sdram_bist_A_status,
                    sdram_bist_A_is_running,
                    sdram_bist_A_pass,
                    sdram_bist_A_fail,
                sdram_bist_A_fail_add,
			--
                sdram_bist_B_enable,
                sdram_bist_B_status,
                    sdram_bist_B_is_running,
                    sdram_bist_B_pass,
                    sdram_bist_B_fail,
                sdram_bist_B_fail_add,
			--
                sdram_bist_C_enable,
                sdram_bist_C_status,
                    sdram_bist_C_is_running,
                    sdram_bist_C_pass,
                    sdram_bist_C_fail,
                sdram_bist_C_fail_add, 
        -- Remote Update
                RU_aval_data,
                RU_aval_param,
                RU_aval_cmd,
                RU_aval_status,
                RU_update_error,
                RU_SFL_add,
                RU_SFL_cmd,
                RU_SFL_status,
				RU_SFL_data_wr,
                RU_SFL_data_rd,         
        -- IPP
                IPP_status,
        -- DATA LOGGER
        		events_history_reset,
        		events_history_start_address,
        		events_history_size,
        		events_history_pointer,            
        -- GPIO select
        		encoder_input_select,
        -- 4LS camera
                Carmel_algorithm_version,
				Carmel_Compilation_TIME_addr,
				Carmel_Compilation_DATE_addr,
				Carmel_software_reset,
                Carmel_control,              
					Carmel_number_of_modalities,     
					Carmel_TDI_mode,     
					Carmel_TDI_active_lines_red,     
					Carmel_TDI_active_lines_blue,     
                Carmel_status,        
					Carmel_lvds_data_aligned,
					Carmel_seriallite_link_up_rx,
					Carmel_seriallite_link_up_tx,
				Carmel_error_register,
				Carmel_memory_address_select,
                Carmel_sensor_address,
					Carmel_sensor_reg_add,
					Carmel_sensor_n_cs,
				Carmel_sensor_data,
				Carmel_sensor_register_setup_done,
				Carmel_IPP_status,
                Carmel_comp_red_line_1,     
                Carmel_comp_red_line_2,     
                Carmel_comp_red_line_3,     
                Carmel_comp_red_line_4,     
                Carmel_comp_blue_line_1,     
                Carmel_comp_blue_line_2,     
                Carmel_comp_blue_line_3,     
                Carmel_comp_blue_line_4,     
                Carmel_comp_bypass,     
                Carmel_conv_lut_image_red,
                Carmel_conv_lut_image_blue,
				Carmel_test_pattern,
					Carmel_enable_tpgn,
					Carmel_enable_tpgn_line_numbers,
				Carmel_FPGA_temperature,
				Carmel_board_temperature,
				Carmel_board_temperature_max,
				Carmel_sensor_temperature,
				Carmel_sensor_temperature_max,
				Carmel_temperature_alert,
                    Carmel_FPGA_temperature_alert,     
                    Carmel_board_temperature_alert,    
                    Carmel_sensor_temperature_alert,   
                Carmel_RU_aval_data,
                Carmel_RU_aval_param,
                Carmel_RU_aval_cmd,
                Carmel_RU_aval_status,
                Carmel_RU_SFL_add,
                Carmel_RU_SFL_cmd,
                Carmel_RU_SFL_status,
				Carmel_RU_SFL_data_wr,
                Carmel_RU_SFL_data_rd,         
                Carmel_RU_update_error,
				Carmel_test_register,
        -- DEBUG
        		test_register_1,             
        		test_register_2,             
        		test_register_3, 
        		test_register_4, 
        		test_register_5, 
        		test_register_6, 
        		test_register_7, 
        		test_register_8, 
        		max_image_lines_in_buffer,
        -- last
                last_deff) ;    -- last_deff must be the last in the list.


constant  number_of_fields  : integer := avalon_map_defenition'pos(last_deff) ;

type        RW_type         is (RD,     -- for read port
                                WR,     -- for write port
                                RD_WR,  -- for read and write port
                                FIELD); -- for field definition in previous port

type        fpga_type       is (A,B,C,D,E,G,AG,ABC,ABCG) ;
                            -- A for RED channel, B for BLUE channel, C for GREEN channel, D for Driver, G for GLOBAL

type        field_type          is record
                            name    : avalon_map_defenition ;
                            address : integer range 0 to 2**avalon_addr_bits-1 ;
                            MAIS    : integer range 0 to 4 ; -- Memory Address Increment Step
                            lsb     : integer ;
                            msb     : integer ;
                            f_type  : RW_type ;
                            fpga    : fpga_type ;
                            init    : integer ;             -- value after reset
                            end record ;


type        fields_table_type   is array(1 to number_of_fields) of field_type ;

-- Software address is [FPGA_offset + ADDRESS * 8]
-- FPGA_offset = 0 for D, 8192 for G, 16384 for A, 24576 for B, 32768 for C, 40960 for E

constant    avalon_fields_table     : fields_table_type :=  (
--               field name or port name                ,ADDRESS,MAIS,LSB,MSB, TYPE , FPGA,INIT
        -- version
                (GX_algorithm_version_addr              ,       1,  0,  0, 31, RD   , G   ,algorithm_version),   -- version = 1.0
                (software_version_addr                  ,       2,  0,  0, 15, RD   , G   ,software_version),
                (MVC_Compilation_TIME_addr              ,     490,  0,  0, 31, RD   , G   ,fpga_time_reg), 
				(MVC_Compilation_DATE_addr				,     491,  0,  0, 31, RD   , G   ,fpga_date_reg),
                (machine_addr                           ,       3,  0,  0, 15, RD   , G   ,   1),
                (card_id_addr                           ,       4,  0,  0, 31, RD   , G   ,   0),
        -- global timing and control
                (start_of_scan                          ,       6,  0,  0,  1, RD_WR, G   ,   0),
                    (start_of_scan_flag                 ,       6,  0,  0,  0, FIELD, G   ,   0),
                    (start_of_panel_flag                ,       6,  0,  1,  1, FIELD, G   ,   0),
                (software_reset                         ,       7,  0,  0,  2, WR   , G   ,   0),
                	(application_reset					,		7,  0,  0,  0, FIELD, G   ,   0),
                	(SDRAM_reset						,		7,  0,  1,  1, FIELD, G   ,   0),
                	(seriallit_reset					,		7,  0,  2,  2, FIELD, G   ,   0),
                (error_register                         ,       8,  0,  0, 31, RD   , G   ,   0),
                (error_register_2                       ,     492,  0,  0, 31, RD   , G   ,   0),
                (master_card_select						,	   15,  0,  0,  1, RD_WR, G   ,   0),           
         -- y_pixel_generator           
                (y_pixel_acceleration_length            ,       9,  0,  0, 15, RD_WR, G   ,  32), 
                (y_pixel_y_start_point                  ,      10,  0,  0, 19, RD_WR, G   ,  48), 
                (y_pixel_envelope_y_length              ,      11,  0,  0, 19, RD_WR, G   ,3000), 
                (y_pixel_IT_minimum                     ,      12,  0,  0, 15, RD_WR, G   , 560),
                (y_pixel_AT_time_image                  ,      13,  0,  0, 15, RD_WR, ABCG, 400),
                (y_pixel_synthetic_ENCODER_time         ,      14,  0,  0, 15, RD_WR, G   , 600),
                (y_pixel_max_error_drift                ,      17,  0,  0,  6, RD_WR, G   ,   3),
                (y_pixel_K1_lpf_coefficient             ,      18,  0,  0,  9, RD_WR, G   , 102),
                (y_pixel_K2_position_coefficient        ,      19,  0,  0, 15, RD_WR, G   ,  66),
                (y_pixel_D_resolution_coefficient       ,      20,  0,  0,  9, RD_WR, G   ,   1),
                (y_pixel_M_resolution_coefficient       ,      21,  0,  0,  9, RD_WR, G   ,   5),
                (y_pixel_resolution_coefficient         ,      23,  0,  0, 17, RD_WR, G   ,5120),
                (y_pixel_max_position_jitter_allowed    ,      24,  0,  0,  5, RD_WR, G   ,   0),
                (y_pixel_follower_enable                ,      25,  0,  0,  0, RD_WR, G   ,   1),
                (y_pixel_follower_start_address         ,      16,  0,  0, 31, RD   , G   ,   0),
                (y_pixel_synthetic_IT_mode              ,      26,  0,  0,  0, RD_WR, G   ,   0),                                              
                (y_pixel_filter_bypass                  ,      27,  0,  0,  0, RD_WR, G   ,   0),                                          
                (y_pixel_drift_correction_bypass        ,      28,  0,  0,  0, RD_WR, G   ,   1),                                          
                (y_pixel_table_movement_bypass          ,      29,  0,  0,  0, RD_WR, G   ,   0),
                (y_pixel_exposure_error                 ,      30,  0,  0,  0, RD   , G   ,   0),
                (y_pixel_drift_error                    ,      31,  0,  0,  0, RD   , G   ,   0),
                (y_pixel_ligth_to_AT_delay              ,      32,  0,  0,  8, RD_WR, G   ,   1),
                (y_pixel_drift_error_y_location         ,      33,  0,  0, 24, RD   , G   ,   0),
                (y_pixel_number_of_modalities           ,      34,  0,  0,  1, RD_WR, G   ,   3),
                (y_pixel_AT_inverter                    ,      35,  0,  0,  0, RD_WR, G   ,   0),
                (follower_counter                       ,      36,  0,  0, 25, RD   , G   ,   0),
                (y_pixel_encoder_counter				,	   37,  0,  0, 23, RD   , G   ,   0),
                (y_pixel_real_minimum_IT				,	   38,  0,  0, 13, RD   , G   ,   0),
                (y_pixel_real_maximum_IT				,	   39,  0,  0, 13, RD   , G   ,   0),     
                (y_pixel_minimum_T_encoder				,      44,  0,  0, 15, RD   , G   ,   0),
                (y_pixel_filter_size                    ,      45,  0,  0,  4, RD_WR, G   ,  10),
        -- RS232 to camera
                (RS232_data_write                       ,      40,  0,  0,  7, WR   , G   ,   0),
                (RS232_data_read                        ,      41,  0,  0,  7, RD   , G   ,   0), 
                (RS232_command                          ,      42,  0,  0,  3, RD_WR, G   ,   0),
                    (RS232_baud_rate                    ,      42,  0,  1,  3, FIELD, G   ,   0),
                    (RS232_error_reset                  ,      42,  0,  0,  0, FIELD, G   ,   0),
                (RS232_status                           ,      43,  0,  0, 13, RD   , G   ,   0),
                    (rs232_receive_fifo_used            ,      43,  0,  0,  7, FIELD, G   ,   0),
                    (rs232_transmit_fifo_used           ,      43,  0,  8, 13, FIELD, G   ,   0),
                    (rs232_transmit_fifo_full           ,      43,  0, 14, 14, FIELD, G   ,   0),
                    (rs232_receive_fifo_full            ,      43,  0, 15, 15, FIELD, G   ,   0),
                    (rs232_camera_exist                 ,      43,  0, 17, 16, FIELD, G   ,   0),
        -- Camera Interface
                (start_pixel_report_application         ,      50,  0,  0, 13, RD_WR, G   ,   0),
                (end_pixel_report_application           ,      51,  0,  0, 13, RD_WR, G   , 16367),
                (camera_length_application              ,      52,  0,  0, 15, RD   , G   ,   0),
                (cam_diagnostics_select                 ,      53,  0,  0,  0, RD_WR, G   ,   0),
                (camera_report_region_error             ,      54,  0,  0,  7, RD   , G   ,   0), 
        -- camera emulator
        		(emulator_image_start_address           ,      55,  0,  0, 31, RD   , ABC ,   0),
                (emulator_picture_start_point           ,      56,  0,  0, 13, RD_WR, G   ,   8),
                (emulator_picture_x_length              ,      57,  0,  0, 14, RD_WR, G   , 4096),
                (emulator_picture_y_length              ,      58,  0,  0, 14, RD_WR, G   , 3000),
                (camera_emulator_select_mode            ,      59,  0,  0,  1, RD_WR, G   ,   0),
        -- Compensation
--              (compensation_table_start_address       ,      60,  0,  0, 31, RD   , ABC ,   0),
--              (compensation_memory_select				,      86,  4,  0, 31, RD_WR, ABC ,   0),
--              (compensation_error                     ,      61,  0,  0,  3, RD   , ABC ,   0),
--              (compensation_bypass                    ,      62,  0,  0,  0, RD_WR, ABCG,   1),
--              (compensation_conv_lut_image            ,      63,  1,  0,  7, RD_WR, ABCG,   0),
		-- Blurring Y
                (blurY_line1_coefficient_value_even     ,      64,  0,  0,  8, RD_WR, ABCG,   0),
                (blurY_line2_coefficient_value_even     ,      65,  0,  0,  8, RD_WR, ABCG, 128), -- resolution is 1/128
                (blurY_line3_coefficient_value_even     ,      66,  0,  0,  8, RD_WR, ABCG,   0),
                (blurY_line1_coefficient_value_odd      ,      67,  0,  0,  8, RD_WR, ABCG,   0),
                (blurY_line2_coefficient_value_odd      ,      68,  0,  0,  8, RD_WR, ABCG, 128), -- resolution is 1/128
                (blurY_line3_coefficient_value_odd      ,      69,  0,  0,  8, RD_WR, ABCG,   0),
        -- resampling
                (resampling_resolution_select           ,      70,  0,  0,  4, RD_WR, G   ,   0),
                (resampling_coefficients_table          ,      71,  2,  0, 11, RD_WR, ABCG,   0),
        -- Edge detector DOG 1
                (DOG_1_gauss_select                     ,      72,  0,  0,  2, RD_WR, ABCG,   0),
                    (DOG_1_gauss_select_narrow          ,      72,  0,  0,  0, FIELD, ABCG,   0),                                        
                    (DOG_1_gauss_select_wide            ,      72,  0,  1,  2, FIELD, ABCG,   0),
                (DOG_1_high_sure                        ,      73,  0,  0,  7, RD_WR, ABCG,  80),
                (DOG_1_low_sure                         ,      74,  0,  0,  7, RD_WR, ABCG,  80),                                        
        -- cell filter 1
				(CF_1_config_reg						,      75,  0,  0,  1, RD_WR, ABCG,   0),
                	(CF_1_cel_filter_exist				,      75,  0,  0,  0, FIELD, ABCG,   0),
        			(CF_1_matrix_type					,      75,  0,  1,  1, FIELD, ABCG,   0),
                (CF_1_high_grad_sure                    ,      76,  0,  0,  7, RD_WR, ABCG,   0),
                (CF_1_low_grad_sure                     ,      77,  0,  0,  7, RD_WR, ABCG,   0),
                (CF_1_neg_grad_thresh                   ,      78,  0,  0,  7, RD_WR, ABCG,   0),
                (CF_1_pos_grad_thresh                   ,      79,  0,  0,  7, RD_WR, ABCG,   0),
        -- Edge detector DOG 2
                (DOG_2_gauss_select                     ,     190,  0,  0,  2, RD_WR, A   ,   0),
                    (DOG_2_gauss_select_narrow          ,     190,  0,  0,  0, FIELD, A   ,   0),                                        
                    (DOG_2_gauss_select_wide            ,     190,  0,  1,  2, FIELD, A   ,   0),
                (DOG_2_high_sure                        ,     191,  0,  0,  7, RD_WR, A   ,  80),
                (DOG_2_low_sure                         ,     192,  0,  0,  7, RD_WR, A   ,  80),                                        
        -- cell filter 2
				(CF_2_config_reg						,     193,  0,  0,  1, RD_WR, A   ,   0),
                	(CF_2_cel_filter_exist				,     193,  0,  0,  0, FIELD, A   ,   0),
        			(CF_2_matrix_type					,     193,  0,  1,  1, FIELD, A   ,   0),
                (CF_2_high_grad_sure                    ,     194,  0,  0,  7, RD_WR, A   ,   0),
                (CF_2_low_grad_sure                     ,     195,  0,  0,  7, RD_WR, A   ,   0),
                (CF_2_neg_grad_thresh                   ,     196,  0,  0,  7, RD_WR, A   ,   0),
                (CF_2_pos_grad_thresh                   ,     197,  0,  0,  7, RD_WR, A   ,   0),
        -- SDD calculation 1
                (SDD_1_threshold                        ,     200,  0,  0,  7, RD_WR, ABCG,  80),
                (SDD_1_lut_diff_decode_0                ,     201,  4,  0, 19, RD_WR, ABCG,   0),   -- LUT 1K
                    (SDD_1_lut_diff_0_vector_0          ,     201,  4,  0,  4, FIELD, ABCG,   0),                                      
                    (SDD_1_lut_diff_0_vector_135        ,     201,  4,  5,  9, FIELD, ABCG,   0),                                      
                    (SDD_1_lut_diff_0_vector_90         ,     201,  4, 10, 14, FIELD, ABCG,   0),                                      
                    (SDD_1_lut_diff_0_vector_45         ,     201,  4, 15, 19, FIELD, ABCG,   0),                                      
                (SDD_1_lut_diff_decode_1                ,     202,  4,  0, 19, RD_WR, ABCG,   0),   -- LUT 1K
                    (SDD_1_lut_diff_1_vector_0          ,     202,  4,  0,  4, FIELD, ABCG,   0),                                                
                    (SDD_1_lut_diff_1_vector_135        ,     202,  4,  5,  9, FIELD, ABCG,   0),                                                
                    (SDD_1_lut_diff_1_vector_90         ,     202,  4, 10, 14, FIELD, ABCG,   0),                                                
                    (SDD_1_lut_diff_1_vector_45         ,     202,  4, 15, 19, FIELD, ABCG,   0),          
                (SDD_1_lut_half_type                    ,     203,  4,  0, 19, RD_WR, ABCG,   0),   -- LUT 1K
                    (SDD_1_lut_half_type_vector_0       ,     203,  4,  0,  4, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_half_type_vector_135     ,     203,  4,  5,  9, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_half_type_vector_90      ,     203,  4, 10, 14, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_half_type_vector_45      ,     203,  4, 15, 19, FIELD, ABCG,   0),                                               
                (SDD_1_lut_type                         ,     204,  4,  0, 19, RD_WR, ABCG,   0),   -- LUT 1K
                    (SDD_1_lut_type_vector_0            ,     204,  4,  0,  4, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_type_vector_135          ,     204,  4,  5,  9, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_type_vector_90           ,     204,  4, 10, 14, FIELD, ABCG,   0),                                               
                    (SDD_1_lut_type_vector_45           ,     204,  4, 15, 19, FIELD, ABCG,   0),          
                (SDD_1_lut_union                        ,     205,  1,  0,  8, RD_WR, ABCG,   0),   -- LUT 4K
                    (SDD_1_lut_union_detect_0           ,     205,  1,  0,  2, FIELD, ABCG,   0),                             
                    (SDD_1_lut_union_detect_1           ,     205,  1,  3,  5, FIELD, ABCG,   0),  
                    (SDD_1_lut_union_detect_2           ,     205,  1,  6,  8, FIELD, ABCG,   0),  
                (SDD_1_lut_range_enable                 ,     206,  1,  0,  2, RD_WR, ABCG,   0),   -- LUT 256
                    (SDD_1_lut_range_enable_detect_0    ,     206,  1,  0,  0, FIELD, ABCG,   0),                          
                    (SDD_1_lut_range_enable_detect_1    ,     206,  1,  1,  1, FIELD, ABCG,   0),
                    (SDD_1_lut_range_enable_detect_2    ,     206,  1,  2,  2, FIELD, ABCG,   0),
                (SDD_1_lut_strength                     ,     207,  1,  0,  5, RD_WR, ABCG,   0),   -- LUT 4K   
                    (SDD_1_lut_strength_detect_0        ,     207,  1,  0,  1, FIELD, ABCG,   0),                                         
                    (SDD_1_lut_strength_detect_1        ,     207,  1,  2,  3, FIELD, ABCG,   0),                                         
                    (SDD_1_lut_strength_detect_2        ,     207,  1,  4,  5, FIELD, ABCG,   0),                                         
        -- SDD filter 1
                (SDD_1_filter_map_table                 ,     210,  1,  0,  5, RD_WR, ABCG,   0),   -- LUT 2K
                    (SDD_1_filter_map_table_1           ,     210,  1,  0,  1, FIELD, ABCG,   0),
                    (SDD_1_filter_map_table_2           ,     210,  1,  2,  3, FIELD, ABCG,   0),
                    (SDD_1_filter_map_table_3           ,     210,  1,  4,  5, FIELD, ABCG,   0),
                (SDD_1_filter_ch1                       ,     211,  0,  0,  8, RD_WR, ABCG,   0),  
                    (SDD_1_filter_weighted_sum_TH_ch1   ,     211,  0,  0,  4, FIELD, ABCG,   0), 
                    (SDD_1_filter_rep_num_TH_ch1        ,     211,  0,  5,  8, FIELD, ABCG,   0),
                (SDD_1_filter_ch2                       ,     212,  0,  0,  8, RD_WR, ABCG,   0),
                    (SDD_1_filter_weighted_sum_TH_ch2   ,     212,  0,  0,  4, FIELD, ABCG,   0),
                    (SDD_1_filter_rep_num_TH_ch2        ,     212,  0,  5,  8, FIELD, ABCG,   0),
                (SDD_1_filter_ch3                       ,     213,  0,  0,  8, RD_WR, ABCG,   0),
                    (SDD_1_filter_weighted_sum_TH_ch3   ,     213,  0,  0,  4, FIELD, ABCG,   0),
                    (SDD_1_filter_rep_num_TH_ch3        ,     213,  0,  5,  8, FIELD, ABCG,   0),
                (SDD_1_filter_bin_table_1               ,     214,  0,  0, 15, RD_WR, ABCG,58596),
                (SDD_1_filter_bin_table_2               ,     215,  0,  0, 15, RD_WR, ABCG,58596), 
                (SDD_1_filter_bin_table_3               ,     216,  0,  0, 15, RD_WR, ABCG,58596), 
        -- SDD calculation 2
                (SDD_2_threshold                        ,     217,  0,  0,  7, RD_WR, A   ,  80),
                (SDD_2_lut_diff_decode_0                ,     218,  4,  0, 19, RD_WR, A   ,   0),   -- LUT 1K
                    (SDD_2_lut_diff_0_vector_0          ,     218,  4,  0,  4, FIELD, A   ,   0),                                      
                    (SDD_2_lut_diff_0_vector_135        ,     218,  4,  5,  9, FIELD, A   ,   0),                                      
                    (SDD_2_lut_diff_0_vector_90         ,     218,  4, 10, 14, FIELD, A   ,   0),                                      
                    (SDD_2_lut_diff_0_vector_45         ,     218,  4, 15, 19, FIELD, A   ,   0),                                      
                (SDD_2_lut_diff_decode_1                ,     219,  4,  0, 19, RD_WR, A   ,   0),   -- LUT 1K
                    (SDD_2_lut_diff_1_vector_0          ,     219,  4,  0,  4, FIELD, A   ,   0),                                                
                    (SDD_2_lut_diff_1_vector_135        ,     219,  4,  5,  9, FIELD, A   ,   0),                                                
                    (SDD_2_lut_diff_1_vector_90         ,     219,  4, 10, 14, FIELD, A   ,   0),                                                
                    (SDD_2_lut_diff_1_vector_45         ,     219,  4, 15, 19, FIELD, A   ,   0),          
                (SDD_2_lut_half_type                    ,     220,  4,  0, 19, RD_WR, A   ,   0),   -- LUT 1K
                    (SDD_2_lut_half_type_vector_0       ,     220,  4,  0,  4, FIELD, A   ,   0),                                               
                    (SDD_2_lut_half_type_vector_135     ,     220,  4,  5,  9, FIELD, A   ,   0),                                               
                    (SDD_2_lut_half_type_vector_90      ,     220,  4, 10, 14, FIELD, A   ,   0),                                               
                    (SDD_2_lut_half_type_vector_45      ,     220,  4, 15, 19, FIELD, A   ,   0),                                               
                (SDD_2_lut_type                         ,     221,  4,  0, 19, RD_WR, A   ,   0),   -- LUT 1K
                    (SDD_2_lut_type_vector_0            ,     221,  4,  0,  4, FIELD, A   ,   0),                                               
                    (SDD_2_lut_type_vector_135          ,     221,  4,  5,  9, FIELD, A   ,   0),                                               
                    (SDD_2_lut_type_vector_90           ,     221,  4, 10, 14, FIELD, A   ,   0),                                               
                    (SDD_2_lut_type_vector_45           ,     221,  4, 15, 19, FIELD, A   ,   0),          
                (SDD_2_lut_union                        ,     222,  1,  0,  8, RD_WR, A   ,   0),   -- LUT 4K
                    (SDD_2_lut_union_detect_0           ,     222,  1,  0,  2, FIELD, A   ,   0),                             
                    (SDD_2_lut_union_detect_1           ,     222,  1,  3,  5, FIELD, A   ,   0),  
                    (SDD_2_lut_union_detect_2           ,     222,  1,  6,  8, FIELD, A   ,   0),  
                (SDD_2_lut_range_enable                 ,     223,  1,  0,  2, RD_WR, A   ,   0),   -- LUT 256
                    (SDD_2_lut_range_enable_detect_0    ,     223,  1,  0,  0, FIELD, A   ,   0),                          
                    (SDD_2_lut_range_enable_detect_1    ,     223,  1,  1,  1, FIELD, A   ,   0),
                    (SDD_2_lut_range_enable_detect_2    ,     223,  1,  2,  2, FIELD, A   ,   0),
                (SDD_2_lut_strength                     ,     224,  1,  0,  5, RD_WR, A   ,   0),   -- LUT 4K   
                    (SDD_2_lut_strength_detect_0        ,     224,  1,  0,  1, FIELD, A   ,   0),                                         
                    (SDD_2_lut_strength_detect_1        ,     224,  1,  2,  3, FIELD, A   ,   0),                                         
                    (SDD_2_lut_strength_detect_2        ,     224,  1,  4,  5, FIELD, A   ,   0),                                         
        -- SDD filter 2
                (SDD_2_filter_map_table                 ,     225,  1,  0,  5, RD_WR, A   ,   0),   -- LUT 2K
                    (SDD_2_filter_map_table_1           ,     225,  1,  0,  1, FIELD, A   ,   0),
                    (SDD_2_filter_map_table_2           ,     225,  1,  2,  3, FIELD, A   ,   0),
                    (SDD_2_filter_map_table_3           ,     225,  1,  4,  5, FIELD, A   ,   0),
                (SDD_2_filter_ch1                       ,     226,  0,  0,  8, RD_WR, A   ,   0),  
                    (SDD_2_filter_weighted_sum_TH_ch1   ,     226,  0,  0,  4, FIELD, A   ,   0), 
                    (SDD_2_filter_rep_num_TH_ch1        ,     226,  0,  5,  8, FIELD, A   ,   0),
                (SDD_2_filter_ch2                       ,     227,  0,  0,  8, RD_WR, A   ,   0),
                    (SDD_2_filter_weighted_sum_TH_ch2   ,     227,  0,  0,  4, FIELD, A   ,   0),
                    (SDD_2_filter_rep_num_TH_ch2        ,     227,  0,  5,  8, FIELD, A   ,   0),
                (SDD_2_filter_ch3                       ,     228,  0,  0,  8, RD_WR, A   ,   0),
                    (SDD_2_filter_weighted_sum_TH_ch3   ,     228,  0,  0,  4, FIELD, A   ,   0),
                    (SDD_2_filter_rep_num_TH_ch3        ,     228,  0,  5,  8, FIELD, A   ,   0),
                (SDD_2_filter_bin_table_1               ,     229,  0,  0, 15, RD_WR, A   ,58596),
                (SDD_2_filter_bin_table_2               ,     230,  0,  0, 15, RD_WR, A   ,58596), 
                (SDD_2_filter_bin_table_3               ,     231,  0,  0, 15, RD_WR, A   ,58596), 
        -- Black Spots
                (black_spots_high_threshold             ,     240,  0,  0,  7, RD_WR, ABCG,    8),
                (black_spots_low_threshold              ,     241,  0,  0,  7, RD_WR, ABCG,    8),
                (black_spots_conductor_threshold        ,     242,  0,  0,  7, RD_WR, ABCG,   20),
                (black_spots_cluster                    ,     243,  0,  0,  3, RD_WR, ABCG,    1),
                (black_spots_report_limit               ,     244,  0,  0, 23, RD_WR, ABCG,    0),
                (black_spot_overflow                    ,     245,  0,  0,  0, RD   , ABC ,    0),
        -- Blind Via
        		(Blind_Via_laserdrill_en				,	  249,  0,  0,  0, RD_WR, ABCG,    0),
                (Blind_Via_config_C                     ,     250,  0,  0,  1, RD_WR, ABCG,    3),   
                (Blind_Via_config_3                     ,     251,  0,  0,  3, RD_WR, ABCG,    3),   
                (Blind_Via_config_5                     ,     252,  0,  0,  3, RD_WR, ABCG,    3),   
                (Blind_Via_config_7                     ,     253,  0,  0,  3, RD_WR, ABCG,    3),   
                (Blind_Via_config_9                     ,     254,  0,  0,  3, RD_WR, ABCG,    3),   
                (Blind_Via_TH0_min_a                    ,     255,  0,  0,  7, RD_WR, ABCG,   35),
                (Blind_Via_TH0_max_a                    ,     256,  0,  0,  7, RD_WR, ABCG,  105),
                (Blind_Via_TH1_min_a                    ,     257,  0,  0,  7, RD_WR, ABCG,   85),
                (Blind_Via_TH1_max_a                    ,     258,  0,  0,  7, RD_WR, ABCG,   95),
                (Blind_Via_TH2_min_a                    ,     259,  0,  0,  7, RD_WR, ABCG,   35),
                (Blind_Via_TH2_max_a                    ,     260,  0,  0,  7, RD_WR, ABCG,   95),
                (Blind_Via_TH3_min_a                    ,     261,  0,  0,  7, RD_WR, ABCG,    5),
                (Blind_Via_TH3_max_a                    ,     262,  0,  0,  7, RD_WR, ABCG,   15),
                (Blind_Via_TH4_min_a                    ,     263,  0,  0,  7, RD_WR, ABCG,    1),
                (Blind_Via_ratio_3_a                    ,     264,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_5_a                    ,     265,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_7_a                    ,     266,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_9_a                    ,     267,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_TH0_min_b                    ,     268,  0,  0,  7, RD_WR, ABCG,   35),
                (Blind_Via_TH0_max_b                    ,     269,  0,  0,  7, RD_WR, ABCG,  105),
                (Blind_Via_TH1_min_b                    ,     270,  0,  0,  7, RD_WR, ABCG,   85),
                (Blind_Via_TH1_max_b                    ,     271,  0,  0,  7, RD_WR, ABCG,   95),
                (Blind_Via_TH2_min_b                    ,     272,  0,  0,  7, RD_WR, ABCG,   35),
                (Blind_Via_TH2_max_b                    ,     273,  0,  0,  7, RD_WR, ABCG,   95),
                (Blind_Via_TH3_min_b                    ,     274,  0,  0,  7, RD_WR, ABCG,    5),
                (Blind_Via_TH3_max_b                    ,     275,  0,  0,  7, RD_WR, ABCG,   15),
                (Blind_Via_TH4_min_b                    ,     276,  0,  0,  7, RD_WR, ABCG,    1),
                (Blind_Via_ratio_3_b                    ,     277,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_5_b                    ,     278,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_7_b                    ,     279,  0,  0,  4, RD_WR, ABCG,    1),
                (Blind_Via_ratio_9_b                    ,     280,  0,  0,  4, RD_WR, ABCG,    1),
        -- organized_gray_picture
                (enable_gray_pict_DMA                   ,     180,  0,  0,  0, RD_WR, ABCG,    0),
                (enable_gray_header                     ,     187,  0,  0,  1, RD_WR, ABCG,    0),
                	(enable_gray_header_bit             ,     187,  0,  0,  0, FIELD, ABCG,    0),
                	(enable_gray_checksum_bit           ,     187,  0,  1,  1, FIELD, ABCG,    0),
                (gray_pict_DMA_overflow                 ,     181,  0,  0,  0, RD   , ABC ,    0),
        -- reports
                (enable_reports_1                       ,     182,  0,  1,  0, RD_WR, ABCG,    3),
                    (report_enable_CEL_1                ,     182,  0,  0,  0, FIELD, ABCG,    1),
                    (report_enable_SDD_1                ,     182,  0,  1,  1, FIELD, ABCG,    1),
                (enable_reports_2                       ,     183,  0,  1,  0, RD_WR, A,       3),
                    (report_enable_CEL_2                ,     183,  0,  0,  0, FIELD, A,       1),
                    (report_enable_SDD_2                ,     183,  0,  1,  1, FIELD, A,       1),
                (report_CEL_buffer_usage                ,     184,  0,  0, 13, RD   , ABC ,    0), 
                (report_SDD_buffer_usage                ,     185,  0,  0, 13, RD   , ABC ,    0),
                (reports_offset_X                       ,     186,  0,  0, 13, RD_WR, G   ,    0),
        -- DMA_TX
                (tx_dma_1_control_reg                   ,      80,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_1_start_ch                  ,      80,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_1_address_is_64             ,      80,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_1_test_en                   ,      80,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_1_end_of_report_latch       ,      80,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_1_no_rolling_buffer         ,      80,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_1_first_pointer_address         ,      81,  0,   0, 19, RD_WR, D   ,  0),
                (tx_dma_1_no_of_pointers                ,      82,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_1_pointer_used                  ,      83,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_1_place_in_sector               ,      84,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_1_words_counter                 ,      85,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_1_interrupt_reg                 ,      400, 0,   0,  1, RD_WR, D   ,  0), 
                    (tx_dma_1_EOB_int_en                ,      400, 0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_1_EOR_int_en                ,      400, 0,   1,  1, FIELD, D   ,  0),
                (tx_dma_1_fifo_usage_counter            ,      408, 0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_2_control_reg                   ,      88,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_2_start_ch                  ,      88,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_2_address_is_64             ,      88,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_2_test_en                   ,      88,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_2_end_of_report_latch       ,      88,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_2_no_rolling_buffer         ,      88,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_2_first_pointer_address         ,      89,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_2_no_of_pointers                ,      90,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_2_pointer_used                  ,      91,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_2_place_in_sector               ,      92,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_2_words_counter                 ,      93,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_2_interrupt_reg                 ,      401, 0,   0,  1, RD_WR, D   ,  0), 
                    (tx_dma_2_EOB_int_en                ,      401, 0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_2_EOR_int_en                ,      401, 0,   1,  1, FIELD, D   ,  0),
                (tx_dma_2_fifo_usage_counter            ,      409, 0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_3_control_reg                   ,      96,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_3_start_ch                  ,      96,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_3_address_is_64             ,      96,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_3_test_en                   ,      96,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_3_end_of_report_latch       ,      96,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_3_no_rolling_buffer         ,      96,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_3_first_pointer_address         ,      97,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_3_no_of_pointers                ,      98,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_3_pointer_used                  ,      99,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_3_place_in_sector               ,     100,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_3_words_counter                 ,     101,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_3_interrupt_reg                 ,     402,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_3_EOB_int_en                ,     402,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_3_EOR_int_en                ,     402,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_3_fifo_usage_counter            ,     410,  0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_4_control_reg                   ,     104,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_4_start_ch                  ,     104,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_4_address_is_64             ,     104,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_4_test_en                   ,     104,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_4_end_of_report_latch       ,     104,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_4_no_rolling_buffer         ,     104,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_4_first_pointer_address         ,     105,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_4_no_of_pointers                ,     106,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_4_pointer_used                  ,     107,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_4_place_in_sector               ,     108,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_4_words_counter                 ,     109,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_4_interrupt_reg                 ,     403,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_4_EOB_int_en                ,     403,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_4_EOR_int_en                ,     403,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_4_fifo_usage_counter            ,     411,  0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_5_control_reg                   ,     112,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_5_start_ch                  ,     112,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_5_address_is_64             ,     112,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_5_test_en                   ,     112,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_5_end_of_report_latch       ,     112,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_5_no_rolling_buffer         ,     112,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_5_first_pointer_address         ,     113,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_5_no_of_pointers                ,     114,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_5_pointer_used                  ,     115,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_5_place_in_sector               ,     116,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_5_words_counter                 ,     117,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_5_interrupt_reg                 ,     404,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_5_EOB_int_en                ,     404,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_5_EOR_int_en                ,     404,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_5_fifo_usage_counter            ,     412,  0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_6_control_reg                   ,     120,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_6_start_ch                  ,     120,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_6_address_is_64             ,     120,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_6_test_en                   ,     120,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_6_end_of_report_latch       ,     120,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_6_no_rolling_buffer         ,     120,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_6_first_pointer_address         ,     121,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_6_no_of_pointers                ,     122,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_6_pointer_used                  ,     123,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_6_place_in_sector               ,     124,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_6_words_counter                 ,     125,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_6_interrupt_reg                 ,     405,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_6_EOB_int_en                ,     405,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_6_EOR_int_en                ,     405,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_6_fifo_usage_counter            ,     413,  0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_7_control_reg                   ,     128,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_7_start_ch                  ,     128,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_7_address_is_64             ,     128,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_7_test_en                   ,     128,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_7_end_of_report_latch       ,     128,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_7_no_rolling_buffer         ,     128,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_7_first_pointer_address         ,     129,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_7_no_of_pointers                ,     130,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_7_pointer_used                  ,     131,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_7_place_in_sector               ,     132,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_7_words_counter                 ,     133,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_7_interrupt_reg                 ,     406,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_7_EOB_int_en                ,     406,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_7_EOR_int_en                ,     406,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_7_fifo_usage_counter            ,     414,  0,   0,  7, RD   , G   ,  0),
--
                (tx_dma_8_control_reg                   ,     136,  0,   0,  5, RD_WR, D   ,  0),  
                    (tx_dma_8_start_ch                  ,     136,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_8_address_is_64             ,     136,  0,   3,  3, FIELD, D   ,  0),
                    (tx_dma_8_test_en                   ,     136,  0,   4,  4, FIELD, D   ,  0),
                    (tx_dma_8_end_of_report_latch       ,     136,  0,   5,  5, FIELD, D   ,  0),
                    (tx_dma_8_no_rolling_buffer         ,     136,  0,   8,  8, FIELD, D   ,  0),
                (tx_dma_8_first_pointer_address         ,     137,  0,   0, 20, RD_WR, D   ,  0),
                (tx_dma_8_no_of_pointers                ,     138,  0,   0, 16, RD_WR, D   ,  0),
                (tx_dma_8_pointer_used                  ,     139,  0,   0, 16, RD   , D   ,  0),  
                (tx_dma_8_place_in_sector               ,     140,  0,   0, 11, RD   , D   ,  0),
                (tx_dma_8_words_counter                 ,     141,  0,   0, 31, RD   , G   ,  0),
                (tx_dma_8_interrupt_reg                 ,     407,  0,   0,  1, RD_WR, D   ,  0),
                    (tx_dma_8_EOB_int_en                ,     407,  0,   0,  0, FIELD, D   ,  0),
                    (tx_dma_8_EOR_int_en                ,     407,  0,   1,  1, FIELD, D   ,  0),
                (tx_dma_8_fifo_usage_counter            ,     415,  0,   0,  7, RD   , G   ,  0),
        --MSI 
                (interrupt_control_reg                  ,     147,  0,   0, 31, RD_WR, D   ,  0),
                (interrupt_control_status               ,     148,  0,   0, 31, RD   , D   ,  0),
                (PCIE_ready_utilization                 ,     145,  0,   0,  7, RD   , G   ,  0),
                (PCIE_dma_utilization                   ,     146,  0,   0,  7, RD   , G   ,  0),
        -- DMA test channel
                (DMA_test_data_length                   ,     150,  0,  0, 31, RD_WR, G   ,    0),
                (DMA_test_data_reset                    ,     151,  0,  0,  7, WR   , G   ,    0),
                (DMA_test_utilization_1					,	  152,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_2					,	  153,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_3					,	  154,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_4					,	  155,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_5					,	  156,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_6					,	  157,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_7					,	  158,  0,  0, 15, RD   , G   ,    0),
                (DMA_test_utilization_8					,	  159,  0,  0, 15, RD   , G   ,    0),
                (PCIE_capability                        ,     165,  0,  0,  8, RD   , G   ,    0),
        -- FPGA temperature monitor
                (GX_temperature                         ,     286,  0,  0,  7, RD   , G   ,    0),
                (temperature_alert                      ,     287,  0,  0,  1, RD_WR, G   ,    2),
                    (temperature_alert_bit              ,     287,  0,  0,  0, FIELD, G   ,    0),
                    (temperature_fan_on                 ,     287,  0,  1,  1, FIELD, G   ,    1),
--                    (power_alert_bits                   ,     287,  0,  1,  4, FIELD, G   ,    0),
--                (alert_threshold                        ,     288,  0,  0,  6, RD_WR, G   ,   70),
		-- test clock for stp
				(stp_clock_select                       ,     296,  0,  0,  4, RD_WR, G   ,    0),
        -- CRC check
                (crc_read_1                             ,     290,  0,  0, 15, RD   , G   ,    0),
                (crc_read_2                             ,     291,  0,  0, 15, RD   , G   ,    0),
                (crc_read_3                             ,     292,  0,  0, 15, RD   , G   ,    0),
                (crc_read_4                             ,     293,  0,  0, 15, RD   , G   ,    0),
                (crc_read_5                             ,     294,  0,  0, 15, RD   , G   ,    0),
                (crc_read_6                             ,     295,  0,  0, 15, RD   , G   ,    0),
                (crc_read_7                             ,     297,  0,  0, 15, RD   , G   ,    0),
                (crc_read_8                             ,     298,  0,  0, 15, RD   , G   ,    0),
                (crc_read_9                             ,     299,  0,  0, 15, RD   , G   ,    0),
                (crc_read_10                            ,     300,  0,  0, 15, RD   , G   ,    0),
                (crc_read_11                            ,     301,  0,  0, 15, RD   , G   ,    0),
                (crc_read_12                            ,     302,  0,  0, 15, RD   , G   ,    0),
        -- memory address counter
                (memory_address_select                  ,      22,  0,  0, 31, RD_WR, G   ,    0),
                (drv_memory_address_select              ,      22,  0,  0, 31, RD_WR, D   ,    0),
        -- SDRAM port
                (nios_sram                              ,     484,  4,  0, 31, RD_WR, G   ,    0),
                (drv_nios_sram                          ,     484,  4,  0, 31, RD_WR, D   ,    0),
                (multi_port_A_select                    ,     303,  4,  0, 31, RD_WR, G   ,    0),
                (start_follower_address					,     307,  0,  0, 31, RD   , G   ,    0),
                (start_emulator_red_address				,     308,  0,  0, 31, RD   , G   ,    0),
                (start_emulator_blue_address			,     309,  0,  0, 31, RD   , G   ,    0),
                (start_emulator_green_address			,     310,  0,  0, 31, RD   , G   ,    0),
                (multi_port_error_reg                   ,     362,  0,  0,  7, RD   , G   ,    0),
        -- SDRAM bist
                (sdram_bist_A_enable                    ,     311,  0,  0,  0, WR   , G   ,    0),
                (sdram_bist_A_status                    ,     312,  0,  0,  2, RD   , G   ,    0),
                    (sdram_bist_A_is_running            ,     312,  0,  0,  0, FIELD, G   ,    0),
                    (sdram_bist_A_pass                  ,     312,  0,  1,  1, FIELD, G   ,    0),
                    (sdram_bist_A_fail                  ,     312,  0,  2,  2, FIELD, G   ,    0),
                (sdram_bist_A_fail_add                  ,     313,  0,  0, 29, RD   , G   ,    0),
			--
                (sdram_bist_B_enable                    ,     314,  0,  0,  0, WR   , G   ,    0),
                (sdram_bist_B_status                    ,     315,  0,  0,  2, RD   , G   ,    0),
                    (sdram_bist_B_is_running            ,     315,  0,  0,  0, FIELD, G   ,    0),
                    (sdram_bist_B_pass                  ,     315,  0,  1,  1, FIELD, G   ,    0),
                    (sdram_bist_B_fail                  ,     315,  0,  2,  2, FIELD, G   ,    0),
                (sdram_bist_B_fail_add                  ,     316,  0,  0, 29, RD   , G   ,    0),
			--
                (sdram_bist_C_enable                    ,     317,  0,  0,  0, WR   , G   ,    0),
                (sdram_bist_C_status                    ,     318,  0,  0,  2, RD   , G   ,    0),
                    (sdram_bist_C_is_running            ,     318,  0,  0,  0, FIELD, G   ,    0),
                    (sdram_bist_C_pass                  ,     318,  0,  1,  1, FIELD, G   ,    0),
                    (sdram_bist_C_fail                  ,     318,  0,  2,  2, FIELD, G   ,    0),
                (sdram_bist_C_fail_add                  ,     319,  0,  0, 29, RD   , G   ,    0),
        -- Remote Update
                (RU_aval_data                           ,     320,  0,  0, 31, RD_WR, G   ,    0),      
                (RU_aval_param                          ,     321,  0,  0, 31, RD_WR, G   ,    0),      
                (RU_aval_cmd                            ,     322,  0,  0, 31, RD_WR, G   ,    0),
                (RU_aval_status                         ,     323,  0,  0, 31, RD   , G   ,    0),
                (RU_SFL_add                             ,     324,  0,  0, 31, RD_WR, G   ,    0),
                (RU_SFL_cmd                             ,     325,  0,  0, 31, RD_WR, G   ,    0),
                (RU_SFL_status                          ,     326,  0,  0, 31, RD   , G   ,    0),
                (RU_SFL_data_wr                         ,     327,  4,  0, 31, RD_WR, G   ,    0),
                (RU_SFL_data_rd                         ,     328,  1,  0, 31, RD   , G   ,    0),
                (RU_update_error                        ,     330,  0,  0,  1, RD   , G   ,    0),
        -- IPP
                (IPP_status                             ,     333,  0,  0,  2, RD   , G   ,    0),         
        -- DATA LOGGER
        		(events_history_reset					,	  342,  0,  0,  0, WR   , G   ,    0),
        		(events_history_start_address			,	  343,  0,  0, 31, RD   , G   ,    0),
        		(events_history_size					,	  344,  0,  0, 31, RD   , G   ,    0),
        		(events_history_pointer					,     345,  0,  0, 31, RD   , G   ,    0),    
        -- GPIO select
        		(encoder_input_select                   ,     350,  0,  0,  0, RD_WR, G   ,    0),
        -- 4LS camera
                (Carmel_algorithm_version          		,     513,  0,  0, 31, RD   , G   ,algorithm_version),
                (Carmel_Compilation_TIME_addr          	,     514,  0,  0, 31, RD   , G   ,fpga_time_reg), 
				(Carmel_Compilation_DATE_addr			,     515,  0,  0, 31, RD   , G   ,fpga_date_reg),
                (Carmel_software_reset                 	,     516,  0,  0,  0, WR   , G   ,    0),
                (Carmel_control                     	,     517,  0,  0, 11, RD_WR, G   ,    0),         
					(Carmel_number_of_modalities 		,     517,  0,  0,  1, FIELD, G   ,    0),
					(Carmel_TDI_mode					,     517,  0,  2,  3, FIELD, G   ,    0),
					(Carmel_TDI_active_lines_red		,     517,  0,  4,  7, FIELD, G   ,    0),
					(Carmel_TDI_active_lines_blue		,     517,  0,  8, 11, FIELD, G   ,    0),
                (Carmel_status                     		,     518,  0,  0,  2, RD   , G   ,    0),         
					(Carmel_lvds_data_aligned          	,     518,  0,  0,  0, FIELD, G   ,    0),
					(Carmel_seriallite_link_up_rx      	,     518,  0,  1,  1, FIELD, G   ,    0),
					(Carmel_seriallite_link_up_tx      	,     518,  0,  2,  2, FIELD, G   ,    0),
                (Carmel_error_register                 	,     519,  0,  0, 31, RD   , G   ,    0),
                (Carmel_memory_address_select			,     520,  0,  0, 31, RD_WR, G   ,    0),
                (Carmel_sensor_address                 	,     521,  0,  0, 19, RD_WR, G   ,    0),
					(Carmel_sensor_reg_add             	,     521,  0,  0,  7, FIELD, G   ,    0),
					(Carmel_sensor_n_cs 	            ,     521,  0,  8, 19, FIELD, G   ,    0),
				(Carmel_sensor_data		            	,     522,  0,  0,  7, RD_WR, G   ,    0),
				(Carmel_sensor_register_setup_done     	,     524,  0,  0,  0, RD_WR, G   ,    0),
                (Carmel_IPP_status                     	,     525,  0,  0,  2, RD   , G   ,    0),         
                (Carmel_comp_red_line_1					,     526,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_red_line_2					,     527,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_red_line_3					,     528,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_red_line_4					,     529,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_blue_line_1				,     530,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_blue_line_2				,     531,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_blue_line_3				,     532,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_blue_line_4				,     533,  1,  0, 29, RD_WR, G   ,    0),
                (Carmel_comp_bypass						,     534,  0,  0,  0, RD_WR, G   ,    1),
                (Carmel_conv_lut_image_red				,     535,  1,  0,  7, RD_WR, G   ,    0),
                (Carmel_conv_lut_image_blue				,     536,  1,  0,  7, RD_WR, G   ,    0),
                (Carmel_test_pattern					,     537,  0,  0,  1, RD_WR, G   ,    0),
                    (Carmel_enable_tpgn					,     537,  0,  0,  0, FIELD, G   ,    0),
                    (Carmel_enable_tpgn_line_numbers	,     537,  0,  1,  1, FIELD, G   ,    0),
                (Carmel_FPGA_temperature                ,     538,  0,  0,  7, RD   , G   ,    0),
                (Carmel_board_temperature               ,     539,  0,  0,  7, RD   , G   ,    0),
                (Carmel_board_temperature_max           ,     540,  0,  0,  7, RD_WR, G   ,    0),
                (Carmel_sensor_temperature              ,     541,  0,  0,  7, RD   , G   ,    0),
                (Carmel_sensor_temperature_max          ,     542,  0,  0,  7, RD_WR, G   ,    0),
                (Carmel_temperature_alert               ,     543,  0,  0,  2, RD   , G   ,    0),
                    (Carmel_FPGA_temperature_alert      ,     543,  0,  0,  0, FIELD, G   ,    0),
                    (Carmel_board_temperature_alert     ,     543,  0,  1,  1, FIELD, G   ,    0),
                    (Carmel_sensor_temperature_alert    ,     543,  0,  2,  2, FIELD, G   ,    0),
                (Carmel_RU_aval_data                    ,     544,  0,  0, 31, RD_WR, G   ,    0),      
                (Carmel_RU_aval_param                   ,     545,  0,  0, 31, RD_WR, G   ,    0),      
                (Carmel_RU_aval_cmd                     ,     546,  0,  0, 31, RD_WR, G   ,    0),
                (Carmel_RU_aval_status                  ,     547,  0,  0, 31, RD   , G   ,    0),
                (Carmel_RU_SFL_add                      ,     548,  0,  0, 31, RD_WR, G   ,    0),
                (Carmel_RU_SFL_cmd                      ,     549,  0,  0, 31, RD_WR, G   ,    0),
                (Carmel_RU_SFL_status                   ,     550,  0,  0, 31, RD   , G   ,    0),
                (Carmel_RU_SFL_data_wr                  ,     551,  4,  0, 31, RD_WR, G   ,    0),
                (Carmel_RU_SFL_data_rd                  ,     552,  1,  0, 31, RD   , G   ,    0),
                (Carmel_RU_update_error                 ,     553,  0,  0,  1, RD   , G   ,    0),
                (Carmel_test_register	                ,     560,  0,  0, 31, RD_WR, G   ,    0),
        -- DEBUG
        		(test_register_1						,	  353,  0,  0, 31, RD_WR, G   ,    0),
        		(test_register_2						,	  354,  0,  0, 31, RD_WR, G   ,    0),
        		(test_register_3						,	  355,  0,  0, 31, RD_WR, G   ,    0),        		
        		(test_register_4						,	  356,  0,  0, 31, RD_WR, G   ,    0),        		
        		(test_register_5						,	  357,  0,  0, 31, RD_WR, G   ,    0),        		
        		(test_register_6						,	  358,  0,  0, 31, RD_WR, G   ,    0),        		
        		(test_register_7						,	  359,  0,  0, 31, RD_WR, G   ,    0),        		
        		(test_register_8						,	  360,  0,  0, 31, RD_WR, G   ,    0),        		
        		(max_image_lines_in_buffer              ,     500,  0,  0, 15, RD   , ABC ,    0)        		
                );

function    address_of      (port_name  : avalon_map_defenition) return Integer ;
function    lsb_of          (field_name : avalon_map_defenition) return Integer ;
function    msb_of          (field_name : avalon_map_defenition) return Integer ;
function    init_of         (port_name  : avalon_map_defenition) return Std_logic ;
function    init_of         (port_name  : avalon_map_defenition) return Std_logic_Vector ;
function    memory_inc_step (address : Std_Logic_Vector) return Integer ;
function    port_exist      (address : Integer) return boolean ;


end mapping_package;


package body mapping_package is


function    address_of  (port_name : avalon_map_defenition) return Integer is
    variable    address : Integer ;
    begin
        address := 0 ;
        for i in 1 to number_of_fields loop
            if port_name = avalon_fields_table(i).name then
                address := avalon_fields_table(i).address ;
                exit ;
            end if ;
        end loop ;
        return address ;
    end function ;


function    lsb_of  (field_name : avalon_map_defenition) return Integer is
    variable    lsb : Integer ;
    begin
        lsb := 0 ;
        for i in 1 to number_of_fields loop
            if field_name = avalon_fields_table(i).name then
                lsb := avalon_fields_table(i).lsb ;
                exit ;
            end if ;
        end loop ;
        return lsb ;
    end function ;


function    msb_of  (field_name : avalon_map_defenition) return Integer is
    variable    msb : Integer ;
    begin
        msb := 0 ;
        for i in 1 to number_of_fields loop
            if field_name = avalon_fields_table(i).name then
                msb := avalon_fields_table(i).msb ;
                exit ;
            end if ;
        end loop ;
        return msb ;
    end function ;


function    init_of (port_name : avalon_map_defenition) return Std_Logic is
    variable    init : Std_Logic ;
    begin
        init := '0' ;
        for i in 1 to number_of_fields loop
            if port_name = avalon_fields_table(i).name then
                if avalon_fields_table(i).init > 0 then
                    init := '1' ;
                end if ;
                exit ;
            end if ;
        end loop ;
        return init ;
    end function ;


function    init_of (port_name : avalon_map_defenition) return Std_Logic_Vector is
    variable    init : Std_Logic_Vector(31 downto 0) ;
    begin
        init := (others => '0') ;
        for i in 1 to number_of_fields loop
            if port_name = avalon_fields_table(i).name then
                init := conv_std_logic_vector(avalon_fields_table(i).init,32) ;
                return init(avalon_fields_table(i).msb - avalon_fields_table(i).lsb downto 0) ;
                exit ;
            end if ;
        end loop ;
    end function ;


function    memory_inc_step (address : Std_Logic_Vector) return Integer is
    variable    MAIS : Integer ;
    begin
        MAIS := 0 ;
        for i in 1 to number_of_fields loop
            if address = avalon_fields_table(i).address and avalon_fields_table(i).f_type /= FIELD then
                MAIS := avalon_fields_table(i).MAIS ;
                exit ;
            end if ;
        end loop ;
        return MAIS ;
    end function ;


function    port_exist  (address : Integer) return boolean is
    variable    exist : boolean ;
    begin
      exist := false ;
        for i in 1 to number_of_fields loop
            if address = (avalon_fields_table(i).address mod (2**real_address_bits)) and avalon_fields_table(i).f_type /= FIELD then
                exist := true ;
                exit ;
            end if ;
        end loop ;
        return exist ;
    end function ;
        

end mapping_package;
