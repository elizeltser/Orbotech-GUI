import sys, re, operator

# Constants and definitions
all_possible_fields = ['ADDRESS', 'MAIS', 'LSB', 'MSB', 'TYPE' , 'FPGA', 'INIT']

# The function prints an error message and quits with exit code 1
def error(message):
    print(message)
    sys.exit(1)
    
# Load constants and definitions from file
def LoadConsDefinitions(internal_def_filename,definitions_dict):
    try:
        def_file = open(internal_def_filename)
    except:
        error("File open error")
    #dictionary with field as key and tuple of possible elements as its value.
    # {}
    for line in def_file:
        if '#' == line[0]:
            continue
        [field, values_lst] = (line.rstrip("\n")).split(" - ")
        definitions_dict[field]=tuple(values_lst.split(" "))
    def_file.close()


def IsValidProparties(definitions_dict, prop_to_check,reg_name):
    # [mais, lsb, msb, type_of_reg, fpga, init]
    prop_d = {'MAIS':prop_to_check[0],'TYPE':prop_to_check[3],'FPGA':prop_to_check[4],'INIT':prop_to_check[5]}
    for key in prop_d.keys():
        if key in definitions_dict.keys():
            if prop_d[key] not in definitions_dict[key]:
                error("invalid register field "+ prop_d[key]+ " for register named "+ reg_name)
        
        
# Check if the file contains all initiations
def IsValidVHDFile(mappling_filename,correct_initials_filename):
    try:
        map_file = open(mappling_filename)
        correct_file = open(correct_initials_filename)
    except:
        error("File open error")
    compare_state_switch_string = "0o0o0o0o0o0o0o0o0o0o0o0o0o00o0o0o0o0o0o00o0o0o0o0o0\n"
    are_simmilar = True
    compare_state = True
    line_num = 1
    line = map_file.readline()
    correct_line = correct_file.readline()
    while line != "" and correct_line != "":
        if correct_line[0] == "#":
            #print("its just a comment: "+ correct_line +"\n")
            correct_line = correct_file.readline()
            continue
##        if correct_line[0]=='\n' or line[0] == '\n':
##            line = map_file.readline()
##            correct_line = correct_file.readline()
##            continue
        if correct_line == compare_state_switch_string:
            compare_state = False
            correct_line = correct_file.readline()
        if compare_state:
            #print("at line "+str(line_num)+"\n"+"correct line is:"+correct_line+"check for line:"+line)
            if line != correct_line:
                are_simmilar = False
                break
            line = map_file.readline()
            line_num+=1
            correct_line = correct_file.readline()
        else:
            if line == correct_line:
                compare_state = True
                continue
            #print("shouldnt compare this line:"+line)
            line = map_file.readline()
            line_num+=1
    map_file.close()
    correct_file.close()
    if not are_simmilar or not compare_state:
        error("File is incorrect in line " + str(line_num) + "\n" + line +"should be:\n"+ correct_line)
    else:
        print("Constants are fine")

def main():
    const_definitions_dict={}
    LoadConsDefinitions("mydef.txt", const_definitions_dict)
    IsValidVHDFile("mapping_package_copy.vhd","mycorrect.txt")
        # [mais, lsb, msb, type_of_reg, fpga, init]
    prop_to_check = ['0','0','31','RD','G','0']
    reg_name = "EliIsAwesome"
    IsValidProparties(const_definitions_dict,prop_to_check,reg_name)
if __name__ == '__main__':
    main()
