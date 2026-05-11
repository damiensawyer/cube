#!/bin/bash

cd "$(dirname "$0")"

echo "Starting Rubiks Cube server..."
echo ""

# Start the node server in background
node server.js &
SERVER_PID=$!

# Give it a moment to start
sleep 2

# Try to open in browser
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:8080/rubiks-cube.html 2>/dev/null || echo "Please open http://localhost:8080/rubiks-cube.html in your browser"
elif command -v open &> /dev/null; then
    open http://localhost:8080/rubiks-cube.html
else
    echo "Server running at http://localhost:8080/rubiks-cube.html"
fi

# Keep the script running to maintain background process
wait $SERVER_PID
