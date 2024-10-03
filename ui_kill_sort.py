from tkinter import *
from tkinter.simpledialog import askinteger
from tkinter.filedialog import askdirectory
import sys

root = Tk()

# Adjust size
root.geometry("400x400")
 
# set minimum window size value
root.minsize(600, 150)
 
# set maximum window size value
root.maxsize(600, 150)

## style
root.title('J_aux')
root.iconbitmap('icon_sort.ico')
##root.configure(bg = 'lightcoral')

# Function to ask for source directory
def src(src_entry):
    global source_dir
    source_dir = askdirectory()
    src_entry.delete(0,END) #clear entry before replacing it
    src_entry.insert(0,source_dir)


# Label for source directory
source_label = Label(root, text='Source Directory:')
source_label.place(x=10, y=10)

# Entry for source directory path
src_dir = Entry(root, width=50, borderwidth=4)
src_dir.place(x=120, y=10)

# Button to trigger source directory selection
drop_dir = Button(root, text='Browse', command=lambda:src(src_dir))
drop_dir.place(x=450, y=9)


def submit():
    #print(data,end =' is the working directory where files would be seleted\n')
    return data


# Function triggered by the GO button
def go(src):
    # Perform actions with the selected source directory, file type, and date
    global data
    data = src.get()
    submit()
    root.destroy()
    
    

# GO button to execute the action
go_button = Button(root, text='GO',command = lambda:go(src_dir))#, command=lambda:cal(31,root))
go_button.place(x=500, y=80)

root.mainloop()
