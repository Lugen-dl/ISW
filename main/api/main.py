import os
import psycopg2 
from fastapi import FastAPI

app = FastAPI()

DATABASE_URL = os.getenv("DATABASE_URL")

@app.get("/api/vulnerabilities")
def get_vulnerabilities():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute("SELECT * FROM vulnerabilities;")
    data = cur.fetchall()
    cur.close()
    conn.close()
    return {"data": data}

