from flask import Flask

app = Flask(__name__)

from markupsafe import escape
import json
from flask import request
from flask import make_response
import hashlib

f=open("professors.json","r+")
data=json.load(f)
print(data)
f.seek(0)
json.dump(data,f)
from flask import abort, redirect, url_for
m=hashlib.sha256()


@app.route("/")

def root():
    return '''
<p></p>
<form action ="/professors/search">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="professor search"><hr>
   <input type="submit" value="Search!">
</form>

<form action ="/login">
   <label for="query"></label>
   <input type="text" id="query" name="u" placeholder="username"><hr>

   <input type="text" id="query" name="p" placeholder="password"><hr>
   <input type="submit" value="Search!">
</form>

'''


@app.route('/login')
def login():
    resp = make_response()
    resp.set_cookie('username', 'the username')
    return redirect(url_for('root'))



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
            html+="<p>rating:"+str(filler[0])+"</p><p>"+filler[1]+"</p>"
  
  
        html+='''
<form action ="/professors/profile/'''+professor+'''/review">
   <label for="query"></label>
   <input type="text" id="query" name="review" placeholder="review"><hr>
    <input type="text" id="query" name="rate" placeholder="rating (put a number out of five)"><hr>
   <input type="submit" value="Add!">
</form>
'''

        return f'<p> {escape(professor)}</p>'+html
    else:
        return '''
    <p>professor not found! add them? (must be logged in to add professor)</p>
<form action ="/professors/add">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="add professor"><hr>
   <input type="submit" value="Add!">
</form>'''


@app.route('/professors/profile/<profname>/review')
def addreview(profname):
    store=profname
    review = request.args.get('review')
    rating = request.args.get('rating')
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










@app.route('/test')
def test():
    return'''


<html>
<head runat="server">
    <title></title>
    <asp:ContentPlaceHolder ID="head" runat="server">
    </asp:ContentPlaceHolder>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ContentPlaceHolder ID="ContentPlaceHolder1" runat="server">
                <asp:HyperLink ID="HomeLink" runat="server" NavigateUrl="~/default.aspx">Home</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="RegLink" runat="server" NavigateUrl="~/register.aspx">Register</asp:HyperLink>
&nbsp;|
                <asp:HyperLink ID="LoginLink" runat="server" NavigateUrl="~/login.aspx">Login</asp:HyperLink>
&nbsp;|&nbsp;&nbsp;&nbsp;
                <table style="width:100%;">
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
&nbsp;
            </asp:ContentPlaceHolder>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
    </form>
</body>
</html>
'''