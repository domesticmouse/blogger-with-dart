#import('dart:html');
#import('dart:json');

// For an explanation of how we are working around lack of JSONP,    
// Please see http://blog.sethladd.com/2012/03/jsonp-with-dart.html

dataReceived(MessageEvent e) {
  var data = JSON.parse(e.data);
  List items = data['items'];
  StringBuffer buffy = new StringBuffer();
  
  for (var item in items) {
    buffy.add("""
      <h2>${item['title']}</h1>
      ${item['content']}
      <hr/>
      """);
  }
  
  document.query('#content').innerHTML = buffy.toString(); // buffy.stake(vampire);

}

void main() {
  // listen for the postMessage from the main page
  window.on.message.add(dataReceived);
  
  Element script = new Element.tag("script");
  script.src = "https://www.googleapis.com/blogger/v2/blogs/3213900/posts?pp=1&key=AIzaSyC-5XG3E-wyDq91TdUkVT5T9t6Wxbqa2Mc&callback=callbackForJsonpApi";
  document.body.elements.add(script);
}