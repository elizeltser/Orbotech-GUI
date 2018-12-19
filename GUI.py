#import tkinter as tk

# if you are still working under a Python 2 version, 
# comment out the previous line and uncomment the following line
import Tkinter as tk,tkFileDialog
from Tkinter import *
def NewFile():
    print "New File!"
def OpenFile():
    name = askopenfilename()
    print name
def About():
    print "This is a simple example of a menu"

def BrowesFiles(file_name):
    file_name = tkFileDialog.askopenfile(parent=root,mode='rb',title='Choose a file')
    
root = tk.Tk()

# width x height + x_offset + y_offset:
root.geometry("570x400+30+30")
# failed attempt at defining menues!
##menu = tk.Menu(root)
##root.confic(menu=menu)
##filemenu=Menu(menu.tk)
##
### width x height + x_offset + y_offset:
##root.geometry("570x400+30+30") 
##filemenu.add_command(label="New", command=NewFile)
##filemenu.add_command(label="Open...", command=OpenFile)
##filemenu.add_separator()
##filemenu.add_command(label="Exit", command=root.quit)
##
##helpmenu = Menu(menu)
##menu.add_cascade(label="Help", menu=helpmenu)
##helpmenu.add_command(label="About...", command=About)

file_lables = ['File in','File out','Globals']
file_entry = []
file_browes_buttons = []
file_name=''
i=0
for label in file_lables:
   file_entry.append(Entry(root))
   file_browes_buttons.append(tk.Button(text=str(i), fg="blue",command=BrowesFiles(file_name)))
   l = tk.Label(root, 
                text=label, 
                fg='Black')
   l.place(x = 20, y = 30 + i*30, width=120, height=25)
   file_entry[i].place(x=50,y = 32 + i*30, width=400, height=20)
   file_browes_buttons[i].place(x=500,y = 32 + i*30)
   i+=1

exit_button = tk.Button(text="QUIT", 
                   fg="red",
                   command=quit)
exit_button.pack(side=tk.BOTTOM)
root.mainloop()

