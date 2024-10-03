import os, shutil,sys, re
from pathlib import Path
import time, ui_kill_sort

path = ui_kill_sort.submit()

if path == '':
    print('closed')
    sys.exit()
    
source_path = Path(path)
#print(source_path)
delete_them = []
start = time.time()
num = 0


file_types = ['.mp3','.wav','.py','','.exe']

for file in source_path.glob('*'):
    if file.suffix.lower() not in file_types: # .lower because some file types are in Caps
        print(file.stem+file.suffix,end =' ')
        delete_them.append(file)
        print('would be deleted')
        num +=1

factor = input('\nAre you sure you want to delete all these files: y/n ')
print('\n')

if factor.lower() != 'y':
    salvage = True
    while salvage:
        save = Path(input('copy and paste a file to salvage: '))
        
        if str(save).lower() == 'y':
            break
        try:
            print(delete_them[delete_them.index(source_path/save)].stem,end = ' would NOT be delete\n')
            del delete_them[delete_them.index(source_path/save)]
            num -=1
        except ValueError:
            print('invalid file')

print('')
for file in source_path.glob('*'):
    if file in delete_them: # .lower because some file types are in Caps
        print(file.stem+file.suffix,end =' ')
        print('deleted')
        os.unlink(file)


end = time.time()
print('\n\n')

print('Took %s minutes to calculate.' %round(((end-start)/60),2))
print(f'{num} files deleted')

print('\ncontact  +233 53 502 9108 for assistance if any :)')
if (input('\nEnter q to quit: ')).lower() == 'q':
    print('done')



