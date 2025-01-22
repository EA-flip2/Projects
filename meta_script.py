#libraries
from pathlib import Path
from datetime import datetime
import os, time
import psycopg2

from db_interface import *

# parameters
local_data = {}
file_types =[]
file_exe = []

#Db connection



# file Meta Data
def file_name(file_path):   
    return file_path.stem

def file_exet(file_path):   
    return file_path.suffix

def file_size(file_path):
    return os.path.getsize(file_path)

def get_date_time(file_path):
    creation_time = os.path.getctime(file_path)
    #readable_creation_time = time.ctime(creation_time) # human readable
    creation_datetime = datetime.fromtimestamp(creation_time)
    psql_format = creation_datetime.strftime("%Y-%m-%d %H:%M:%S")
    return psql_format
    #print(f'file was created on : {psql_format}')


# scan files for metadata
def push_file_data():
    pass
    #file_name
    #file_type
    #file_size
    #date_modified

def local_file_data(src_path):
    n = 1
    for file in src_path.glob('*'):
        local_data.setdefault(n,(
        file_name(file),
        file_exet(file),
        file_size(file),
        get_date_time(file),
        str(file)))
        n += 1

#def update_data():



# main{}
conn_db = connect_db()  # open connection to dB

a = input('enter path: ')
local_file_data(Path(a))


if conn_db:
    for i in local_data:
        k = i
        #print(local_data[i][0])
        insert_record(conn_db,local_data[k][0],local_data[k][1],
                      local_data[k][2],local_data[k][3],local_data[k][4]) # updating local data base



#print(local_data)
