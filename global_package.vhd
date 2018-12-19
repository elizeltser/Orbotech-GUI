----------------------------------------------------------------
-- orbotech Ltd. 
-- PCB Division, AOI Department 
-- System(s)      : fusion
-- Card           : "MVC_2"  
-- Name           : global_package.vhd 
-- Author         : Danny Shalom. 
-- Entity description:

-- Version history:
-- Version 1, by Danny Shalom, 1/1/2008 - Initial version.
----------------------------------------------------------------
--

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;   
use IEEE.std_logic_arith.all;
use work.global_package_top.all ;


package global_package   is   


constant	ipp_exist			: boolean := true ;
constant	address_size 		: integer := 10 ;   	-- bank size is 2048
constant	real_address_bits	: Integer := 9 ; -- 8 for maximun 256 adresses, 9 for 512 addresses, 10 for 1024 address
type		avalon_cs_type		is array(1 to number_of_channels) of Std_Logic_Vector(2**real_address_bits-1 downto 0) ;
constant	report_test_enable	: boolean := true ;

-- ****************************************************************************
-- Parameters for camera arrange
-- ****************************************************************************
type		channel_output_type is array(1 to number_of_channels) of Std_Logic_Vector(7 downto 0) ;
subtype		envelope_type		is Std_Logic_Vector(1 to number_of_channels) ;
type		pixel_per_channel_type is array(1 to number_of_channels) of Integer range 0 to 16383 ;
type		channel_length_type is array(1 to number_of_channels) of Std_Logic_Vector(13 downto 0) ;


-- ****************************************************************************
-- PARAMETERS FOR LINE DELAY & STITCHING FIFOS
-- ****************************************************************************
constant	max_line_length  	: integer := max_line_length_top ;

-- ****************************************************************************
-- PARAMETERS FOR PCI-E & AVALON BUS DEFENITIONS
-- ****************************************************************************
constant	PCIE_data_width		: integer := 256 ;
constant	avalon_addr_bits	: integer := 10 ;
constant	DMA_RX_exist		: boolean := false ;
constant	number_of_PCI_E_interrupts : Integer := 7 ;
type		dma_tx_desc_type	is array (1 to number_of_DMA_TX) of Std_Logic_Vector(127 downto 0) ;
type		dma_tx_data_type	is array (1 to number_of_DMA_TX) of Std_Logic_Vector(PCIE_data_width-1 downto 0) ;
type		dma_tx_empty_words_type is array (1 to number_of_DMA_TX) of Std_Logic_Vector(1 downto 0) ;
type		dma_rx_desc_type	is array (0 to number_of_DMA_RX) of Std_Logic_Vector(127 downto 0) ;
type		dma_rx_data_type	is array (0 to number_of_DMA_RX) of Std_Logic_Vector(PCIE_data_width-1 downto 0) ;
type		dma_rx_empty_words_type is array (0 to number_of_DMA_RX) of Std_Logic_Vector(1 downto 0) ;
constant	dma_test_exist 		: boolean := true ;
constant	number_of_test_register : integer := 6 ;
type		test_register_type	is array (1 to number_of_test_register) of Std_Logic_Vector(31 downto 0) ;

-- ****************************************************************************
-- Parameters for camera_interface and TPGN                                                  
-- ****************************************************************************
constant	pixel_width					: integer := 8;      -- 	8;
constant    pixels_offset				: integer := 9; -- This is for camera interface to calculate offset for compensation
-- ****************************************************************************
-- Parameters for Blind Via
-- ****************************************************************************
type	bv_vector_type		is array(0 to 8) of Std_Logic_Vector(7 downto 0) ;
type	bv_matrix_type		is array(0 to 8) of bv_vector_type ;

-- ****************************************************************************
-- Parameters for data arrange
-- ****************************************************************************
type	gray_picture_from_fifo_type 	is array(1 to number_of_channels) of Std_Logic_Vector(63 downto 0) ;
type	gray_picture_data_count_type 	is array(1 to number_of_channels) of Std_Logic_Vector(3 downto 0) ;
type	count_fifo_type					is array(1 to number_of_channels) of Std_Logic_Vector(13 downto 0) ;
type	check_sum_type					is array(1 to number_of_channels) of Std_Logic_Vector(31 downto 0) ;
constant max_report_buffer_size			: integer := 4*2**20 ;

-- ****************************************************************************
-- Parameters for Serial Flash Loader
-- ****************************************************************************
constant sfl_addr_bits		: integer := 32 ;
constant sfl_page_1_add		: Std_Logic_Vector(sfl_addr_bits-1 downto 0) := X"01000000" ;
constant sfl_last_erase_add: Std_Logic_Vector(sfl_addr_bits-1 downto 0) := X"01FFFFFF" ;
constant sfl_last_add		: Std_Logic_Vector(sfl_addr_bits-1 downto 0) := X"01FFFFFF" ;
constant sfl_sector_size	: Std_Logic_Vector(sfl_addr_bits-1 downto 0) := X"00010000" ;		--64 KByte sector size


function log2ceil (n : integer) return integer ;
function get_color  (num_of_modalities : Std_Logic_Vector(1 downto 0); channel : integer ; dalsa : Std_Logic) 
									return image_color_type ;
function pink_exist (channel : Integer) return boolean ;
function channel_exist (channel : Integer) return boolean ;
function green_exist return boolean ;
function blue_exist return boolean ;
constant pink_rep_exist	: boolean := pink_modality_exist ;
function get_channel_first_pixel	(line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								     resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer ;
function get_channel_last_pixel		(line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								     resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer ;
function get_raw_first_pixel  		(line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								     resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer ;
function resampling_1st_state		(line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								     resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer ;
function	overlap_length (resolution : Std_Logic_Vector(4 downto 0)) return integer ;
function	image_line_length (modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; dalsa : Std_Logic) return integer ;
function	min_center_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer ;
function	max_center_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer ;
function	min_slave_ROI  (resolution : Std_Logic_Vector(4 downto 0)) return integer ;
function	max_master_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer ;

end global_package;

package body global_package is

--this function receives integer and return the number of bits it is in binary
-- for example : 5 will return 3, 9 will return 4 ...

function log2ceil (n : integer) return integer is
variable m, p : integer;
begin
 m := 0;
 p := 1;
 if n = 1 then
 	m := 1 ;
 else
 	for i in 0 to n loop
 	   if p < n then
 	     m := m + 1;
 	     p := p * 2;
 	   end if;
 	end loop;
 end if ;
return m;
end log2ceil;

function get_color  (num_of_modalities : Std_Logic_Vector(1 downto 0); channel : integer ; dalsa : Std_Logic)
	return image_color_type is
	variable color_per_ch	: color_per_ch_type ;
	variable color			: image_color_type ;
	begin
		case num_of_modalities is
		when "11" =>
			color_per_ch := triple_color_per_ch ;
		when "10" => 
			if dalsa = '1' then
				color_per_ch := dalsa_dual_color_per_ch ;
			elsif number_of_channels = 6 then
				color_per_ch := dual_color_per_ch ;
			else
				color_per_ch := triple_color_per_ch ;
			end if ;
		when "01" => 
			if dalsa = '1' then
				color_per_ch := dalsa_single_color_per_ch ;
			elsif number_of_channels = 6 or number_of_channels = 4 then
				color_per_ch := single_color_per_ch ;
			else
				color_per_ch := triple_color_per_ch ;
			end if ;
		when others => 
			if dalsa = '1' then
				color_per_ch := dalsa_single_color_per_ch ;
			elsif number_of_channels = 6 or number_of_channels = 4 then
				color_per_ch := one_color_per_ch ;
			else
				color_per_ch := one_color_per_ch ;
			end if ;
		end case ;
		color := color_per_ch(channel) ;
		return color ;
	end function ;

function pink_exist (channel : Integer) return boolean is
	begin
		if not pink_rep_exist then
			return false ;
		elsif number_of_channels = 4 and channel <= number_of_dual_channels then
			return true ;
		elsif number_of_channels = 6 and channel <= number_of_dual_channels then
			return true ;
		else
			return false ;
		end if ;
	end function ;

function channel_exist (channel : Integer) return boolean is
	begin
		if number_of_channels = 6 then
			return true ;
		elsif number_of_channels = 4 then
			if channel > 4 then
				return false ;
			else
				return true ;
			end if ;
		else
			if channel > 2 then
				return false ;
			else
				return true ;
			end if ;
		end if ;
	end function ;

function green_exist return boolean is
	begin
		if number_of_channels = 6 and green_modality_exist then
			return true ;
		else
			return false ;
		end if ;
	end function ;

function blue_exist return boolean is
	begin
		if ((number_of_channels = 6 or number_of_channels = 4) and blue_modality_exist)
		or (number_of_channels = 2 and camera_length = 12288 and blue_modality_exist) then
			return true ;
		else
			return false ;
		end if ;
	end function ;

function get_channel_first_pixel  (line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer is
	variable results		: integer ;
	variable mode_num_int : integer range 0 to 3 ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		mode_num_int := conv_integer(modl_num) ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if dalsa = '1' and resolution_int < 15 then
			results := first_pixel_4_dalsa(mode_num_int)(resolution_int)(chanl) ;
		elsif resolution(4) = '0' and resolution_int < 7 then
			case line_ROI is
			when "00" =>
				results := first_pixel_3_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := first_pixel_3_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := first_pixel_3_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := first_pixel_3_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			case line_ROI is
			when "00" =>
				results := first_pixel_4_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := first_pixel_4_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := first_pixel_4_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := first_pixel_4_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		end if ;
		return results ;
	end function ;

function get_channel_last_pixel  (line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer is
	variable results		: integer ;
	variable mode_num_int : integer range 0 to 3 ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		mode_num_int := conv_integer(modl_num) ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if dalsa = '1' and resolution_int < 15 then
			results := last_pixel_4_dalsa(mode_num_int)(resolution_int)(chanl) ;
		elsif resolution(4) = '0' and resolution_int < 7 then
			case line_ROI is
			when "00" =>
				results := last_pixel_3_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := last_pixel_3_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := last_pixel_3_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := last_pixel_3_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			case line_ROI is
			when "00" =>
				results := last_pixel_4_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := last_pixel_4_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := last_pixel_4_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := last_pixel_4_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		end if ;
		return results ;
	end function ;

function get_raw_first_pixel  (line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer is
	variable results		: integer ;
	variable mode_num_int : integer range 0 to 3 ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		mode_num_int := conv_integer(modl_num) ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if dalsa = '1' and resolution_int < 15 then
			results := first_raw_pixel_4_dalsa(mode_num_int)(resolution_int)(chanl) ;
		elsif resolution(4) = '0' and resolution_int < 7 then
			case line_ROI is
			when "00" =>
				results := first_raw_pixel_3_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := first_raw_pixel_3_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := first_raw_pixel_3_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := first_raw_pixel_3_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			case line_ROI is
			when "00" =>
				results := first_raw_pixel_4_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := first_raw_pixel_4_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := first_raw_pixel_4_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := first_raw_pixel_4_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		end if ;
		return results ;
	end function ;

function resampling_1st_state  (line_ROI : Std_Logic_Vector(1 downto 0) ; modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; chanl : integer range 1 to 6 ; dalsa : Std_Logic)
					   				return integer is
	variable results		: integer ;
	variable mode_num_int : integer range 0 to 3 ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		mode_num_int := conv_integer(modl_num) ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if dalsa = '1' and resolution_int < 15 then
			results := resampling_1st_state_4_dalsa(mode_num_int)(resolution_int)(chanl) ;
		elsif resolution(4) = '0' and resolution_int < 7 then
			case line_ROI is
			when "00" =>
				results := resampling_1st_state_3_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := resampling_1st_state_3_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := resampling_1st_state_3_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := resampling_1st_state_3_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			case line_ROI is
			when "00" =>
				results := resampling_1st_state_4_full(mode_num_int)(resolution_int)(chanl) ;
			when "01" =>
				results := resampling_1st_state_4_master(mode_num_int)(resolution_int)(chanl) ;
			when "10" =>
				results := resampling_1st_state_4_slave(mode_num_int)(resolution_int)(chanl) ;
			when others =>
				results := resampling_1st_state_4_center(mode_num_int)(resolution_int)(chanl) ;
			end case ;
		end if ;
		return results ;
	end function ;

function	overlap_length (resolution : Std_Logic_Vector(4 downto 0)) return integer is
	variable results		: integer ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if resolution(4) = '0' and resolution_int < 7 then
			results := overlap_length_3(resolution_int) ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			results := overlap_length_4(resolution_int) ;
		end if ;
		return results ;
	end function ;

function	image_line_length (modl_num : Std_Logic_Vector(1 downto 0) ;
								   resolution : Std_Logic_Vector(4 downto 0) ; dalsa : Std_Logic) return integer is
	variable results		: integer ;
	variable mode_num_int : integer range 0 to 3 ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		mode_num_int := conv_integer(modl_num) ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if dalsa = '1' then
			if mode_num_int = 2 then
				results := dalsa_image_line_length_dual_4(resolution_int) ; 					   
			elsif mode_num_int = 1 then
				results := dalsa_image_line_length_single_4(resolution_int) ; 					   
			end if ;
		elsif resolution(4) = '0' and resolution_int < 7 then
			if mode_num_int = 3 then
				results := image_line_length_triple_3(resolution_int) ; 					   
			elsif mode_num_int = 2 then
				results := image_line_length_dual_3(resolution_int) ; 					   
			elsif mode_num_int = 1 then
				results := image_line_length_single_3(resolution_int) ; 					   
			elsif mode_num_int = 0 then
				results := image_line_length_one_3(resolution_int) ; 					   
			end if ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			if mode_num_int = 3 then
				results := image_line_length_triple_4(resolution_int) ; 					   
			elsif mode_num_int = 2 then
				results := image_line_length_dual_4(resolution_int) ; 					   
			elsif mode_num_int = 1 then
				results := image_line_length_single_4(resolution_int) ; 					   
			elsif mode_num_int = 0 then
				results := image_line_length_one_4(resolution_int) ; 					   
			end if ;
		end if ;
		return results ;
	end function ;

function	min_center_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer is
	variable results		: integer ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if resolution(4) = '0' and resolution_int < 7 then
			results := min_center_ROI_3(resolution_int) ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			results := min_center_ROI_4(resolution_int) ;
		end if ;
		return results ;
	end function ;

function	max_center_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer is
	variable results		: integer ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if resolution(4) = '0' and resolution_int < 7 then
			results := image_line_length_triple_3(resolution_int) - min_center_ROI_3(resolution_int) ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			results := image_line_length_triple_4(resolution_int) - min_center_ROI_4(resolution_int) ;
		end if ;
		return results ;
	end function ;

function	min_slave_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer is
	variable results		: integer ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if resolution(4) = '0' and resolution_int < 7 then
			results := min_slave_ROI_3(resolution_int) ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			results := min_slave_ROI_4(resolution_int) ;
		end if ;
		return results ;
	end function ;

function	max_master_ROI (resolution : Std_Logic_Vector(4 downto 0)) return integer is
	variable results		: integer ;
	variable resolution_int : integer range 0 to 15 ;
	begin
		results := 0 ;
		resolution_int := conv_integer(resolution(3 downto 0)) ;
		if resolution(4) = '0' and resolution_int < 7 then
			results := image_line_length_triple_3(resolution_int) - min_slave_ROI_3(resolution_int) ;
		elsif resolution(4) = '1' and resolution_int < 15 then
			results := image_line_length_triple_4(resolution_int) - min_slave_ROI_4(resolution_int) ;
		end if ;
		return results ;
	end function ;


end global_package;
