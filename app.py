from flask import Flask

# Enable remote debugging
import ptvsd
ptvsd.enable_attach(address=('0.0.0.0', 5678))
ptvsd.wait_for_attach()

app = Flask(__name__)

@app.route('/')
def hello_world():
    print("All the day long") # This shows in the Terminal window
    return "Hello, world."    # This shows in the browser window

