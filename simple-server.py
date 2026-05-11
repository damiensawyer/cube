#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = 7000
DIRECTORY = "/home/damien/temp/code/cube"

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

# Allow all origins for CORS
def set_cors_headers(self):
    self.send_header('Access-Control-Allow-Origin', '*')
    self.send_header('Access-Control-Allow-Methods', 'GET, OPTIONS')
    self.send_header('Access-Control-Allow-Headers', '*')

http.server.SimpleHTTPRequestHandler.end_headers = lambda self: None
http.server.SimpleHTTPRequestHandler.do_GET = lambda self: None

PORT = 7000
DIRECTORY = "/home/damien/temp/code/cube"

with socketserver.TCPServer(("127.0.0.1", PORT), Handler) as httpd:
    print(f"Rubiks Cube Server running on port {PORT}")
    print(f"http://localhost:{PORT}/rubiks-cube.html")
    print("Press Ctrl+C to stop")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped")
