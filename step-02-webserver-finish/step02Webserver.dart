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

void serveFile(String path, String contentType, HttpResponse response) {
  log("Serving $path for $contentType");
  InputStream input = new File(path).openInputStream();
  OutputStream output = response.outputStream;
  response.headers['Content-Type'] = contentType;
  
  input.onData = () {
    List data = input.read();
    String payload = new String.fromCharCodes(data);
    output.writeString(payload);
  };

  input.onClosed = () {
    log('Closing $path');
    output.close();
  };
  
}

void retrieveFeed(HttpResponse response) {
  HttpClient client = new HttpClient();
  Uri feedUrl = new Uri.fromString('http://code.blogger.com/feeds/posts/default');
  HttpClientConnection conn = client.openUrl('GET', feedUrl);
  conn.onResponse = (HttpClientResponse r) => r.inputStream.pipe(response.outputStream);
}

void pageNotFound(HttpResponse response, String filePath) {
  response.statusCode = 404;
  response.headers['Content-Type'] = 'text/html';
  response.outputStream.writeString('''
<html>
<head>
  <title>File not found</title>
</head>
<body>
  <h1>File not found: $filePath</h1>
  <p>Sorry, no such file found. Try again later?</p>
</body>
</html>
''');
  response.outputStream.close();  
}

void log(String data) {
  print("${new Date.now()}: $data");
}
