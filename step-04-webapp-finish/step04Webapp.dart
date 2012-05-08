#import('dart:html');
#import('dart:json');

// For an explanation of how we are working around lack of JSONP,    
// Please see http://blog.sethladd.com/2012/03/jsonp-with-dart.html

dataReceived(MessageEvent e) {
  Map postList = JSON.parse(e.data);
  Element titlesDiv = document.query('#titles');
  int count = 0;
  String titlesContent = "";

  postList['items'].forEach((post) {    
    titlesContent += "<li><a id='title${count}' href='#'>${post['title']}</a></li>";
    count++;
  });
  titlesContent = "<ul>$titlesContent</ul>";
  titlesDiv.innerHTML = titlesContent;
  
  Element contentDiv = document.query('#content');
  
  selectPost(int i) {
    contentDiv.innerHTML = postList['items'][i]['content'];
    
    List<Element> oldSelected = document.queryAll("#titles a.selected");
    oldSelected.forEach((elem) {
      elem.classes.remove('selected');
    });
    
    Element selected = document.query('#title$i');
    selected.classes.add('selected');
  }

  for (int i = 0; i<count; i++) {
    Map post = postList['items'][i];
    Element target = document.query('#title$i');
    target.on.click.add((Event event) {
      event.preventDefault();
      selectPost(i);
    });
  }

  selectPost(0);

}

void main() {
  // listen for the postMessage from the main page
  window.on.message.add(dataReceived);
  
  Element script = new Element.tag("script");
  script.src = "https://www.googleapis.com/blogger/v2/blogs/3213900/posts?pp=1&key=AIzaSyC-5XG3E-wyDq91TdUkVT5T9t6Wxbqa2Mc&callback=callbackForJsonpApi";
  document.body.elements.add(script);
}