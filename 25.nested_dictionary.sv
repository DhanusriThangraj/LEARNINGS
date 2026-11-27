data = data[part] – Opening Boxes Inside BoxesThink of data like a big box that contains smaller boxes inside it.
data = data[part] simply means: "Open the smaller box named part, throw away the outer box, and hold only what is inside.
"Why Does It Look Confusing? (data on Both Sides)In Python, the = sign does not mean "equal" like in math. 
It means "take the value on the right side, and save it into the variable name on the left side.
"Pythondata = data[part]
#  ^         ^
#  |         |
#  |      2. Look inside the current box for 'part'
#  1. Replace 'data' with whatever was found inside
How It Works (Visual Box Analogy)Imagine your config.toml is a set of nested boxes:PlaintextBIG BOX (data)
 └── "database" box
      └── "port" box
           └── 5432
In Python, that looks like:Pythondata = {
    "database": {
        "port": 5432
    }
}
  
Now suppose we run Config.get("database.port").
  The loop splits "database.port" into two steps: ["database", "port"]. 
  Before the loop starts:data = {"database": {"port": 5432}} (You are holding the BIG BOX)
  Step 1: part = "database"Python runs data = data["database"]:   Right side (data["database"]): Opens the "database" box and finds {"port": 5432}.Left side (data = ...): You now hold only {"port": 5432}.data is now: {"port": 5432}
  Step 2: part = "port"Python runs data = data["port"]:   Right side (data["port"]): Opens the "port" box and finds 5432.Left side (data = ...): You now hold only 5432.data is now: 5432Loop finishes:return data hands back 5432!   
  Why cls._config_data Stays SafeNotice in your screenshot that right before the loop, your code wrote:Pythondata = cls._config_data
   Because data is a separate temporary variable, throwing away the outer boxes in data does not destroy cls._config_data. cls._config_data still keeps the whole big box intact for the next time you call Config.get()!   
