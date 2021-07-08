#!/bin/bash
SET QHOME=C:/dev/q/q
cd C:/dev/kdb-tick-marketdata
C:/dev/q/q/w32/q.exe  tick.q sym C:/dev/kdb-tick-marketdata/TPlogs -p 5000 &
C:/dev/q/q/w32/q.exe  tick/rtdb.q localhost:5000 localhost:5002 -p 5001 &
C:/dev/q/q/w32/q.exe  tick/hdb.q C:/dev/kdb-tick-marketdata/TPlogs/sym -p 5002 &