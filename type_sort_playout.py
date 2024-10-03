import os, shutil,sys, re
from pathlib import Path



######## FOR PLAYOUT  ###################

# create folder 
def move_file(file,type_,year,source_path):
    types = ['OTHERS','1_ENERGY NEWS','2_NEWS COMMENTARY', '3_BUSINESS NEWS', '4_GHANA TODAY']
    folder = types[type_]
    spec_path = Path(source_path /year/folder)
    
    if spec_path.exists() == False:
        #print(folder)
        spec_path.mkdir()
        
    shutil.move(source_path/file,spec_path)
    #print(source_path)
    #print('')


# Specific regex
##############################################
def news_comm(file_name):
    news_type = re.compile('''(
    (NEWS)
    (\s)?
    (COMMENTARY | COMM)
    )''',re.VERBOSE | re.IGNORECASE )
    
    sect = news_type.findall(file_name)
##    print(sect)
    try:
        k =sect[0][0] #very Important_pice
        return 2
    except:
        return 0
##############################
def bus_news(file_name):
    news_type = re.compile('''(
    (Business)
    (\s)
    (New)
    )''',re.VERBOSE | re.IGNORECASE )
    
    sect = news_type.findall(file_name)
##    print(sect)
    try:
        k =sect[0][0]
        return 3
    except:
        return 0
###############################
def energy_news(file_name):
    news_type = re.compile('''(
    (Energy)
    (\s)?
    (New)
    )''',re.VERBOSE | re.IGNORECASE )
    
    sect = news_type.findall(file_name)
##    print(sect)
    try:
        k =sect[0][0]
        return 1
    except:
        return 0
################################
def gt(file_name):
    news_type = re.compile('''(
    (GT|GHANA\sTODAY)
    (\s)
    (.*)
    )''',re.VERBOSE | re.IGNORECASE )
    
    sect = news_type.findall(file_name)
##    print(sect)
    try:
        k =sect[0][0]
        return 4
    except:
        return 0


##############################
def uniiq(file_name):
    news_type = re.compile('''(
    (UNIIQ|BUS )
    )''',re.VERBOSE | re.IGNORECASE )
    
    sect = news_type.findall(file_name)
##    print(sect)
    try:
        k =sect[0][0]
        return 3
    except:
        return 0
   
##############################################


def sort_type(file,year,source_path):
    if news_comm(file) == 2:
        # move to news_comm folder
        #print(file +' TO NEWS ',end = '')
        print(file)
        move_file(file, 2,year,source_path)
        return 2
        

    elif energy_news(file) == 1:
        # move to energy_news folder
        move_file(file,1,year,source_path)
        print(file)
        #print(file+' ENERGY ',end = '')
        return 1
        #

    elif bus_news(file) == 3 or uniiq(file) == 3:
        # move to bus_news folder
        move_file(file,3,year,source_path)
        #print(file+' BUSINESS ',end = '')
        print(file)
        return 3
        

    elif gt(file) == 4:
        # move to gt folder
        #print(file+' GHANA TODAY ',end = '')
        move_file(file,4,year,source_path)
        print(file)
        return 4
        
    else:
        #print('PART OF OTHERS ')
        #print(file + ' OTHERS')
        return 0












