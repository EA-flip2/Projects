import sys,re,shutil,os
from pathlib import Path
import  type_sort_playout

months = ('January','February','March','April', 'May', 'June', 'July', 'August','Spetember', 'October','November','December')

# Create a folder to store them   #at the moment groups to just years
def search(source_path,src_path, year , month,suffix):
    
    file_name = src_path.stem+suffix
    
    year = '20'+ str(year)
    year_path = Path(source_path) / year
    month_path = Path(year_path / (months[int(month) - 1] + ' ' + year))
    #print(month_path)
    
    # create year folder
    if year_path.exists() == True:
        # move file to right location
        if spec_sort(source_path,file_name,year) == 0:
            move(src_path,month_path)
            print(file_name)
        
    else:
        
        # create folders
        year_path.mkdir() # year folder
        months_yr(year_path,year) # month folder
        
        # move file to right location
        if spec_sort(file_name,year) == 0:
            move(src_path,month_path)
            print(file_name)


# other files
def mov_others(source_path,file): # this is to move defective files to others
    other_path = Path(source_path / 'others')
    file_path = Path(source_path /file)
    #print(file_path,end = 'in mov_others\n')
    
    if not other_path.exists():
        other_path.mkdir()
        shutil.move(file_path, other_path)
    else:
        shutil.move(file_path, other_path)
##        pass
            
    print(file_path.stem,end = ' ')
    print('moved to others')  


# Specific_Sort
def spec_sort(source_path,file_name,year):
    sp_type = type_sort_playout.sort_type(file_name,year,source_path)
    return sp_type
    

# finding year and month
def yrs_months(file_name):
    yr_month = re.compile(r'''(
        (.*\s)?                # filename     
        (\d\d | \d)            # day
        (-|\s-|\s-\s)          # separator
        (\d\d | \d)            # month i4
        (-|\s-|\s-\s)          # separator
        (\d\d(\d\d)?)            # year i6
         )''',re.VERBOSE)
    # break into sections
    sect = yr_month.findall(file_name)
    # for full years
    x = 6
    if len(sect[0][6]) == 4:
        x = 7
    
    return [sect[0][4], sect[0][x],sect[0][2]] # [month,year,day]

# check format validity

def jx_name(file_name):
    yr_month = re.compile(r'''(
        (-)               # filename
         )''',re.VERBOSE)
    # break into sections
    sect = yr_month.findall(file_name)
    #print(sect)
    if len(sect) !=2:
        return 1 # error in name
    else:
        return 0



# move the to the right location
def move(src_path,file_path): 
    shutil.move(src_path,file_path)
##    pass
          

# create months folder
def  months_yr(year_path, year):
    for month in months:
        Path(year_path / (month + ' ' + year)).mkdir()


## delete files
def restrain(file):
    try:
        print(file.stem,end=' deleted\n')
        os.unlink(file)
        
    except Exception as e:
        errors.append(e)
        print(f"couldn't delete {file}")



def clear(delete_them,source_path):
    if len(delete_them) != 0:
        salvage = True
        print('These files would be deleted: ')
        print(*delete_them,sep='\n')
##        print(type(delete_them[0]))
        while salvage:
            save = Path(input('copy and paste a file to salvage: '))
            
            if str(save).lower() == 'y':
                break
            try:
                print(delete_them[delete_them.index(save)].stem,end = ' would NOT be delete\n')
                del delete_them[delete_them.index(save)]
            except ValueError:
                print('invalid file')
                

    print('\n\n')   
    for sound_byte in source_path.glob('*'):
        if sound_byte in delete_them:
            restrain(sound_byte)


