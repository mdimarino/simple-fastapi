#!/usr/bin/env python

""" Simple FastAPI """

import uvicorn
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    """ Root call """
    return {"message": "Hello World"}

if __name__ == "__main__":

    log_config = uvicorn.config.LOGGING_CONFIG

    log_config["formatters"]["default"]["fmt"] = ("[%(asctime)s] "
                                                  "%(levelprefix)s "
                                                  "%(message)s")
    log_config["formatters"]["access"]["fmt"] = ("[%(asctime)s] "
                                                 "%(levelprefix)s "
                                                 "%(client_addr)s - "
                                                 "\"%(request_line)s\" "
                                                 "%(status_code)s")

    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        log_level="debug",
        workers=1,
        reload=False,
        log_config=log_config
    )
