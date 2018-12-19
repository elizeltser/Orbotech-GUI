import sys,re

# The function prints an error message and quits with exit code 1
def error(message):
    print (message)
    sys.exit(1)
    
# creates list of constants and types defined in the global.vhd file
def ExtractConstant(globals_filename,constants,types):
    try:
        global_file = open(globals_filename,"r")
    except:
        error("File " + globals_filename + " cannot be opened")
    # custom pattern for constant definition line 
    const_pattern = re.compile(r"""constant\s*                          # opening 'constant' and whitespace
                                (?P<name>.*?)                           # name of constant
                                 \s*:\s*(?P<type>.*?)                   # whitespace, ':' character, type
                                 \s*:=\s*(?P<value>.*?)                 # whitespace, next bar, value.. ends with ';'
                                 \s*;""", re.VERBOSE)
    # custom pattern for type definition line 
    type_pattern = re.compile(r"""type\s*                               # opening bar and whitespace
                                (?P<name>.*?)                           # quoted name
                                \s*is\s array\s*\(\s*(?P<strt1>.*?)     # whitespace, 'is array (', start of array
                                \s*to\s*(?P<end1>.*?)\s*\)              # whitespace, 'to' blank and end of array followed by ')'
                                \s*of\s*(?P<type>.*?)                   # 'of' type and range together
                                \s*;""", re.VERBOSE)
    # custom pattern for range X to Y token
    range_pattern = re.compile(r"""range\s*                             # opening 'range' string
                                (?P<strt>.*?)                           # range beginning
                                \s*to\s*                                # 'to' delimiter
                                (?P<end>.*?)                            # range end
                                \s*;""",re.VERBOSE)
    for line in global_file:
        
        #check if line begins with 'constant' or 'type', if so, add them to the list after parsing
        if line.startswith("constant"):
            match = const_pattern.match(line)
            if match.group("type") == 'integer':
                if match.group("value").startswith("range"):
                    constants.append((match.group("name"),match.group("type"),match.group("value")))
                else:
                    constants.append( ( match.group("name"), match.group("type"), int(match.group("value")) ) )
            else:
                constants.append((match.group("name"),match.group("type"),match.group("value")))
        
        if line.startswith("type"):
            match = type_pattern.match(line)
            types.append(( match.group("name"),match.group("strt1"),match.group("end1"),match.group("type") ))
    global_file.close()
def main(globals_filename):
    
    # List of constants, for each 'constant' definition, a tuple (name,type,value) is appended
    # (all elements are strings)    
    constants = []
    
    # List of types, for each 'type' definition, a tuple (name,array_begin,array_end,type_and_range) is appended
    # (all elements are strings)
    types = []    
    ExtractConstant(globals_filename,constants,types)
    print constants
    print types
    # See? all is in the list
    sys.exit(0)

if __name__ =="__main__":
    #main(sys.argv[1],sys.argv[2])
    main("global_package_copy.vhd")
