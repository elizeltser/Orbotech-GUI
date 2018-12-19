import sys, re, operator

# constants declerations
defs_start = """----------------------------------------------------------------
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
type        avalon_map_defenition  is  (\n"""

defs_mid ="""        -- last
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
--               field name or port name                ,ADDRESS,MAIS,LSB,MSB, TYPE , FPGA,INIT\n"""

defs_end = """                );

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
        

end mapping_package;\n"""

registers = {} # global data structre to hold the registers name and their addresses of type dictionary

# The function prints an error message and quits with exit code 1
def error(message):
    print (message)
    sys.exit(1)

# When reading from a given vhd file, the function returns [mais, lsb, msb, type_of_reg, fpga, init] 
def properties_extractor(lst):
    tmp =[x[1::] for x in lst]
    tmp[len(tmp)-1] = tmp[len(tmp)-1][:-1]
    return tmp

# The function gets a register's name and its parameters, and returns the exact line to save in the vhd line
def get_line(t, params):
    mais = params[0]
    lsb = params[1]
    msb = params[2]
    type_of_reg = params[3]
    fpga = params[4]
    init = params[5]
    ___reg_name___ = 16 * " " + "(" + t + (56 - ((17 + len(t)))) * " "
    __address = (8-len(str(registers[t][0]))) * " " + str(registers[t][0])
    __mais = (3-len(mais)) * " " + mais
    __lsb__msb = (3-len(lsb)) * " " + lsb + "," + (3-len(msb)) * " " + msb
    _type__ = " " + type_of_reg + (5-len(type_of_reg)) * " "
    _fpga__ = " " + fpga + (4-len(fpga)) * " "
    if init.isdigit():
        __init = (5-len(init)) * " " + init
    else:
        __init = init
    return ___reg_name___ + "," + __address + "," + __mais + "," + __lsb__msb +"," + _type__ + "," + _fpga__ + "," + __init

# The function gets a register's name and adds it to the global DS
# The register's address will be the minimal free address
def add(reg, fields):
    if registers:
        indices = []
        indices_keys_sorted = sorted(registers, key=lambda i: int(registers[i][0])) # sort the dictionary
        for r in indices_keys_sorted:
            indices = indices + [registers[r][0]]
        index = -1 # init
        indices = [int(i) for i in indices]
        if indices[0] > 1:
            index = 1
        else:
            for i in range(len(indices) - 1):
                if indices[i] < indices[i+1] - 1:
                    index = indices[i]+1
                    break
            if index == -1:
                index = indices[len(indices)-1] + 1
        registers[reg] = (index, fields)
    else:
        registers[reg] = (1, fields)

# The function writes all the results in a vhd file
def write_to_file(file_path):
    tmp = {}
    for k in registers:
        tmp[k] = int(registers[k][0])
    tmp = sorted(tmp.items(), key=operator.itemgetter(1)) # sort the keys according to reg's address
    regs_text = []
    for key in tmp:
        regs_text = regs_text + [key]
    try:
        f = open(file_path, "w")
    except:
        error("File Open Error")
    f.write(defs_start)
    for i in range(len(regs_text)):
        f.write(16 * " " + regs_text[i][0] + ",\n")
    f.write(defs_mid)
    for i in range(len(regs_text) - 1):
        r = regs_text[i]
        f.write(get_line(r[0], registers[r[0]][1]) + "),\n")
    f.write(get_line(regs_text[-1][0], registers[regs_text[-1][0]][1]) + ")\n")
    f.write(defs_end)
    f.close()
    
def read_regs_from_file(file_path):
    try:
        f = open(file_path, "r")
    except:
        error("File Open Error")
    lines = f.readlines()
    lines = [entry.rstrip() for entry in lines]
    for i in range(len(lines)):
        if lines[i] == "type        avalon_map_defenition  is  (":
            start = i + 1
            #print ("start line " + str(start) + ": " + lines[start])
        elif lines[i] == """        -- last""":
            end = i
            #print ("end line " + str(end) + ": " + lines[end])
            break
    if start > end:
        error("Invalid input")
    elif start == end:
        return
    res = []
    for i in range(start, end):
        res = res + [re.sub('\s+',' ',lines[i])[1::][:-1]] # get register's name from the vhd file
    #res = res + [re.sub('\s+',' ',lines[i+1])[1::][:-2]]
    regs_text = res
    #print ("read from text: " + str(res))
    
    for i in range(len(lines)):
        if lines[i] == "--               field name or port name                ,ADDRESS,MAIS,LSB,MSB, TYPE , FPGA,INIT":
            start = i + 1
        elif lines[i] == "                );":
            end = i
    if start > end:
        error("Invalid input")
    elif start == end:
        return
    for i in range(start,end):
        tmp = re.sub('\s+',' ',lines[i])[2::][:-1]
        tmp = tmp.split(",")
        #print (tmp)
        cur = tmp[0]
        index = tmp[1] 
        cur = cur[:-1]
        index = index[1:]
        prop = properties_extractor(tmp[2::])
        #print (cur)
        #print (index)
        if cur in res:
            registers[cur] = (index, prop) # update DS

def main(reg_files, load):
    try:
        params = open(reg_files, "r")
    except:
        error("File Open Error")
    lines = params.readlines()
    lines = [entry.rstrip() for entry in lines]
    
    if load == 1:
        read_regs_from_file("res.vhd")
    for line in lines:
        properties = line.split(" ")
        reg = properties[0]
        if reg in registers.keys():
            params.close()
            error("Register name is invalid")
        add(reg, properties[1::])
    write_to_file("res.vhd")
    params.close()
    sys.exit(0)
    
if __name__ == "__main__":
    #main(sys.argv[1], sys.argv[2])
    load = 1
    main("parameters2.txt", load)
