from openpyxl import Workbook,load_workbook
import json
import os
from datetime import date
from docx import Document
from docx.shared import Pt
from docx2pdf import convert
# from openpyxl import load_workbook

def createFile(*sheets,name): #create new xl file with sheets
    wb = Workbook()	

    if len(sheets) != 0:
        try:
            default_sheet = wb["Sheet"]
            wb.remove(default_sheet)
        except Exception:
            pass
        for sheet_name in sheets:
            wb.create_sheet(title=sheet_name)
    else:
        # print(len(sheets))
        ws = wb.active
        ws.title = name

    wb.save(name+".xlsx")
    
def createSheet(workbook_path, *sheets): #path = 'C:\\Windows\\System32\\calc.exe'
    #load the existing workbook
    wb = load_workbook(workbook_path)

    if len(sheets) != 0:
        for sheet_name in sheets:
            wb.create_sheet(title=sheet_name)

    wb.save(workbook_path)
    # print(workbook_path)

def deleteSheet(workbook_path, *sheets):
        #load the existing workbook
    wb = load_workbook(workbook_path)

    if len(sheets) != 0:
        for sheet_name in sheets:
            thisSheet = wb[sheet_name]
            wb.remove(thisSheet)

    wb.save(workbook_path)

def getRow(workbook_path,sheetName, col_No= 1):
    
    wb = load_workbook(workbook_path)
    sheet = wb[sheetName]
    values = []
    for value in sheet.iter_rows(min_row=2,max_row=sheet.max_row,min_col=col_No,max_col=col_No,values_only=True):
        values.append(value[0])
        # print(value)
    return values

def getColumn(workbook_path,sheetName,colName):
    
    wb = load_workbook(workbook_path)
    sheet = wb[sheetName]


    # find column index by matching header
    col_index = None
    for idx, cell in enumerate(sheet[1], start=1):  # row 1 = header
        if cell.value == colName:
            col_index = idx
            break

    if col_index is None:
        print(f"Column '{colName}' not found.")
        return []

    # get all values in that column (from row 2 down)
    values = [row for row in sheet.iter_rows(
        min_row=2, min_col=col_index, max_col=col_index, values_only=True
    )]

    return sheet.max_row

def get_name_site(workbook_path,sheetName,colName):
    
    wb = load_workbook(workbook_path)
    sheet = wb[sheetName]


    # find column index by matching header
    col_index = None
    for idx, cell in enumerate(sheet[1], start=1):  # row 1 = header
        if cell.value == colName:
            col_index = idx
            break

    if col_index is None:
        print(f"Column '{colName}' not found.")
        return []

    # get all values in that column (from row 2 down)
    values = []

    for row in sheet.iter_rows(
        min_row=2, min_col=1, max_col=col_index, values_only=True
    ):
     values.append({row[0]:row[1]})
        
    #print(values)
    wb.close()
    return values

def read_sheet_as_dicts(workbook_path, sheet_name):
    wb = load_workbook(workbook_path, data_only=True)
    sheet = wb[sheet_name]

    # Get headers (first row)
    headers = [cell.value for cell in sheet[1]]

    data = []
    # Iterate rows starting from 2 (skip header)
    for row in sheet.iter_rows(min_row=2, values_only=True):
        if any(row):  # skip completely empty rows
            row_dict = {headers[i]: row[i] for i in range(len(headers))}
            data.append(row_dict)

    wb.close()
    return data

def find_title_index(workbook_path, sheetName,colName ):
    wb = load_workbook(workbook_path)
    sheet = wb[sheetName]


    # find column index by matching header
    col_index = None
    for idx, cell in enumerate(sheet[1], start=1):  # row 1 = header
        if cell.value == colName:
            col_index = idx
            break
    return col_index

def append_dict_list_to_sheet(workbook_path, sheet_name, data_list):
    wb = load_workbook(workbook_path)
    sheet = wb[sheet_name]

    if not data_list:
        print("No data to add.")
        return

    # Extract headers from the first dictionary
    headers = list(data_list[0].keys())

    # If sheet is empty, write headers first
    if sheet.max_row == 1 and all(cell.value is None for cell in sheet[1]):
        sheet.append(headers)

    # Add each dictionary as a row
    # for item in data_list:
    #     row = [item.get(header, "") for header in headers]
    #     sheet.append(row)
    
    # Add each dictionary as a row
    for item in data_list:
        # Flatten any list values into comma-separated strings
        row = [
            ", ".join(map(str, item.get(header, []))) if isinstance(item.get(header), list)
            else item.get(header, "")
            for header in headers
        ]
        sheet.append(row)

    wb.save(workbook_path)
    wb.close()
    return {"status":"Done"}
    #print(f"✅ Added {len(data_list)} rows to '{sheet_name}'.")

def get_non_empty_rows(workbook_path, sheet_name):
    wb = load_workbook(workbook_path, data_only=True)
    sheet = wb[sheet_name]

    rows_with_data = []
    for row in sheet.iter_rows(values_only=True):
        # only add if at least one cell in the row has a value
        if any(cell is not None and str(cell).strip() != "" for cell in row):
            rows_with_data.append(list(row))
    wb.close()
    return rows_with_data

def rows_to_json(row_data):
    if not row_data:
        return []

    headers = row_data[0]  # first row = keys
    data_rows = row_data[1:]

    json_list = []
    for row in data_rows:
        # zip headers with row values
        item = {header: value for header, value in zip(headers, row)}
        json_list.append(item)
    
    return json_list

class Block:
    def __init__(self,block_date,block_time,block_venue,block_organizer,block_price, block_title, block_category, block_content, block_link):
        self.date = date.today().strftime("%d %B, %Y")  # e.g., "07 October, 2025"
        self.title = block_title
        self.event_date = block_date
        self.time = block_time
        self.venue = block_venue
        self.price = block_price
        self.organizer = block_organizer
        self.cat   = block_category
        self.content = block_content
        self.links = block_link  # list of strings

    def to_dict(self):
        """Return JSON-serializable dict"""
        return self.__dict__

def format_docs(blocks, template_path, new = False):
    # Load an existing Word document if template_path is provided, else create new
    if template_path and os.path.exists(template_path):
        doc = Document(template_path)
        save_path = template_path  # Overwrite the template file
    else:
        doc = Document()
        save_path = template_path  # Save new file at the template_path

    if new:
        doc = Document()
        save_path = template_path 

    # Add main heading (date)
    doc.add_heading(f"EVENTS UPDATE ({blocks[0].date})", level=2)
    doc.add_heading(f"category: {blocks[0].cat}")
    doc.add_paragraph("")

    # Add each block
    for block in blocks:
        # Title (bold)
        title_paragraph = doc.add_paragraph()
        run = title_paragraph.add_run(block.title)
        run.bold = True
        run.font.size = Pt(12)

        # Content
        doc.add_paragraph(block.content)

        # Summary
        summary_paragraph = doc.add_paragraph()
        summary_paragraph.add_run("Summary")
        for key, value in block.__dict__.items():
            if key != "content":  # Skip the main content since it’s already printed
                summary_paragraph.add_run(f"\n{key}: {value}")

 
        # Extra spacing between blocks
        doc.add_paragraph("")

    # Ensure the directory exists
    os.makedirs(os.path.dirname(save_path), exist_ok=True)

    # Save the DOCX to the template_path
    doc.save(save_path)

    # Convert to PDF (same name, .pdf extension)
    pdf_path = save_path.replace(".docx", ".pdf")
    convert(save_path, pdf_path)


    # print(f"✅ Document created at: {save_path}")
    # print(f"✅ PDF created at: {pdf_path}")

def clear_sheet_data(workbook_path, sheet_name):
    wb = load_workbook(workbook_path)

    if sheet_name not in wb.sheetnames:
        return {"error": f"Sheet '{sheet_name}' not found in workbook."}

    sheet = wb[sheet_name]

    # Delete all rows except the first (keep headers)
    if sheet.max_row > 1:
        sheet.delete_rows(2, sheet.max_row - 1)

    wb.save(workbook_path)
    wb.close()
    return {"status": f"Cleared all data in '{sheet_name}' except headers."}

def deleteRow(workbook_path, sheet_name):
    # Load the workbook
    wb = load_workbook(workbook_path)

    # Select the sheet
    ws = wb[sheet_name]  # or wb.active

    # Delete a specific row (e.g., row 5)
    ws.delete_rows(1)

    # Save the workbook
    wb.save(workbook_path)

def delete_rows_with_string(file_path, sheet_name, target_string,depth = 2,target_col = 2):
    """
    Deletes all rows in the specified sheet that contain target_string anywhere.
    """
    wb = load_workbook(file_path)
    ws = wb[sheet_name]

    # Find row indices that contain the target string
    rows_to_delete = []
    for row_idx, row in enumerate(ws.iter_rows(min_col=target_col,max_col=target_col,values_only=True), start=1):
        for cell in row:
            if cell is not None and target_string in str(cell):
                rows_to_delete.append(row_idx)
                break  # stop checking other cells in the same row
    

    # Delete rows (bottom to top to avoid shifting issues)
    for r in sorted(rows_to_delete, reverse=True):
        # print(r)
        if len(rows_to_delete) > depth:
            ws.delete_rows(r)
            rows_to_delete.pop(rows_to_delete.index(r))
        else:
            break

    wb.save(file_path)
    wb.close()

def getNumber(workbook_path,sheet_name):
    # Load the workbook
    wb = load_workbook(workbook_path)

    # Select the sheet
    ws = wb[sheet_name] 

    return ws.max_row


# # Example data
# blocks = [
#     Block("Event 1", "This is the first event description.", ["http://example.com/1"]),
#     Block("Event 2", "This is the second event description.", ["http://example.com/2", "http://example.com/3"]),
# ]


########################################
# PORT REPORT TOOLS

class Record():

    def __init__(self,company,asset,tracker,sim,line,fc,tech):
        self.company = company
        self.asset = asset
        self.cordinator = fc
        self.tracker_imei = tracker+
        self.sim_imei = sim
        self.phone_line = line
        self.technician = tech
    
    def to_dict(self):
        """Return JSON-serializable dict"""
        return self.__dict__

def creatNewReport(sheetName,fileName,titles):
    path = fr'C:\Users\MAX\Documents\pyProjects\docsTest\jinjaTest\ports_report\{fileName}.xlsx'
    #create workbook
    wb = Workbook()
    #add sheet
    ws = wb.active
    ws.title = sheetName
    #add titles
    for i in range(1, len(titles) + 1):
        ws.cell(row=1, column=i).value = titles[i - 1]

    wb.save(path)
    wb.close


    #load file
    #select sheet 
    #pass data
    #save and close


