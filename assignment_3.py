import requests 
 
# Local binary test 
print("Python3 is working ✅") 
 
# Flask app test (if running) 
try: 
    r = requests.get("http://127.0.0.1:5000") 
    print("Flask app responded with:", r.status_code) 
except Exception as e: 
    print("Could not connect to Flask app:", e)