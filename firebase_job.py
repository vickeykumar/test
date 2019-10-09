#!/usr/bin/env python

import pyrebase
firebaseconfig = {
        "apiKey": "AIzaSyCcHshsJr7GXkyIaFOFRgfu76mS9eEUHOA",
        "authDomain": "root-grammar-251415.firebaseapp.com",
        "databaseURL": "https://root-grammar-251415.firebaseio.com",
        "storageBucket": ""
}
firebase = pyrebase.initialize_app(firebaseconfig)

db = firebase.database()
keys = db.get().val().keys()

for key in keys:
    print "removing: ",key
    db.child(key).remove()

