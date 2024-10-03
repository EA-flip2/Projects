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
root.title('J_sort')
root.iconbitmap('icon_sort.ico')
root.configure(bg = 'lightblue')


# global 
data = [0,0,0,'','']
file_types = ['.mp3','.wav','.pkf','.pk','all files']



# creating dropdown to select file type
_type = StringVar()
_type.set("all files")


sel_type = OptionMenu(root,_type,*file_types)
sel_type.place(x=500,y=7)



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

# Frames for date selection
dd_frame = Frame(root, width=30, height=30, borderwidth=2, relief=SUNKEN)
dd_frame.place(x=120, y=60)

mm_frame = Frame(root, width=30, height=30, borderwidth=2, relief=SUNKEN)
mm_frame.place(x=190, y=60)

yr_frame = Frame(root, width=50, height=30, borderwidth=2, relief=SUNKEN)
yr_frame.place(x=270, y=60)

# Function to create day entry

day_label = Button(dd_frame,text = 'DD')
day_label.grid(row=0, column=0)
day_entry = Entry(dd_frame, width=5)
day_entry.grid(row=0, column=1)

# Function to create month entry

month_label = Button(mm_frame,text = 'MM')
month_label.grid(row=0, column=0)
month_entry = Entry(mm_frame, width=5)
month_entry.grid(row=0, column=1)

# Function to create year entry
yr_label = Button(yr_frame,text = 'YY')
yr_label.grid(row=0, column=0)
yr_entry = Entry(yr_frame, width=7)
yr_entry.grid(row=0, column=1)

# Submit entries
def submit():
    print(data)
    return data
    
    
# Function triggered by the GO button
def go(day,month,year,src,sel_file):
    # Perform actions with the selected source directory, file type, and date
    global data
    data= [day.get(),month.get(),year.get(),src.get(),sel_file.get()]#,src.get()
    submit()
    root.destroy()
    
    

# GO button to execute the action
go_button = Button(root, text='GO',command = lambda:go(day_entry,month_entry,yr_entry,src_dir,_type))#, command=lambda:cal(31,root))
go_button.place(x=500, y=80)

root.mainloop()
