from fastapi import FastAPI
import yfinance as yf

app = FastAPI()


@app.get("/")
async def root():
    return "Hello World! We are ODA!"

@app.get("/{ticker}")
async def read_item(ticker):
    return yf.download(tickers=ticker, period='max', interval='1d').to_json()

@app.get("/")
async def root():
    return "Hello World!\nWe are ODA!"

