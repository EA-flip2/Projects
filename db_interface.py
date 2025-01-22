import psycopg2

def connect_db():
    try:
        conn = psycopg2.connect(
            dbname = 'blender_journal',
            user = 'emma',
            password = 'password',
            host = 'localhost',
            port = '5432'
        )
        return conn
    except Exception as e:
        print(f"Error connection to database:{e}")
        return None
    


def insert_record(conn, file_name ,file_exe , file_size,dtm,rfile_path):
    
    cur =conn.cursor() 
    query = """
        INSERT INTO render_data.file_data (file_name,file_exe,file_size,date_modified,path)
        VALUES (%s,%s,%s,%s,%s);
        """
    cur.execute(query,(file_name,file_exe,file_size,dtm,rfile_path))

    conn.commit()

