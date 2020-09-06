# Collaborative Filtering 1

import cgi
import json as json
form = cgi.FieldStorage()
json = form["param"].value



def js(json):
    return json;
