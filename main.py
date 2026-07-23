from flask import Flask

app = Flask(__name__)

from markupsafe import escape
import json
from flask import request
from flask import make_response
import hashlib
from flask import make_response

from flask import abort, redirect, url_for


@app.route("/")

def root():
    html='''
    <dialog>hiii</dialog>
<p></p>
<form action ="/professors/search">
   <label for="query"></label>
   <input type="text" id="query" name="qu" placeholder="professor search"><hr>
   <input type="submit" value="Search!">
</form>'''
    if not("accounttoken" in request.cookies) or request.cookies.get("accounttoken")=="0":
          html+='''
<form action ="/login">
   <label for="query"></label>
   <input type="text" id="query" name="username" placeholder="username"><hr>

   <input type="text" id="query" name="password" placeholder="password"><hr>
   <input type="submit" value="Log in!">
</form>
<p>dont have an account? <a href="createaccountpage">make one!</a></p>

'''
    return html

@app.route('/createaccountpage')
def makeaccountpage():
    return '''
<form action ="/createaccount">
   <label for="query"></label>
   <input type="text" id="query" name="username" placeholder="username"><hr>

   <input type="text" id="query" name="password" placeholder="password"><hr>
   <input type="submit" value="Search!">
</form>
'''
@app.route('/createaccount')
def makeaccount():
    m=hashlib.sha256()
    tempf=open("users.json","r")
    tempdata=json.load(tempf)

    user=request.args.get('username')
    if not(user in tempdata["users"].keys()):
        password=request.args.get('password')
        tempdata["users"][user]=0
        m.update((user+"buffer"+password).encode('utf-8'))
        yum=str(m.digest())
        tempdata["accounts"][yum]={"name":user}
        tempf.seek(0)
        towrite=open("users.json","w")
        wstring=json.dumps(tempdata)


        towrite.write(str(wstring))
        towrite.close()
        return "<dialog open="">succesfully created!<a href='/'>go back</a></dialog>"
    else:
        return "<dialog open="">user already exists! <a href='/'>go back</a></dialog>"

        

@app.route('/cleartoken')
def cleart():
    resp = make_response(redirect(url_for('root')))
    resp.set_cookie('accounttoken', "0")
    return resp

@app.route('/login')
def login():
    m=hashlib.sha256()
    tempf=open("users.json","r")

  
    tempdata=json.load(tempf)
    user=request.args.get('username')
    password=request.args.get('password')
    m.update((user+"buffer"+password).encode('utf-8'))
    yum=str(m.digest())
    if yum in tempdata["accounts"].keys():
            
        resp = make_response(redirect(url_for('root')))
        resp.set_cookie('accounttoken', yum)
        return resp
    else:
        return "<dialog open="">login failed! <a href='/'>go back</a> "+"   "+"</dialog> "



@app.route('/professors/add')
@app.post('/professors/add')
def adding():
    professor = request.args.get('qu')
    data=open("users.json","r")
    data=json.load(data)
    if professor in data.keys():
        return "this professor already exists!"
    else:
        data[professor]=[]
        print(data)

        towrite=open("professors.json","w")
        wstring=json.dumps(data)

        towrite.write(wstring)
        towrite.close()

        return "<p>succesfully added!</p><p><a href=/professors/profile/"+professor+">See the new profile?</a></p>"



@app.route('/professors/search')
def searched():
    name = request.args.get('qu')
    return redirect(url_for('viewprof',professor=name))

@app.route('/professors/profile/<professor>')
def viewprof(professor):
    caninteract="accounttoken" in request.cookies and request.cookies.get("accounttoken")!="0"
    f=open("professors.json","r")

    data=json.load(f)
    html="<p></p><p> </p>"
    html+=""
    if professor in data.keys():

        for filler in data[professor]:
            html+="<p>rating:"+str(filler[0])+"</p><p>"+filler[1]+"</p>"
  
        
        if caninteract:
            html+='''
<form action ="/professors/profile/'''+professor+'''/review">
   <label for="query"></label>
   <input type="text" id="query" name="review" placeholder="review"><hr>
    <input type="text" id="query" name="rate" placeholder="rating (put a number out of five)"><hr>
   <input type="submit" value="Add!">
</form>
<p><a href='/'>go back</a></p>
'''

        return f'<p> {escape(professor)}</p>'+html
    else:
        html='''<p>professor not found!</p>'''
        if caninteract:
            html+='''<p>add them?</p>
<form action ="/professors/add">
   <label for="query"></label>
   <input hidden type="text" id="query" name="qu" value="'''+professor+'''"><hr>

   <input type="submit" value="Add!">
</form>'''
        else:
            html+=" (must be logged in to add professor)"
        return html



@app.route('/professors/profile/<profname>/review')
def addreview(profname):
    store=profname
    review = request.args.get('review')
    rating = request.args.get('rating')
    if store in data.keys():
        tempf=open("professors.json","r")
        towrite=open("professors.json","w")
        tempd=json.load(tempf)
        tempd[store].append(review)
        print(tempf)
        print(tempd)
        wstring=json.dumps(tempd)

        towrite.write(wstring)
        towrite.close()
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