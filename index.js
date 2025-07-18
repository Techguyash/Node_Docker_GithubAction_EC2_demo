const http = require("http");
const port = 8080;

const server = http.createServer((req, res) => {
  res.end("Hello from Node.js on EC2!!!!");
});

server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
