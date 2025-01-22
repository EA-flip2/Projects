from fastapi import FastAPI, Path  

app = FastAPI()

inventory ={
    1:{'Belts': 'Gucci',
       "Pants": "Addidas",
       "Shoes": "Nike"
       },
    2:{
        "Car":"Ferrari",
        "Motor": "KAI",
        "Plane": "Boeing"
    }
}

@app.get("/")
def home():
    return {"Data": "Test"}

@app.get("/get_asset/{item_id}/{name}")
def get_asset( name: str,item_id:int):
    return inventory[item_id][str(name)]

@app.get("/get-by-name")
def get_item(name:str ):
    for key,val in inventory.items():
        if inventory[key][val] == name:
            return  inventory[key][val] 

    return {"Data":"Not Found"}
        

for key,val in inventory.items():
    if inventory[key][val] == 'KAI':
        print(inventory[key][val])