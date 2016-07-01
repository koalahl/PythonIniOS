#!/usr/bin/python
# -*- coding: UTF-8 -*-

import socket

HOST = '127.0.0.1'                 # Symbolic name meaning all available interfaces
PORT = 8000              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(5)

while 1:
    conn, addr = s.accept()
    print 'Connected by', addr
    data = conn.recv(1024)
    if not data: break
    conn.sendall(data)
    conn.close()