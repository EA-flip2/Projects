from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from db_interface import *
from fastapi.staticfiles import StaticFiles



app = FastAPI()

# Mount the directory containing your media files
app.mount("/media", StaticFiles(directory="C:/Users/MAX/Documents/Blend/render"), name="media")

# Templates directory
templates = Jinja2Templates(directory="templates")

# Database connection details
conn_db = connect_db()  # open connection to dB

# Fetch file data from PostgreSQL
paths_to_html = read_file_path(conn_db)
#print(paths_to_html)

@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    files = paths_to_html
    return templates.TemplateResponse("index.html", {"request": request, "files": files})
