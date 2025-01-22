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

def read_file_path(conn):
    cur = conn.cursor() 
    paths = []
    query = """
            select file_size from render_data.file_data;
"""
    file_paths =cur.execute(query)

    # Fetch all results
    file_paths = cur.fetchall()

   # Append file paths to the list
    for row in file_paths:
        paths.append(row[0])

    print(paths)
    return paths



conn_db = connect_db()

if conn_db:
    a = read_file_path(conn_db)
    print(type(a))
