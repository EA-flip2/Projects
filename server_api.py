from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from db_interface import connect_db, read_file_path

app = FastAPI()

@app.get("/", response_class=HTMLResponse)
async def read_root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request, "message": "Hello, World!"})


# Templates directory
templates = Jinja2Templates(directory="templates")



# Database connection details
conn_db = connect_db()
# Fetch file data from PostgreSQL
path_files = read_file_path(conn_db)



@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    files = path_files
    return templates.TemplateResponse("index.html", {"request": request, "files": files})
