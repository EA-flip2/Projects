# from urllib.request import Request
from fastapi import FastAPI,Request
from typing import List
from pathlib import Path
from tools import *

template_path = r"C:\Users\MAX\Documents\pyProjects\docsTest\jinjaTest\renders\Events_Update.docx"
workbook_path = r"C:\Users\MAX\Documents\pyProjects\docsTest\jinjaTest\renders\Nations.xlsx"
app = FastAPI()


@app.get("/getColumn")
def get_col(sheetName,colName):
    return get_name_site(workbook_path,sheetName,colName)

@app.get("/getColumn/title")
def getCol(columnName,col:int):
    return getRow(workbook_path,columnName,col_No=col)

@app.get("/getRow")
def get_(sheetName):
    return read_sheet_as_dicts(workbook_path,sheetName)

@app.get("/create_sheet")
def createSheet(sheetName):
    createSheet(workbook_path,sheetName)
    return {"status":"Done"}

@app.post("/apify_output")
async def apify_output(sheetName:str,request: Request):
    data = await request.json()
    # If a single dict is sent, wrap it in a list
    if isinstance(data, dict):
        data = [data]

    append_dict_list_to_sheet(workbook_path,sheetName, data)
    return {"status": "received", "count": len(data)}

@app.post("/append_output")
async def apify_output(sheetName,request: Request):
    data = await request.json()

    # If a single dict is sent, wrap it in a list
    if isinstance(data, dict):
        data = [data]

    append_dict_list_to_sheet(workbook_path, sheetName, data)
    return {"status": "received", "count": len(data)}

@app.get("/getData")
def get_data():
    raw_data = get_non_empty_rows(workbook_path,"Raw_Data")
    return rows_to_json(raw_data)

@app.post("/update_events")
def updateEvents(blocks):
    format_docs(blocks,template_path)
    return {"status":"done"}

@app.post("/add_blocks") #application/json
async def add_blocks(new:bool,request: Request):
    data = await request.json()  # Expecting a JSON array or single object

    blocks = []

    # If n8n sends a single object, wrap it in a list
    if isinstance(data, dict):
        data = [data]

    for item in data:
        block = Block(
            block_date=item.get("date"),
            block_time=item.get("time"),
            block_venue=item.get("venue"),
            block_organizer=item.get("organizer"),
            block_price=item.get("price"),
            block_title=item.get("title"),
            block_category=item.get("category"),
            block_content=item.get("details"),
            block_link=item.get("links", []),
        )
        blocks.append(block)  # ✅ append instead of extend

    format_docs(blocks,template_path=template_path,new=new)
    return {"status": "sucess"}
    # return{"status":"Ohk"}

@app.get("/clean/{sheetName}")
def cleanSheet(sheetName: str):
    clear_sheet_data(workbook_path, sheetName)
    return {"status":f"{sheetName} cleaned"}

@app.get("/deleteRepeatition")
def deleteRepeat(sheetName: str, target: str, depth: int = 2, target_col: int = 2):
    delete_rows_with_string(workbook_path,sheetName,target,depth,target_col)

    return {"sheetName": sheetName,"target":target}