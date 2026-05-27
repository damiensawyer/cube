const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 7000;

function serveFile(res, filePath) {
    try {
        const data = fs.readFileSync(filePath);
        res.writeHead(200, { 
            'Content-Type': 'text/html',
            'Access-Control-Allow-Origin': '*',
            'Cache-Control': 'no-cache'
        });
        res.end(data);
    } catch (err) {
        console.error('Error reading file:', err.message);
        if (res) {
            res.writeHead(500);
            res.end('Internal server error');
        }
    }
}

const createServer = () => {
    return http.createServer((req, res) => {
        console.log('Request:', req.method + ' ' + req.url);
        
        if (req.method === 'GET') {
            let filePath;
            
            if (req.url === '/' || req.url === '/rubiks-cube.html' || 
                req.url === '/index.html' || req.url === '/index.htm') {
                filePath = path.join(__dirname, 'index.html');
            } else {
                filePath = path.join(__dirname, req.url);
            }
            
            console.log('Serving:', filePath);
            serveFile(res, filePath);
        } else {
            res.writeHead(405);
            res.end('Method not allowed');
        }
    });
};

const startServer = () => {
    const serverInstance = createServer();
    
    serverInstance.listen(port, '127.0.0.1', () => {
        console.log('Rubiks Cube Server');
        console.log('Running at: http://localhost:' + port);
        console.log('');
        console.log('Open in browser: http://localhost:' + port + '/rubiks-cube.html');
        console.log('');
        console.log('Press Ctrl+C to stop the server');
    });
};

process.on('SIGINT', () => {
    console.log('\nShutting down server...');
    if (serverInstance) {
        serverInstance.close(() => {
            process.exit(0);
        });
    } else {
        process.exit(0);
    }
});

startServer();
