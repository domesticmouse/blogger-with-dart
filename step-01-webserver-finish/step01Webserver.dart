#import('dart:io');
#import('dart:uri');

main() {
  HttpServer server = new HttpServer();

  server.listen('127.0.0.1', 8080);
  server.addRequestHandler((r)=>true, helloWorld);
}

void helloWorld(HttpRequest request, HttpResponse response) {
  log("Serving request for ${request.path + (request.queryString == null? "" : "?"+request.queryString)}");
  response.headers.add('Content-type', 'text/html');
  response.outputStream.writeString('''
<html>
<head>
  <title>Hello World</title>
</head>
<body>
  <h1>Hello Griffith Nathan Campus!</h1>
  <p>It is currently ${new Date.now()}</p>
</body>
</html>
''');
  response.outputStream.close();  
}

void log(String data) {
  print("${new Date.now()}: $data");
}
