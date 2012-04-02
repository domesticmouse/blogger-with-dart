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
    
  case '/feeds/posts/default':
    retrieveFeed(response);
    break;
    
  default:
    pageNotFound(response, filePath);
  }
}

void pageNotFound(HttpResponse response, String filePath) {
  // TODO: Serve a 404 page for files we don't know about
  // hint: this is pretty much step-01, with a few minor modifications...
}

void serveFile(String path, String contentType, HttpResponse response) {
  log("Serving $path for $contentType");
  // TODO: Serve specified files for certain request. File IO ftw!
  // hint: http://api.dartlang.org/io/File.html
}

void retrieveFeed(HttpResponse response) {
  // This is harder, it's about mirroring requests for /feeds/posts/default/ 
  // to http://code.blogger.com/feeds/posts/default/ taking advantage of Dart's 
  // evented IO.
  
  HttpClient client = new HttpClient();
  Uri feedUrl = new Uri.fromString('http://code.blogger.com/feeds/posts/default');
  // TODO: complete
}

void log(String data) {
  print("${new Date.now()}: $data");
}
