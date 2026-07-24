from flask import Flask, jsonify, render_template, send_from_directory

app = Flask(__name__,# Tells Flask where to look for Vue's compiled index.html
    template_folder="static",
    # Tells Flask where to look for CSS, JS, and image assets
    static_folder="static",
    # Removes the default URL prefix so files are served from the root
    static_url_path="")

#import libraries
from markupsafe import escape
import json
from flask import request
from flask import make_response
import hashlib
from flask import make_response

#load professor json from file into data
f=open("professors.json","r")
data=json.load(f)
f.close()

#load courses json from file into data
f=open("courses.json","r")
courseData=json.load(f)
f.close()
from flask import abort, redirect, url_for

@app.route("/dialog")

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

#creates user account from provided user json file
@app.route('/api/createaccount', methods=['POST']) 
def makeaccount():
    m=hashlib.sha256()
    response = {"status":"User already exists"}
    with open("users.json","r+") as tempf:
        tempdata=json.load(tempf)

        userFormData = request.form.get("user")
        userData = json.loads(userFormData)
        username=userData.get('username')
        if not(username in tempdata["users"].keys()):
            password = request.form.get('password')
            tempdata["users"][username]=userData
            m.update((username+"buffer"+password).encode('utf-8'))
            yum=str(m.digest())
            tempdata["accounts"][yum]={"name":username}
            tempf.seek(0)
            json.dump(tempdata,tempf)
            response = userData
        else:
            response = {"status":"User already exists"}
    return jsonify(response)
       

@app.route('/api/cleartoken')
def cleart():
    resp = make_response(redirect(url_for('root')))
    resp.set_cookie('accounttoken', "0")
    return resp

#checks login credentials and returns matching user if found 
@app.route('/api/login', methods=['POST'])
def login():
    m=hashlib.sha256()
    with open("users.json","r+") as tempf:
        tempdata=json.load(tempf)
        user=request.form.get('username')
        password=request.form.get('password')
        m.update((user+"buffer"+password).encode('utf-8'))
#returns validated user
    yum=str(m.digest())
    if yum in tempdata["accounts"].keys(): 
        resp = make_response('Login success')
        resp.set_cookie('accounttoken', yum)
        assocUsername = tempdata["accounts"][yum]["name"]
        return jsonify(tempdata["users"][assocUsername])
    else:
        return jsonify({status:'failed to login'}), 401


#professor object checked, and added if not found
@app.route('/api/professors/add', methods=['POST'])
def adding():
    professor = request.get_json()
    name = professor.get('name')
    profData = jsonify(professor)
    if name in data.keys():
        return "this professor already exists!"
    else:
        data[name]=professor
        print(data)
        temp=open("professors.json","r+")
        print(temp)
        temp.seek(0)
        json.dump(data,temp)
        temp.close()
        return profData



@app.route('/api/professors/search')
def searched():
    name = request.args.get('qu')
    return redirect(url_for('viewprof',professor=name))

#returns json of all professors
@app.route('/api/professors')
def getProfessors():
    f=open("professors.json","r+")
    data=json.load(f)
    f.close()
    return jsonify(data)

@app.route('/api/professors/profile/<professor>')
def viewprof(professor):
    caninteract="accounttoken" in request.cookies and request.cookies.get("accounttoken")!="0"
    f=open("professors.json","r+")
    data=json.load(f)
    f.close()
    if professor in data.keys():
        return jsonify([data[professor]])
    return jsonify([])


#professor review per user
@app.route('/api/professors/profile/<profname>/review', methods=['POST'])
def addreview(profname):
    review = request.get_json()
    user=review.get('user')
    ratings=review.get('ratings')
    professor=profname
    if professor in data.keys():
        tempf=open("professors.json","r+")
        tempd=json.load(tempf)
        tempd[professor]["ratings"][user]=ratings
        print(tempf)
        print(tempd)
 
        tempf.seek(0)
        json.dump(tempd,tempf)
        tempf.close()
        return jsonify(tempd[professor])
    else:
        return jsonify({status:"Unable to update rating"})

#Same thing, but now for courses

@app.route('/api/courses/add', methods=['POST'])
def addingCourse():
    course = request.get_json()
    name = course.get('name')
    cData = jsonify(course)
    if name in courseData.keys():
        return "this course already exists!"
    else:
        courseData[name]=course
        print(courseData)
        temp=open("courses.json","r+")
        print(temp)
        temp.seek(0)
        json.dump(courseData,temp)
        return cData



@app.route('/api/courses/search')
def courseSearched():
    name = request.args.get('qu')
    return redirect(url_for('viewCourse',course=name))

@app.route('/api/courses')
def getCourses():
    f=open("courses.json","r+")
    courseData=json.load(f)
    f.close()
    return jsonify(courseData)

@app.route('/api/courses/profile/<course>')
def viewCourse(course):
    caninteract="accounttoken" in request.cookies and request.cookies.get("accounttoken")!="0"
    f=open("courses.json","r+")
    courseData=json.load(f)
    f.close()
    if course in courseData.keys():
        return jsonify([courseData[course]])
    return jsonify([])



@app.route('/api/courses/profile/<coursename>/review', methods=['POST'])
def addCourseReview(coursename):
    review = request.get_json()
    user=review.get('user')
    print(user)
    ratings=review.get('ratings')
    print(ratings)
    course=coursename
    if course in courseData.keys():
        tempf=open("courses.json","r+")
        tempd=json.load(tempf)
        print(tempd[course])
        tempd[course]["ratings"][user]=ratings
        print(tempf)
        print(tempd)
 
        tempf.seek(0)
        json.dump(tempd,tempf)
        tempf.close()
        return jsonify(tempd[course])
    else:
        return jsonify({status:"Unable to update rating"})

@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def catch_all(path):
  if path != "":  # checks standard static files
    try:
      return send_from_directory(app.template_folder, path)
    except Exception:
      pass
  return render_template("index.html")









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