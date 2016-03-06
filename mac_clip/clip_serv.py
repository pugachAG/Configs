#!/usr/bin/python
from subprocess import Popen, PIPE
from BaseHTTPServer import BaseHTTPRequestHandler
import SocketServer

class ClipboardHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_len = int(self.headers.getheader('content-length', 0))
        post_body = self.rfile.read(content_len)
        Popen(['pbcopy'], stdin=PIPE).communicate(input=post_body)
        self.send_response(200)
        self.send_header('Content-type','text/html')
        self.end_headers()
        self.wfile.write('Success')


httpd = SocketServer.TCPServer(('', 7777), ClipboardHandler)
httpd.serve_forever()

