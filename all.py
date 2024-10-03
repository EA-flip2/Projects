##import os, shutil,sys, re
##import type_sort_playout
##from pathlib import Path
import ui_kill_sort

##As a precaution always start with wav files and check to make sure the
##desired results are gotten, before working with mp3 files

# Global variables
path = ui_kill_sort.submit()
print(path,end =' at all\n')

num = 0
del_num = 0
errors = []
delete_them =[]

if path == '':
    print('closed')
    sys.exit()
    
source_path = Path(path)
#print(source_path)
#if source_path has a problem, it defaults to '.' which is the cwd


file_names = []
#months = ('January','February','March','April', 'May', 'June', 'July', 'August','Spetember', 'October','November','December')

file_type = ['.mp3','.wav','.pkf','.pk']

# Functionalities


# ask year
####################################

# get files
for sound_byte in source_path.glob('*'):
    if sound_byte.suffix.lower() in file_type:
        file_names.append(sound_byte.stem + sound_byte.suffix)
        num += 1


# move file to right location
start = time.time() #### start Timer
for file in file_names:
    try:
        src_path = source_path / file # actual file path  

        if jx_name(file) == 1: #point 1
            try:
                mov_others(source_path,file)
            except Exception as e:
                del_num +=1
                errors.append(e)
                delete_them.append(src_path)
                print(file,end = ' ')
                print('would be deleted')
                #print(f"An error occured at 1: {e}")
            continue
            print('%%%%%%%%%%%%%%%%%%') #this was just to know if continue works
                
            
            
        # find month and year
        try:
            yr_month = yrs_months(file)
            try:
                search(source_path,src_path,yr_month[1],yr_month[0],Path(file).suffix)
                print(file)
            except Exception as e:
                #print(f"An error occured at point 3 : {e}")
                del_num +=1
                errors.append(e)
                delete_them.append(src_path)
                print(file,end = ' ')
                print('would be deleted') 
                continue
        except IndexError:
            errors.append(e)
            continue
    except Exception as e:
        errors.append(e)
        continue
    
end = time.time()


##delete files
try:
    clear(delete_them,source_path)
except Exception as e:
    errors.append(e)
    



print('\nChallenges: ')
print(errors)
print('')

print(f'{num} files worked with, {del_num} delete')

print('\ncontact  +233 53 502 9108 for assistance if any :)')
print('Took %s minutes to calculate.\n' %round(((end-start)/60),2))
if (input('\nEnter q to quit: ')).lower() == 'q':
    print('done')
