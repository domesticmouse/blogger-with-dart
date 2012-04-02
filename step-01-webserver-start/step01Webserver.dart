#import('dart:io');
#import('dart:uri');

main() {
  HttpServer server = new HttpServer();

  server.listen('127.0.0.1', 8080);
  server.onRequest = helloWorld;
}

void helloWorld(HttpRequest request, HttpResponse response) {
  log("Serving request for ${request.path + (request.queryString == null? "" : "?"+request.queryString)}");

  // TODO: complete  
  // hint: http://api.dartlang.org/io/HttpResponse.html
}

void log(String data) {
  print("${new Date.now()}: $data");
}
