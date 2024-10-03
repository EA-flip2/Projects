from tkinter import *
from tkinter.simpledialog import askinteger
from tkinter.filedialog import askdirectory
import time
from functions_ import*


root = Tk()

# set maximum window size value
root.maxsize(400, 200)

 
# set minimum window size value
root.minsize(200, 80)

# Adjust size
root.geometry("200x80")

## style
root.title('J_Sort')
root.iconbitmap('icon_sort.ico')
##root.configure(bg = 'lightblue')

##instructions
guide ='''Guide\nSort would put files in the right places upto the inputed day;\nrequires an acurate date, month & year to operate at a valid path\n
Kill would delete all files which are not ['.mp3','.wav','.py','.exe','']\n
All would put all files in the right places
contact  +233 53 502 9108 for assistance if any :)
'''

instructions = Label(root, text = guide, bg = 'lightgreen').place( x = 0, y = 65)

# fuctions
def sort():
    root.destroy()
    with open('gen_sus_4.py') as file:
        exec(file.read())
        

def kill():
    root.destroy()
    with open('ulx.py') as file:
        exec(file.read())

def s_all():
    root.destroy()
    with open('all.py') as file:
        exec(file.read())
               

# Tasks

sort_task = Button(root,text = 'SORT', command = sort)
sort_task.place(x= 25,y = 20)
kill_task = Button(root,text = 'KILL', command = kill)
kill_task.place(x= 85,y = 20)
kill_task = Button(root,text = 'All', command = s_all)
kill_task.place(x= 145,y = 20)


root.mainloop()

##with open('f1.py') as file:
##    exec(file.read())
import type_sort_playout
import Sort_v3
import ui_kill_sort
