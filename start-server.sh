#!/bin/bash
# Start the Rubik's Cube server on port 7000 using Node.js

cd "$(dirname "$0")"

echo "Starting Rubiks Cube Server..."
echo "Server: http://localhost:7000/rubiks-cube.html"
echo ""

# Kill any existing server on port 7000
fuser -k 7000/tcp 2>/dev/null || true
sleep 1

# Start the server in background using Node.js built-in modules
node -e '
const http = require("http");
const fs = require("fs");
const path = require("path");

const port = 7000;

console.log("Rubiks Cube Server starting on port " + port);

http.createServer((req, res) => {
    if (req.url === "/" || req.url === "/rubiks-cube.html" || 
        req.url === "/index.html" || req.url === "/") {
        fs.readFile(path.join(__dirname, "rubiks-cube.html"), (err, data) => {
            if (err) {
                res.writeHead(500);
                res.end("Error loading file: " + err.message);
            } else {
                res.writeHead(200, { 
                    "Content-Type": "text/html",
                    "Access-Control-Allow-Origin": "*" 
                });
                res.end(data);
            }
        });
    } else if (req.method === "OPTIONS") {
        res.writeHead(204);
        res.end();
    } else {
        res.writeHead(404);
        res.end("File not found");
    }
}).listen(port, "127.0.0.1", () => {
    console.log("");
    console.log("Open in browser: http://localhost:" + port + "/rubiks-cube.html");
});

process.on("SIGINT", () => {
    process.exit(0);
});
' &

SERVER_PID=$!
echo "Server started with PID: $SERVER_PID"
echo ""

# Wait a moment for server to start
sleep 2

# Try to open in browser if possible
if command -v xdg-open > /dev/null 2>&1; then
    echo "Opening in default browser..."
    sleep 1 && xdg-open http://localhost:7000/rubiks-cube.html 2>/dev/null || \
        echo "Please open http://localhost:7000/rubiks-cube.html manually"
elif command -v open > /dev/null 2>&1; then
    echo "Opening in default browser..."
    sleep 1 && open http://localhost:7000/rubiks-cube.html || \
        echo "Please open http://localhost:7000/rubiks-cube.html manually"
else
    echo ""
    echo "Server is running. Open http://localhost:7000/rubiks-cube.html in your browser"
fi

# Keep script alive to maintain background process
wait $SERVER_PID
