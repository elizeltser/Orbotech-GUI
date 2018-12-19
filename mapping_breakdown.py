import sys, re, operator
# Constants, and definitions

# Important filenames
internal_definitions_file = "mydef.txt"
# The function prints an error message and quits with exit code 1
def error(message):
    print(message)
    sys.exit(1)
    
# Load constants and definitions from file
def LoadConstsDefinitions( definitions_dict, possible_fields, constants):
    try:
        def_file = open(internal_definitions_file)
    except:
        error("File open error")
    # Construct a dictionary of constants    
    constants_d = {}
    for constant in constants:
        constants_d[ constant[0] ] = constant[2]
    for line in def_file:
        if '#' == line[0]:
            continue
        [field, values_lst] = (line.rstrip("\n")).split(" - ")
        possible_fields.append(field)
        definitions_dict[field] = []
        for value in values_lst.split(" "):
            try:
                definitions_dict[field].append( int(value) )
            except:
                definitions_dict[field].append( value )
    def_file.close()
    
def IsValidReg(const_definitions_dict, possible_fields, reg_propartis):
    # dectionary of available operators
    ops = {'[>]': operator.gt,
           '[<]': operator.lt,
           '[>=]': operator.ge,
           '[<=]': operator.le,
           '[!=]': operator.ne}
    index = 0
    reg_proparties_d = {}
    for field in possible_fields:
        reg_proparties_d[field] = reg_propartis[index]
        index = index + 1
    for prop in reg_propartis:
        possib_prop = const_definitions_dict[possible_fields[reg_propartis.index(prop)]]
        if prop in possib_prop:
            continue
        else:
            if isinstance(prop,int):
                tags_to_check = set(possib_prop) & set(ops.keys())
                for tag in tags_to_check:
                    index_to_check = 1 + possib_prop.index(tag)
                    if isinstance(possib_prop[index_to_check],int):
                        if False == ops[tag](prop,possib_prop[index_to_check]):
                            print("proparty " + prop + " is wrong!")
                    if possib_prop[index_to_check] in possible_fields:
                        if False == ops[tag](prop,reg_proparties_d[possib_prop[index_to_check]]):
                            print("proparty " + str(prop) + " is wrong!")
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
    # dictionary with field as key and tuple of possible elements as its value.
    const_definitions_dict={}
    possible_fields = []
    #should be loaded from the files
    constants = [("software_version","integer",256),("fpga_time_reg","integer",156)]
    LoadConstsDefinitions(const_definitions_dict,possible_fields,constants)
    IsValidVHDFile("mapping_package.vhd","mycorrect.txt")
    # [mais, lsb, msb, type_of_reg, fpga, init]
    prop_to_check = ['0','0','31','RD','G','0']
    reg = {'DannyWifeProblems':(0,0,1,31,'RD','G',1)}
    IsValidReg(const_definitions_dict, possible_fields ,reg["DannyWifeProblems"])

if __name__ == '__main__':
    main()
