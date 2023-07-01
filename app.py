import math
from flask import Flask, render_template,request,session,redirect,flash
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from flask_mail import Mail
import json
from werkzeug.utils import secure_filename
import os
import pymysql
pymysql.install_as_MySQLdb()

with open('templates/config.json', 'r') as c:
    params = json.load(c)['params']

# local_server=True
local_server=False

app = Flask(__name__)
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)
mail=Mail(app)
app.secret_key='super-secret-key'
app.config['UPLOAD_FOLDER']=params['upload_location']
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db: SQLAlchemy = SQLAlchemy(app)



class Contact(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    p_no = db.Column(db.String(13), unique=True, nullable=False)
    msg = db.Column(db.String(120), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)
    email = db.Column(db.String(120), unique=False, nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), unique=False, nullable=False)
    tagline = db.Column(db.String(120), unique=True, nullable=False)
    slug = db.Column(db.String(30), unique=True, nullable=False)
    content = db.Column(db.String(12000), unique=False, nullable=False)
    author = db.Column(db.String(50), unique=True, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)
    img_file= db.Column(db.String(12), unique=False, nullable=False)

class Contribute(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    email = db.Column(db.String(120), unique=False, nullable=False)
    p_no = db.Column(db.String(13), unique=True, nullable=False)
    title = db.Column(db.String(100), unique=False, nullable=False)
    tagline = db.Column(db.String(120), unique=True, nullable=False)
    content = db.Column(db.String(12000), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)


@app.route("/")
def home():
    post = Posts.query.filter_by().all()
    last=math.ceil(len(post)/int(params['no_of_posts']))
    #return str(last)
    page=request.args.get('page')
    if not (str(page)).isnumeric():
        page=1

    page=int(page)
    post=post[(page-1)*int(params['no_of_posts']):((page-1)*int(params['no_of_posts']))+int(params['no_of_posts'])]
    if last==1:
        prev = "#"
        next = "#"
    elif page<=1:
        prev="#"
        next="/?page="+ str(page+1)
    elif page>=last:
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template("index.html",params=params,post=post,prev=prev,next=next)


@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if ('user' in session and session['user']==params['admin_name']):
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)#c1

    if request.method == "POST":
        username = request.form.get("uname")
        userpass = request.form.get("upass")
        if username == params['admin_name'] and userpass == params['admin_password']:
            # set the session variable
            session['user'] = username
            posts=Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)#c2

    return render_template("login.html", params=params)


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect("/dashboard")


@app.route("/about")
def about():
    return render_template("about.html",params=params)


@app.route("/edit", methods=['GET', 'POST'])
def edit_show():
    if ('user' in session and session['user'] == params['admin_name']):
        posts = Posts.query.all()
        return render_template("show_files_to_be_edited.html", params=params, posts=posts)#c3

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if "user" in session and session['user'] == params['admin_name']:
        if request.method == "POST":
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            author= request.form.get('author')
            date = datetime.now()

            if sno == '0':
                f = request.files['uploaded_file']
                f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
                post = Posts(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date,author=author)
                db.session.add(post)
                db.session.commit()
            else:
                post=Posts.query.filter_by(sno=sno).first()
                post.title=box_title
                post.tagline=tline
                post.slug=slug
                post.content=content
                post.img_file=img_file
                db.session.commit()
                return redirect('/edit/'+sno)

        post=Posts.query.filter_by(sno=sno).first()
        return render_template("edit.html", params=params, sno=sno, post=post)#c4

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if "user" in session and session['user'] == params['admin_name']:
        post=Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/dashboard")

@app.route("/contributor_delete/<string:sno>", methods=['GET', 'POST'])
def contributer_delete(sno):
    if "user" in session and session['user'] == params['admin_name']:
        post=Contribute.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/dashboard")

@app.route("/contact", methods=['GET','POST'])
def contact():
    if(request.method=='POST'):
        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        message=request.form.get('message')

        entry=Contact(name=name,p_no=phone,msg=message, email=email,date=datetime.now())

        db.session.add(entry)
        db.session.commit()
        mail.send_message(
            'New message from '+ name,
            sender=email,
            recipients=[params['gmail-user']],
            body=message+"\n"+phone
        )

    return render_template("contact.html",params=params)

@app.route("/contribute", methods=['GET','POST'])
def contribute():
    if(request.method=='POST'):
        name=request.form.get('name')
        email=request.form.get('email')
        phone=request.form.get('phone')
        title=request.form.get('title')
        tline=request.form.get('tline')
        content = request.form.get('content')


        entry=Contribute(name=name, email=email, p_no=phone, title=title, tagline=tline, content=content, date=datetime.now())

        db.session.add(entry)
        db.session.commit()
        mail.send_message(
            'New contribution from '+ name,
            sender=email,
            recipients=[params['gmail-user']],
            body="Title: "+title+"\n"+ "Content: "+content
        )
    return render_template("contribute.html",params=params)

@app.route("/contributor_posts_show", methods=['GET', 'POST'])
def contribution_show():
    if ('user' in session and session['user'] == params['admin_name']):
        posts = Contribute.query.all()
        return render_template("contributor_posts_show.html", params=params, posts=posts)

@app.route("/contributor_edit/<string:sno>", methods=['GET', 'POST'])
def contributor_edit(sno):
    if "user" in session and session['user'] == params['admin_name']:
        if request.method == "POST":
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')

            post=Contribute.query.filter_by(sno=sno).first()
            post.title=box_title
            post.tagline=tline
            post.slug=slug
            post.content=content
            post.img_file=img_file
            db.session.commit()
            return redirect('/contributor_edit/'+sno)

        post=Contribute.query.filter_by(sno=sno).first()
        return render_template("contributor_edit.html", params=params, sno=sno, post=post)

@app.route("/contributor_show/<string:sno>",methods=['GET'])
def contributor_show(sno):
    post=Contribute.query.filter_by(sno=sno).first()#Contribute is class name
    return render_template("contributor_show.html",params=params,post=post)


@app.route("/post/<string:post_slug>",methods=['GET'])
def post_route(post_slug):
    post=Posts.query.filter_by(slug=post_slug).first()#Posts is class name
    return render_template("post.html",params=params,post=post)


app.run(debug=True)
