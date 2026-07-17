from flask import Flask

app = Flask(__name__)

from markupsafe import escape
import json
from flask import request

f=open("professors.json","r+")
data=json.load(f)
print(data)
f.seek(0)
json.dump(data,f)
from flask import abort, redirect, url_for
@app.route("/")

def root():
    return '''
<p></p>
<form action ="/professors/search">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="professor search"><hr>
   <input type="submit" value="Search!">
</form>
<form action ="/professors/add">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="add professor"><hr>
   <input type="submit" value="Add!">
</form>
'''





@app.route('/professors/add')
@app.post('/professors/add')
def adding():
    professor = request.args.get('qu')
    if professor in data.keys():
        return "this professor already exists!"
    else:
        data[professor]=[]
        print(data)
        f.seek(0)
        json.dump(data,f)
        temp=open("professors.json","r+")
        print(temp)
        temp.seek(0)
        json.dump(data,temp)
        return "succesfully added!"



@app.route('/professors/search')
def searched():
    name = request.args.get('qu')
    return redirect(url_for('viewprof',professor=name))

@app.route('/professors/profile/<professor>')
def viewprof(professor):
    f=open("professors.json","r+")
    data=json.load(f)
    html="<p></p><p> </p>"
    if professor in data.keys():

        for filler in data[professor]:
            html+="<p>"+filler+"</p>"
  
  
        html+='''
<form action ="/professors/profile/'''+professor+'''/review">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="add review"><hr>
   <input type="submit" value="Add!">
</form>
'''
        return f'<p> {escape(professor)}</p>'+html
    else:
        return "professor not found!"

@app.route('/professors/profile/<profname>/review')
def addreview(profname):
    store=profname
    review = request.args.get('qu')
    if store in data.keys():
        tempf=open("professors.json","r+")
        tempd=json.load(tempf)
        tempd[store].append(review)
        print(tempf)
        print(tempd)
 
        tempf.seek(0)
        json.dump(tempd,tempf)
        return redirect(url_for("viewprof",professor=store))
    else:
        return "professor not found"