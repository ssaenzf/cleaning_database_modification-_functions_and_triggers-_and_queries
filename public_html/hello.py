#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, url_for, redirect, session
import json
import os
import sys

app = Flask(__name__)
@app.route("/")
@app.route('/principal')
def hello():
    print (url_for('static', filename='style.css'), file=sys.stderr)
    catalogue_data = open(os.path.join(app.root_path,'catalogue/catalogue.json'), encoding="utf-8").read()
    catalogue = json.loads(catalogue_data)
    return render_template('ENTRADA_PRINCIPAL.html', movies=catalogue['peliculas'])


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5001, debug=True)
