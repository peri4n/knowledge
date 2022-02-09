# Flask Web Development

## Chapter 1

Create a virtual environment by running:

```shell
$ python3 -m venv venv
```

Enter the virtual environment with:

```shell
$ source ./venv/bin/activate
```

To exit it via:

```shell
$ deactivate
```

## Chapter 2

Create a Hello World Web App with 

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return '<h1>Hello World!</h1>'
```

Run it (in debug mode) via:

```shell
$ export FLASK_APP=hello.py FLASK_DEBUG=1; flask run
```
