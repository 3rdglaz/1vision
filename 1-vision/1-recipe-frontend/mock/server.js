const jsonServer = require("json-server");
const path = require("path");
const fs = require("fs");

const server = jsonServer.create();
const middlewares = jsonServer.defaults();

const routerFiles = fs.readdirSync(path.resolve(__dirname, "./files/"));
const routerKeys = {};

routerFiles.forEach((f) => {
  if (f.indexOf(".json") > -1) {
    const jsonPath = path.resolve(__dirname, `./files/${f}`);
    const jsonFile = JSON.parse(fs.readFileSync(jsonPath, "utf-8"));
    const key = Object.keys(jsonFile)[0];
    routerKeys[key] = jsonFile[key];
    console.log(`register => /${key}`);
  }
});

const router = jsonServer.router(routerKeys);
server.use((req, res, next) => {
  if (req.method === "POST") {
    req.body.createdAt = Date.now();
  }

  next();
});

// Use default router
server.use(jsonServer.bodyParser);
server.use(middlewares);
server.use(router);

server.listen(3333, () => {
  console.log("JSON Server is running");
});
