#!/bin/bash
# Start the Rubik's Cube server on port 7000

cd "$(dirname "$0")"

echo "🎲 Starting Rubiks Cube Server..."
echo ""
echo "Server: http://localhost:7000/rubiks-cube.html"
echo ""

if command -v python3 &> /dev/null; then
    # Use Python's built-in HTTP server
    python3 -m http.server 7000 --bind 127.0.0.1
elif command -v node &> /dev/null; then
    # Fallback to Node.js
    node -e 'const h = require("http"); const fs = require("fs"); h.createServer((r, s) => { s.writeHead(200); s.end(fs.readFileSync("rubiks-cube.html")); }).listen(7000, "127.0.0.1")'
else
    echo "No HTTP server available!"
fi
