#!/usr/bin/env python

import pyrebase
from datetime import datetime
fmt="%d/%m/%Y %H:%M:%S"
firebaseconfig = {
        "apiKey": "AIzaSyCcHshsJr7GXkyIaFOFRgfu76mS9eEUHOA",
        "authDomain": "root-grammar-251415.firebaseapp.com",
        "databaseURL": "https://root-grammar-251415.firebaseio.com",
        "storageBucket": ""
}
firebase = pyrebase.initialize_app(firebaseconfig)

db = firebase.database()
try:
    keys = db.get().val().keys()
    for key in keys:
        print datetime.now().strftime(fmt),"removing: ",key
        db.child(key).remove()
except Exception,e:
    print datetime.now().strftime(fmt),"Exception: ",e
