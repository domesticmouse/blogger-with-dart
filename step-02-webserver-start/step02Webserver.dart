#import('dart:io');
#import('dart:uri');

main() {
  HttpServer server = new HttpServer();

  server.listen('127.0.0.1', 8080);
  server.onRequest = requestDispatch;
}

void requestDispatch(HttpRequest request, HttpResponse response) {
  String filePath = request.path + (request.queryString == null? "" : "?"+request.queryString);
  log("Serving request for $filePath");
  
  switch (request.path) {
  case '/':
    serveFile('index.html', 'text/html', response);
    break;
    
  case '/simple.js':
    serveFile('simple.js', 'application/javascript', response);
    break;
    
  case '/feeds/default/':
    retrieveFeed(response);
    break;
    
  default:
    pageNotFound(response, filePath);
  }
}

void serveFile(String path, String contentType, HttpResponse response) {
  // TODO: complete
}

void retrieveFeed(HttpResponse response) {
  // TODO: complete
}

void pageNotFound(HttpResponse response, String filePath) {
  // TODO: complete
}

void log(String data) {
  print("${new Date.now()}: $data");
}
