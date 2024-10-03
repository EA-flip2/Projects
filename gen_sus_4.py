##import os, shutil,sys, re
##from pathlib import Path
import Sort_v3
##import time

##As a precaution always start with wav files and check to make sure the
##desired results are gotten, before working with mp3 files

# Global variables
data = Sort_v3.submit()
day_,month_,yr_ ,source_path,_type= data
source_path = Path(source_path) #if source_path has a problem, it defaults to '.' which is the cwd
num = 0
del_num = 0
errors = []
delete_them = []
file_names = []

file_types = ['.mp3','.wav','.pkf','.pk']
file_type = []

if _type == 'all files':
    file_type = file_types
else:
    if _type == '':
        print('close')
        sys.exit() # '' is the file extension of a folder this is to stop sorting folders
    file_type.append(_type)


# get files
for sound_byte in source_path.glob('*'):
    if sound_byte.suffix.lower() in file_type:
        file_names.append(sound_byte.stem + sound_byte.suffix)
        num +=1


# move file to right location
start = time.time() #### start Timer
for file in file_names:
    try:
        src_path = source_path / file # actual file path  

        if jx_name(file) == 1:
            try:
                mov_others(source_path,file)
            except Exception as e:
                errors.append(e)
                delete_them.append(src_path)
                print(file,end = ' ')
                print('would be deleted')
                del_num +=1
                #print(src_path)

            continue
            print('%%%%%%%%%%%%%%%%%%') #this was just to know if continue works
                
        #print(source_path)    
            
        # find month and year
        try:
            yr_month = yrs_months(file)
               
            #print(file)
            #try:
            if int(yr_month[0]) == int(month_) and yr_month[1] == yr_: # yr_month[0] = month  and yr_month[1] = year
                if int(yr_month[2]) <= int(day_):
                    try:
                        search(source_path,src_path,yr_month[1],yr_month[0],Path(file).suffix)
                    except Exception as e:
                        errors.append(e)
                        delete_them.append(src_path)
                        print(file,end = ' ')
                        print('would be deleted')
                        del_num +=1
                        #os.unlink(src_path)  # delete file which can't be move because of duplication
                        continue
                    #print(yr_month[2]+' '+file)
        except IndexError:
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

