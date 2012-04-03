#import('dart:html');
#import('dart:json');


void main() {
  var jsonPostList = @'''
{
 "kind": "blogger#postList",
 "nextPageToken": "CgkIChjh_p7z7iUQzJTEAQ",
 "prevPageToken": "CgkIChDBq5v24yYQzJTEAQ",
 "items": [
  {
   "kind": "blogger#post",
   "id": "1387873546480002228",
   "blog": {
    "id": "3213900"
   },
   "published": "2012-03-23T08:58:00.000Z",
   "updated": "2012-03-23T08:58:12.594Z",
   "url": "http://code.blogger.com/2012/03/blogger-documentation-has-moved-to.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/1387873546480002228",
   "title": "Blogger Documentation has moved to developers.google.com",
   "content": "Blogger documentation has a new home: it has moved to \u003ca href=\"https://developers.google.com/blogger/\"\u003edevelopers.google.com/blogger\u003c/a\u003e!\u003cbr /\u003e\n\u003cbr /\u003e\nI have re-arranged the documentation a little to make it easier to navigate, but it is largely the same documentation you will remember from \u003ca href=\"http://code.google.com/apis/blogger\"\u003ecode.google.com/apis/blogger\u003c/a\u003e. If you find anything is out of place or hard to find, please let us know on the \u003ca href=\"https://groups.google.com/forum/#!forum/bloggerdev\"\u003eBlogger Developer forum\u003c/a\u003e.",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/1387873546480002228/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "3727559627660892860",
   "blog": {
    "id": "3213900"
   },
   "published": "2012-01-22T01:40:00.000Z",
   "updated": "2012-01-22T23:16:03.068Z",
   "url": "http://code.blogger.com/2012/01/customising-threaded-comments.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/3727559627660892860",
   "title": "Customising Threaded Comments",
   "content": "\u003cp\u003eRecently we released an update to Blogger’s commenting system that enables people to directly respond to comments. This capability is known as \u003ca href=\"http://buzz.blogger.com/2012/01/engage-with-your-readers-through.html\"\u003eThreaded Comments\u003c/a\u003e. We are pleased to see quite a few people diving in and writing tutorials, including a \u003ca href=\"http://www.youtube.com/watch?v=LsVV2nyfIEM\"\u003escreencast\u003c/a\u003e. It’s wonderful to see the enthusiasm of our developers!\u003c/p\u003e\n\n\u003cp\u003eIn this post we will look at what are the changes required to modify a custom template to enable Threaded Comments, once you have fulfilled the requirements outlined in the \u003ca href=\"http://buzz.blogger.com/2012/01/engage-with-your-readers-through.html\"\u003eThreaded Comments\u003c/a\u003e announcement post on Buzz.blogger.com. We will then look at how to customise the look and feel of the Threaded Comments using just CSS, and also have a quick peek at alternatives.\u003c/p\u003e\n\n\u003cp\u003ePlease note, these instructions may not work if your blog’s template is heavily customised. Your template may possibly missing some of the \u003ccode\u003eb:includable\u003c/code\u003es that the instructions below depend on. Please try the following instructions on your template, but if they don’t work come to our \u003ca href=\"https://groups.google.com/forum/#!forum/bloggerdev\"\u003eBlogger Developer forum\u003c/a\u003e and get some help with patching your template. \u003c/p\u003e\n\n\u003cp\u003eThe first step is to Edit the HTML for your Template, which can be found inside Settings under the Template tab. You must make sure to expand the Widget Templates, as we need to modify the main Blog Widget Template. To find the main Blog Widget code, search for the following Blogger Layouts Template code:\u003c/p\u003e\n\n\u003cpre\u003e&lt;b:widget id='Blog1' locked='true' title='Blog Posts' type='Blog'&gt;\u003c/pre\u003e\n\n\u003cp\u003eInside the \u003ccode\u003eb:widget\u003c/code\u003e are a series of \u003ccode\u003eb:includable\u003c/code\u003e blocks. These act a lot like functions in programming languages, in that they can be called from other \u003ccode\u003eb:includable\u003c/code\u003e blocks to insert chunks of HTML. The only special block is the includable called \u003ccode\u003emain\u003c/code\u003e, which is where the Layout Template engine starts when rendering the Widget’s content. If you don’t see content inside the \u003ccode\u003eb:widget\u003c/code\u003e, you need to click the Expand Widget Templates radio button above the edit area.\u003c/p\u003e\n\n\u003cp\u003eThe Layout Template should include the following code:\u003c/p\u003e\n\n\u003cpre\u003e&lt;b:if cond='data:post.showThreadedComments'&gt;\n  &lt;b:include data='post' name='threaded_comments'/&gt;\n&lt;b:else/&gt;\n  &lt;b:include data='post' name='comments'/&gt;\n&lt;/b:if&gt;\u003c/pre\u003e\n\n\u003cp\u003eThe interesting part is that we have a fork here, implemented as a \u003ccode\u003eb:if\u003c/code\u003e conditional block, that decides whether to render the comments as threaded or not. The need for this split can be seen on the Threaded Comments announcement on \u003ca href=\"http://buzz.blogger.com/2012/01/engage-with-your-readers-through.html\"\u003eBuzz.blogger.com\u003c/a\u003e. \u003c/p\u003e\n\n\u003cp\u003eAs a quick aside, if you don’t have this code, but instead just have something like the following:\u003c/p\u003e\n\n\u003cpre\u003e&lt;b:include data='post' name='comments'/&gt;\u003c/pre\u003e\n\n\u003cp\u003eThen you can get threaded comments by replacing this b:include with the above logic block, assuming you fulfill the requirements laid out in the \u003ca href=\"http://buzz.blogger.com/2012/01/engage-with-your-readers-through.html\"\u003eThreaded Comments announcement post on Buzz.blogger.com\u003c/a\u003e.\u003c/p\u003e\n\n\u003cp\u003eNow you can look at the implementation of the threaded_comments includable by searching for the following line of code:\u003c/p\u003e\n\n\u003cpre\u003e&lt;b:includable id='threaded_comments' var='post'&gt;\u003c/pre\u003e\n\n\u003cp\u003eThis code is responsible for rendering the actual threaded comments to screen. You can choose to override this code block to customise the look of your comments, but it is worth noting that if you do, you won’t get updates to this functionality as we change the implementation in the future.\u003c/p\u003e\n\n\u003cp\u003eThere are two new data members we have introduced with this feature release that you can use to render comment threads:\u003c/p\u003e\n\u003cul\u003e\n  \u003cli\u003e\u003ccode\u003edata:post.commentSrc\u003c/code\u003e This is the source to the javascript library that handles actions\u003c/li\u003e\n  \u003cli\u003e\u003ccode\u003edata:post.commentHtml\u003c/code\u003e This is the rendered HTML for the comment thread\u003c/li\u003e\n\u003c/ul\u003e\n\n\u003cp\u003eIf you want to change the look and feel of your comments, we strongly recommend you use the Template Designer to set custom CSS to style the Threaded Comments. We suggest you customise the comments by modifying the property \"Advanced \u003e Add CSS\". For example, you can add the following CSS code to change the look:\u003c/p\u003e\n\n\u003cpre\u003e.comments blockquote { \n    border: 1px solid black; color: white; font: Helvetica;\n} // draws a border around comment bodies, sets the text font and colour\n.comments .inline-thread li { list-style-type: decimal; } // numbers replies\n\u003c/pre\u003e\n\n\u003cp\u003eFinally, you can implement your own version of Threaded Comments by walking the \u003ccode\u003edata:post.comments\u003c/code\u003e directly. This will contain all the comments, ordered by time of comment, now with an optional extra field \u003ccode\u003edata:comment.inReplyTo\u003c/code\u003e which will contain the \u003ccode\u003eid\u003c/code\u003e of the parent comment, if there is one.\u003c/p\u003e\n\n\u003cp\u003eIf you have any questions about how to customise your Blogger Comments, please feel free to drop by the \u003ca href=\"https://groups.google.com/forum/#!forum/bloggerdev\"\u003eBlogger Developer Forum\u003c/a\u003e. We’re glad to help!\u003c/p\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/3727559627660892860/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "1356679731059154830",
   "blog": {
    "id": "3213900"
   },
   "published": "2012-01-05T06:06:00.000Z",
   "updated": "2012-04-01T11:57:02.113Z",
   "url": "http://code.blogger.com/2012/01/easier-to-use-interface-for-blogger.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/1356679731059154830",
   "title": "An easier to use interface for the Blogger JSON API",
   "content": "As I have been reviewing the applications to use the \u003ca href=\"http://code.google.com/apis/blogger/docs/2.0/json/getting_started.html\"\u003eBlogger JSON API\u003c/a\u003e, I have noticed that a fair number of you appear to be integrating with Blogger JSON API using JavaScript. So, in the interests of making things easier for all of you, here is a walk through of using the just released \u003ca href=\"http://googlecode.blogspot.com/2011/11/javascript-client-library-for-google.html\"\u003eJavaScript Client Library for Google APIs\u003c/a\u003e to access the Blogger JSON API.\u003cbr /\u003e\nThe first step is exploring the methods we can call in the \u003ca href=\"http://code.google.com/apis/explorer/\"\u003eGoogle APIs Explorer\u003c/a\u003e. The method in the Blogger JSON API collection that most people use, understandably, is the method to list the most recent posts for a Blog - \u003ca href=\"http://code.google.com/apis/explorer/#_s=blogger&amp;_v=v2&amp;_m=posts.list\"\u003e\u003ccode\u003eposts.list\u003c/code\u003e\u003c/a\u003e. This method takes one required field - the \u003ccode\u003eblogId\u003c/code\u003e that identifies a particular blog - and a number of optional arguments that allow us to tune what information is returned.\u003cbr /\u003e\nThe information I am requesting from the Blogger JSON API is the post titles and content for the \u003ca href=\"http://code.blogger.com/\"\u003ecode.blogger.com\u003c/a\u003e blog which has a \u003ccode\u003eblogId\u003c/code\u003e of 3213900. To limit the returned data to just the post titles and content, we use the optional argument \u003ccode\u003efields\u003c/code\u003e with the value of \u003ccode\u003eitems(content,title)\u003c/code\u003e. Here is a link to the \u003ca href=\"http://code.google.com/apis/explorer/#_s=blogger&amp;_v=v2&amp;_m=posts.list&amp;blogId=3213900&amp;fields=items(content,title)\"\u003eGoogle APIs Explorer\u003c/a\u003e with the appropriate information pre-filled so you can see both the underlying query that is sent to the Google APIs servers, as well as the shape of the returned JSON data.\u003cbr /\u003e\nThe next step is the JavaScript required to request this data and make use of it. I am using the JavaScript Client Library to both construct the query, as well as navigate the results, reducing the complexity of the code.\u003cbr /\u003e\nTo load the library, all we have to do is include a script in our HTML that loads the library as follows:\u003cbr /\u003e\n\u003cpre\u003e&lt;script src=\"https://apis.google.com/js/client.js?onload=init\"&gt;&lt;/script&gt;\u003c/pre\u003e\nThe part of this code to pay attention to is the argument \u003ccode\u003eonload=init\u003c/code\u003e. This nominates the \u003ccode\u003einit\u003c/code\u003e function to be called once the JavaScript Client Library has loaded. The \u003ccode\u003einit\u003c/code\u003e function is where we configure the client key and the API we want to work with:\u003cbr /\u003e\n\u003cpre\u003efunction init() {\n  gapi.client.setApiKey('YOUR_API_KEY');\n  gapi.client.load('blogger', 'v2', function() {\n    // ...  \n  });\n}\u003c/pre\u003e\nYou can retrieve the API Key from your project on the \u003ca href=\"https://code.google.com/apis/console/\"\u003eGoogle APIs Console\u003c/a\u003e, once you have requested that I enable the Blogger API for your project. The \u003ccode\u003egapi.client.load\u003c/code\u003e function takes the API name, and version, of the API you want to use, and a callback function to run once the API support code has been loaded. In this code, we are loading the Blogger v2 API.\u003cbr /\u003e\nInside the \u003ccode\u003egapi.client.load\u003c/code\u003e callback, we have the following code to configure a request to the Google APIs servers:\u003cbr /\u003e\n\u003cpre\u003evar request = gapi.client.blogger.posts.list({\n  'blogId': 3213900,\n  'fields': 'items(content,title)'\n});\u003c/pre\u003e\nNote how we now no longer need to construct our own query url. The JavaScript Client Library deals with all the messy issues of making sure the arguments are correctly escaped. Next, we can issue the request to the servers as follows:\u003cbr /\u003e\n\u003cpre\u003erequest.execute(function(response) {\n  // ...\n});\u003c/pre\u003e\nThe execute method takes a callback function that will be executed once the Google APIs servers respond. The most important part of this callback function is the data that is handed to us in the \u003ccode\u003eresponse\u003c/code\u003e argument. In the body of the callback function, I iterate over the items member to pull out the titles and contents of all the returned posts:\u003cbr /\u003e\n\u003cpre\u003efor (var i = 0; i &lt; response.items.length; i++) {\n  $(\"#target\").append(\"&lt;h2&gt;\" + response.items[i].title + \"&lt;/h2&gt;\");\n  $(\"#target\").append(response.items[i].content);\n  if (i+1&lt;response.items.length) {\n    $(\"#target\").append(\"&lt;hr/&gt;\");\n  }\n}\u003c/pre\u003e\nThe eagle eyed among you will have noticed that I am using \u003ca href=\"http://jquery.com/\"\u003ejQuery\u003c/a\u003e to insert the returned HTML into the DOM. I am using the latest stable jQuery hosted on Google’s Libraries API.\u003cbr /\u003e\nYou can see the results on \u003ca href=\"http://code-blogger.appspot.com/\"\u003ecode-blogger.appspot.com\u003c/a\u003e. I have used \u003ca href=\"http://html5boilerplate.com/\"\u003eHTML5 Boilerplate\u003c/a\u003e as the starting point for building this example, to get all the latest HTML5 magic. If you have any questions about this sample, please post them to the \u003ca href=\"https://groups.google.com/group/bloggerdev\"\u003eBlogger Developers Group\u003c/a\u003e.",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/1356679731059154830/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "780823247460418352",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-12-19T06:40:00.000Z",
   "updated": "2011-12-19T06:41:08.111Z",
   "url": "http://code.blogger.com/2011/12/changes-to-profileid-for-google-profile.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/780823247460418352",
   "title": "Changes to ProfileID for Google+ profile users",
   "content": "\u003cp\u003eIt’s wonderful to see a lot of our users taking us up on our offer to merge our Blogger Profile with the Google+ Profile. For developers this means that there is one small wrinkle to worry about - the format of the \u003ccode\u003eProfileId\u003c/code\u003e for these migrated users has changed.\u003c/p\u003e\n\n\u003cp\u003eWhat’s a \u003ccode\u003eProfileId\u003c/code\u003e, and what’s it used for? \u003c/p\u003e\n\n\u003cp\u003eThe \u003ccode\u003eProfileId\u003c/code\u003e is a component of the path for the \u003ca href=\"http://code.google.com/apis/blogger/docs/2.0/developers_guide_protocol.html#RetrievingMetafeed\"\u003eRetrieving a List of Blogs\u003c/a\u003e Blogger GData protocol call, which can either be the value \u003ccode\u003edefault\u003c/code\u003e, which is the recommended value and means the currently authenticated user, or alternatively it can be the profile identifier of the current authenticated user. Up until now, the profile identifier has always been numeric, but for the converted Google+ Profile Blogger users, this is no longer the case.\u003c/p\u003e\n\n\u003cp\u003eFor users that have converted to using Google+ Profiles on Blogger, the \u003ccode\u003eProfileId\u003c/code\u003e can be derived as follows. Take the Google+ profile url for a user that has chosen to convert, for example \u003ca href=\"https://plus.google.com/114895967455102275039/\"\u003ehttps://plus.google.com/114895967455102275039/\u003c/a\u003e, then take the numeric portion at the end of the URL, prepend it with a g, and like magic, you have the new Blogger \u003ccode\u003eProfileId\u003c/code\u003e.\u003c/p\u003e\n\n\u003cp\u003eIf you have any questions, please do not hesitate to ask on the \u003ca href=\"https://groups.google.com/group/bloggerdev\"\u003eBlogger Developers group\u003c/a\u003e, and if you are on Google+, have a look at our \u003ca href=\"https://plus.google.com/110587955497525318489/posts\"\u003eBlogger Google+ Page\u003c/a\u003e.\u003c/p\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/780823247460418352/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "7298836173227646779",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-11-09T00:24:00.000Z",
   "updated": "2011-11-10T01:52:33.687Z",
   "url": "http://code.blogger.com/2011/11/introducing-custom-mobile-templates.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/7298836173227646779",
   "title": "Introducing custom mobile templates",
   "content": "\u003cp\u003eMany Bloggers put a lot of time and effort into creating a unique look for their blog, so today we’re excited to announce that custom templates are now also viewable from mobile devices.\u003c/p\u003e\n\n\u003cp\u003eIf you have a custom template for your blog and want it to appear on mobile browsers as well, visit the “Template” tab of your dashboard, click on the gear icon beneath the mobile template preview.\u003c/p\u003e\n\n\u003cdiv class=\"separator\" style=\"clear: both; text-align: center;\"\u003e\n\u003ca href=\"http://2.bp.blogspot.com/-kEQMaYxebJs/Tq-eMEEQTPI/AAAAAAAAARk/OtL411nW0l8/s1600/Screen%2Bshot%2B2011-10-20%2Bat%2B11.14.31%2BAM.png\" imageanchor=\"1\" style=\"clear:left; float:left;margin-right:1em; margin-bottom:1em\"\u003e\u003cimg border=\"0\" height=\"185\" width=\"320\" src=\"http://2.bp.blogspot.com/-kEQMaYxebJs/Tq-eMEEQTPI/AAAAAAAAARk/OtL411nW0l8/s320/Screen%2Bshot%2B2011-10-20%2Bat%2B11.14.31%2BAM.png\" /\u003e\u003c/a\u003e\u003c/div\u003e\n\n\u003cp style=\"clear:both\"\u003eThen select “Custom” from the “Choose mobile template” pulldown.\u003c/p\u003e\n\n\u003cdiv class=\"separator\" style=\"clear: both; text-align: center;\"\u003e\n\u003ca href=\"http://1.bp.blogspot.com/-dyyH6l2heQI/Tp5hR4sdzdI/AAAAAAAAAPs/HkYfZ8kpAwQ/s1600/mobile_template_picker_pulldown.png\" imageanchor=\"1\" style=\"clear:left; float:left;margin-right:1em; margin-bottom:1em\"\u003e\u003cimg border=\"0\" height=\"287\" width=\"320\" src=\"http://1.bp.blogspot.com/-dyyH6l2heQI/Tp5hR4sdzdI/AAAAAAAAAPs/HkYfZ8kpAwQ/s320/mobile_template_picker_pulldown.png\" /\u003e\u003c/a\u003e\u003c/div\u003e\n\n\u003cp style=\"clear:both\"\u003eYour template may not look exactly the same on a mobile browser, so click “Preview” to make sure it appears the way you want it to before you save it. \u003c/p\u003e\n\n\u003cdiv class=\"separator\" style=\"clear: both; text-align: center;\"\u003e\n\u003ca href=\"http://2.bp.blogspot.com/-0WqjKBhin9A/Tp5hIvXfoaI/AAAAAAAAAPg/3uRo92-FlmA/s1600/mobile_template_picker.png\" imageanchor=\"1\" style=\"clear:left; float:left;margin-right:1em; margin-bottom:1em\"\u003e\u003cimg border=\"0\" height=\"288\" width=\"320\" src=\"http://2.bp.blogspot.com/-0WqjKBhin9A/Tp5hIvXfoaI/AAAAAAAAAPg/3uRo92-FlmA/s320/mobile_template_picker.png\" /\u003e\u003c/a\u003e\u003c/div\u003e\n\n\u003cp style=\"clear:both\"\u003eIf you have gadgets on your blog, you can also control which of them will be available in mobile view, using this new attribute: \u003ccode\u003emobile\u003c/code\u003e in \u003ccode\u003e&lt;b:widget&gt;\u003c/code\u003e tag.  It can be \u003ccode\u003e'default'\u003c/code\u003e, \u003ccode\u003e'yes'\u003c/code\u003e, \u003ccode\u003e'no'\u003c/code\u003e, or \u003ccode\u003e'only'\u003c/code\u003e.\u003c/p\u003e\n\n\u003cp\u003eThe widgets that display on mobile by default are the following:\n\u003cul\u003e\u003cli\u003eHeader\u003c/li\u003e\n\u003cli\u003eBlog\u003c/li\u003e\n\u003cli\u003eProfile\u003c/li\u003e\n\u003cli\u003ePageList\u003c/li\u003e\n\u003cli\u003eAdSense\u003c/li\u003e\n\u003cli\u003eAttribution\u003c/li\u003e\u003c/ul\u003e\u003c/p\u003e\n\n\u003cp\u003eThe following widget will not be available in mobile view, because it’s a \u003cb\u003eBlogArchive\u003c/b\u003e widget.\u003c/p\u003e\n\n\u003cpre\u003e\n&lt;b:widget id='BlogArchive1' title='Blog Archive' type='BlogArchive'&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eTo make it available in mobile view, add \u003ccode\u003emobile=’yes’\u003c/code\u003e attribute to it.\u003c/p\u003e\n\n\u003cpre\u003e\n&lt;b:widget id='BlogArchive1' \u003cspan style=\"color:red;\"\u003emobile='yes'\u003c/span\u003e title='Blog Archive' type='BlogArchive'&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eSetting \u003ccode\u003emobile\u003c/code\u003e to \u003ccode\u003e'no'\u003c/code\u003e makes a widget not display in mobile view, even if available in mobile view by default.\u003c/p\u003e\n\n\u003cpre\u003e\n&lt;b:widget id='Attribution1' \u003cspan style=\"color: red;\"\u003emobile='no'\u003c/span\u003e title='Attribution' type='Attribution'&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eYou can also make a widget available only in mobile view by setting it to \u003ccode\u003e'only'\u003c/code\u003e.\u003c/p\u003e\n\n\u003cpre\u003e\n&lt;b:widget id='BlogArchive1' \u003cspan style=\"color: red;\"\u003emobile='only'\u003c/span\u003e title='Blog Archive' type='BlogArchive'&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eThe content of a widget can modified for mobile view with the \u003ccode\u003eboolean\u003c/code\u003e variable \u003ccode\u003edata:blog.isMobile\u003c/code\u003e.\u003c/p\u003e\n\n\u003cpre\u003e\n&lt;div class=\"widget-content\"&gt;\n  &lt;b:if cond=\"data:blog.isMobile\"&gt;\n    &lt;!-- Show a text link in mobile view.--&gt;\n    &lt;a href=\"http://www.blogger.com\"&gt;\n      Powered By Blogger\n    &lt;/a&gt;\n  &lt;b:else/&gt;\n    &lt;!-- Show an image link in desktop view.--&gt;\n    &lt;a href=\"http://www.blogger.com\"&gt;\n      &lt;img expr:src=\"data:fullButton\" alt=\"Powered By Blogger\"/&gt;\n    &lt;/a&gt;\n  &lt;/b:if&gt;\n&lt;/div&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eThe above template HTML shows different contents between desktop view and mobile view, depending on the value of the \u003ccode\u003edata:blog.isMobile\u003c/code\u003e variable.\u003c/p\u003e\n\n\u003cp\u003eYou can conditionally give different CSS properties to a same class between desktop view and mobile view, as the \u003ccode\u003e&lt;body&gt;\u003c/code\u003e tag of Blogger mobile templates has \u003ccode\u003emobile\u003c/code\u003e as its class. First, make sure the \u003ccode\u003e&lt;body&gt;\u003c/code\u003e tag of your custom template is same as the following one. \u003c/p\u003e\n\n\u003cpre\u003e\n&lt;body expr:class='&amp;quot;loading&amp;quot; + data:blog.mobileClass'&gt;\n\u003c/pre\u003e\n\n\u003cp\u003eThen, you can define different CSS properties for desktop and mobile view.\u003c/p\u003e\n\n\u003cpre\u003e\n/* For desktop view */\n.date-posts {\n  margin: 0 -$(separator.outdent);\n  padding: 0 $(separator.outdent);\n}\n\n/* For mobile view */\n.mobile .date-posts {\n  margin: 0;\n  padding: 0;\n}\n\u003c/pre\u003e\n\n\u003cp\u003eWe hope you will enjoy making your very own mobile templates.\u003c/p\u003e\n\n\u003cp\u003e\u003cb\u003eUpdated:\u003c/b\u003e Changed \u003ccode\u003edata:mobile\u003c/code\u003e to \u003ccode\u003edata:blog.isMobile\u003c/code\u003e\u003c/p\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/7298836173227646779/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "6049643111519186400",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-10-14T00:51:00.000Z",
   "updated": "2011-10-14T00:54:31.372Z",
   "url": "http://code.blogger.com/2011/10/today-we-have-made-change-to-layouts.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/6049643111519186400",
   "title": "Template Change: Analytics Section",
   "content": "\u003cp\u003eToday we have made a change to the Layouts Template language to improve \u003ca href=\"http://www.google.com/analytics/\"\u003eGoogle Analytics\u003c/a\u003e coverage. We have added the following includable section. \u003c/p\u003e\n\u003cpre\u003e\n&lt;b:includable id='google-analytics' var='blog'\u003e\n  &lt;b:if cond='data:blog.analyticsAccountNumber'&gt;\n    &lt;script type='text/javascript'&gt;\n      var _gaq = _gaq || [];\n      _gaq.push(['_setAccount', '&lt;data:blog.analyticsAccountNumber/&gt;']);\n      _gaq.push(['_trackPageview']);\n      (function() {\n        var ga = document.createElement('script');\n        ga.type = 'text/javascript';\n        ga.async = true;\n        ga.src = (document.location.protocol == 'https:' ?\n                  'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';\n        var s = document.getElementsByTagName('script')[0];\n        s.parentNode.insertBefore(ga, s);\n      })();\n    &lt;/script&gt;\n  &lt;/b:if&gt;\n&lt;/b:includable&gt;\n\u003c/pre\u003e\n\u003cp\u003eThis now allows you to include analytics tracking on your blog by adding the following include call to your template, preferably right before the close body tag so it doesn’t delay the visible page being rendered:\u003c/p\u003e\n\u003cpre\u003e\n&lt;b:include name='google-analytics' data='blog'/&gt;\n\u003c/pre\u003e\n\u003cp\u003eFor more details on the benefits you get from using Google Analytics, see \u003ca href=\"http://buzz.blogger.com/2011/10/google-analytics-support-in-blogger.html\"\u003ethis post on Blogger Buzz\u003c/a\u003e. If you have any questions about this new functionality, please join in the discussion on the \u003ca href=\"http://groups.google.com/group/bloggerDev\"\u003eBlogger Developer Group\u003c/a\u003e.\u003c/p\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/6049643111519186400/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "252207238930334231",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-09-27T23:42:00.001Z",
   "updated": "2011-09-27T23:43:54.951Z",
   "url": "http://code.blogger.com/2011/09/as-you-may-have-noticed-blogger.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/252207238930334231",
   "title": "Trying on the new Dynamic Views from Blogger",
   "content": "As you may have noticed, the Blogger Development Network Blog looks a lot different today. That’s because we—along with a few other Google blogs—are trying out a new set of Blogger templates called Dynamic Views.\n\n\u003ca href=\"http://buzz.blogger.com/2011/09/dynamic-views-seven-new-ways-to-share.html\"\u003eLaunched today\u003c/a\u003e, Dynamic Views is a unique browsing experience that makes it easier and faster for readers to explore blogs in interactive ways. We’re using the Classic view, but you can also preview this blog in any of the other six new views by using the view selection bar at the top left of the screen.\n\n\u003ciframe allowfullscreen=\"\" frameborder=\"0\" height=\"284\" src=\"http://www.youtube.com/embed/lpDQF2lFnBU\" width=\"500\"\u003e\u003c/iframe\u003e\n\nWe’re eager to hear what you think about the new Dynamic Views. You can submit feedback using the “Send feedback” link on the bottom right of this page. \n\nIf you like what you see here, and we hope you do, we encourage you to try out the new look(s) on your own blog—read the \u003ca href=\"http://buzz.blogger.com/2011/09/dynamic-views-seven-new-ways-to-share.html\"\u003eBlogger Buzz post\u003c/a\u003e for more info.\u003c/div\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/252207238930334231/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "237676474877526514",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-09-08T08:59:00.000Z",
   "updated": "2011-09-08T08:59:58.392Z",
   "url": "http://code.blogger.com/2011/09/blogger-json-api-now-available.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/237676474877526514",
   "title": "Blogger JSON API now available",
   "content": "Today we’re announcing the public availability of the Blogger JSON API we \u003ca href=\"http://www.google.com/events/io/2011/sessions/building-a-business-web-presence-using-blogger-apis.html\"\u003espoke about at this year’s Google I/O\u003c/a\u003e. The focus of this release is to make it easier to build applications that interoperate with Blogger by using a lightweight JSON syntax.\u003cbr /\u003e\n\u003cbr /\u003e\nOne of the driving reasons for this release is to recognize how much the world has changed during the lifetime of Blogger. Where once we built everything as desktop applications, we now spend our time building full-blown applications inside the browser frame using JavaScript and HTML5 apps.\u003cbr /\u003e\n\u003cbr /\u003e\nTo start using the Blogger JSON API, sign in to the \u003ca href=\"https://code.google.com/apis/console\"\u003eGoogle API Console\u003c/a\u003e and request Blogger API access. This will take you to a form that asks you to explain how you intend to use the API, and an estimate of your daily traffic levels. This information helps us evaluate your request for approval and give us a better understanding of how the community is using our APIs as we work to improve them.\u003cbr /\u003e\n\u003cbr /\u003e\nTo demonstrate how much easier this API is to use, especially for JavaScript mashups, here is a JavaScript renderer for the Blogger Buzz blog.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cpre\u003e&lt;html&gt;\n  &lt;script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js\"&gt;&lt;/script&gt;\n  &lt;script&gt;\n  // Request an API Key for the Blogger API from \n  // https://code.google.com/apis/console/\n  var apikey = \"YOUR API KEY HERE\";\n  \n  // You can find the blogId in the HTML source of a blog\n  var blogId = \"2399953\";\n  \n  // When the document is loaded\n  $(document).ready(function() {\n   \n    // Make a JSONP request for the Posts on the Blogger Buzz blog\n    $.ajax({\n      url:\"https://www.googleapis.com/blogger/v2/blogs/”+\n        blogId+”/posts?key=\"+apikey,\n      dataType: \"jsonp\",\n      success: function(data, textStatus, jqXHR) {\n        var items = [];   \n        // Construct a chunk of HTML for each post\n        // containing the Post title, content, and a \n        // link to the post author.\n        $.each(data.items, function(index, value) {\n          items.push(\"&lt;h2&gt;\"+value.title+\"&lt;/h2&gt;\"+value.content+\n            \"&lt;p&gt;Posted by &lt;em&gt;&lt;a href='\"+value.author.url+\"'&gt;\"+\n            value.author.displayName+\"&lt;/a&gt;&lt;/em&gt;&lt;/p&gt;\");\n        });\n\n        // And finally, append the generated content to the page body.\n        $(items.join('')).appendTo('body');\n      }\n    });\n  });\n  &lt;/script&gt;\n&lt;/html&gt;\u003c/pre\u003e\u003cbr /\u003e\n\u003cp\u003eIt is important to understand that this release is the first step on a journey of discovery, as we work with all of you to build a better API for using Blogger. Please review the \u003ca href=\"https://code.google.com/apis/blogger/docs/2.0/json/getting_started.html\"\u003edocumentation\u003c/a\u003e, and join in the discussion on \u003ca href=\"http://groups.google.com/group/bloggerdev\"\u003eBlogger Developer Group\u003c/a\u003e and let us know what we can add to the API to make it more useful for you!\u003c/p\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/237676474877526514/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "6879480944231206609",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-06-16T02:20:00.000Z",
   "updated": "2011-06-16T02:20:06.799Z",
   "url": "http://code.blogger.com/2011/06/clarifying-recent-changes-to-bloggers.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/6879480944231206609",
   "title": "Clarifying recent changes to Blogger’s feed access",
   "content": "Recently we updated Blogger’s authorization system to be more consistent with regards to the difference in roles between \u003cspan class=\"Apple-style-span\" style=\"font-family: 'Courier New', Courier, monospace;\"\u003eblogger.com\u003c/span\u003e and \u003cspan class=\"Apple-style-span\" style=\"font-family: 'Courier New', Courier, monospace;\"\u003eblogspot.com\u003c/span\u003e. As a result, some third-party integrations that depended on an unintended quirk of our previous system broke. This post explains the issue and how to update your implementation to be compliant with the correct authorization behavior.\u003cbr /\u003e\n\u003cbr /\u003e\nThe \u003ca href=\"http://code.google.com/apis/blogger/docs/2.0/developers_guide_protocol.html\"\u003eBlogger Developer’s Guide\u003c/a\u003e explains how to authenticate to our services on the URLs under \u003cspan class=\"Apple-style-span\" style=\"color: #38761d; font-family: 'Courier New', Courier, monospace;\"\u003ehttp://www.blogger.com/feeds/\u003ci\u003eprofileID\u003c/i\u003e/\u003c/span\u003e. The unintended quirk allowed authentication requests against public feed URLs hosted on the \u003cspan class=\"Apple-style-span\" style=\"font-family: 'Courier New', Courier, monospace;\"\u003eblogspot.com\u003c/span\u003e domain. Under the updated system, this is no longer permitted.\u003cbr /\u003e\n\u003cbr /\u003e\nNow, authorization is only permitted against \u003cspan class=\"Apple-style-span\" style=\"color: #38761d; font-family: 'Courier New', Courier, monospace;\"\u003ehttps://www.blogger.com/feeds/\u003c/span\u003e and \u003cspan class=\"Apple-style-span\" style=\"color: #38761d; font-family: 'Courier New', Courier, monospace;\"\u003ehttp://www.blogger.com/feeds/\u003c/span\u003e. The feeds are not going away; instead we are separating the read-only, unauthenticated subscriptions from authenticated access to Blogger’s read-write APIs.\u003cbr /\u003e\n\u003cbr /\u003e\nWe apologize that the impact of this behavior change was not made more clear initially. If you have any further questions on this matter — or Blogger development in general — please post a question in \u003ca href=\"https://groups.google.com/group/bloggerdev\"\u003eour BloggerDev forum\u003c/a\u003e.",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/6879480944231206609/comments"
   }
  },
  {
   "kind": "blogger#post",
   "id": "8398240586497962757",
   "blog": {
    "id": "3213900"
   },
   "published": "2011-03-25T19:05:00.001Z",
   "updated": "2011-03-25T19:05:33.228Z",
   "url": "http://code.blogger.com/2011/03/using-oacurl-to-explore-bloggers-api.html",
   "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/8398240586497962757",
   "title": "Using OACurl to explore Blogger’s API",
   "content": "Blogger’s GData API is now available over HTTPS using OAuth 2. These changes result in less code, increased productivity, and enhanced security. Let’s take a look at how it works using OACurl, a wrapper for the \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003ecurl\u003c/span\u003e command line tool that authenticates you using OAuth.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003ePrerequisites\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nFirst up you need to install \u003ca href=\"http://mercurial.selenic.com/\"\u003eMercurial\u003c/a\u003e and \u003ca href=\"http://maven.apache.org/\"\u003eMaven\u003c/a\u003e. Mercurial is the source revision control software used by the OACurl project. Maven is a java build system used to download and include the dependencies required by OACurl. Once we begin using \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e we will use \u003ca href=\"http://tidy.sourceforge.net/\"\u003eHTML Tidy\u003c/a\u003e to make the returned XML readable.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003eGetting OACurl\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nNow that you have installed Maven and Mercurial, you can checkout \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e and build it as follows.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ hg clone https://oacurl.googlecode.com/hg/ oacurl\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ cd oacurl\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ mvn assembly:assembly\u003c/div\u003e\u003cbr /\u003e\nOnce you have done this you will have a shell script in your current directory called \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e that you can use to invoke \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e with all the appropriate Java class paths set for you.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003eLogging into Blogger\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nLogging into Blogger using OAuth involves doing a round trip to Google’s servers to grant access for third parties. In the case of \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e, this involves invoking a web browser that shows you that oacurl is requesting access to your Blogger account. \u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ ./oacurl login --blogger\u003c/div\u003e\u003cbr /\u003e\nOnce you have granted access, then you will be able to explore Blogger’s API using \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003eoacurl\u003c/span\u003e.\u003cbr /\u003e\nRetrieving a list of your Blogger blogs\u003cbr /\u003e\n\u003cbr /\u003e\nA good place to start is to list out your blogs. This is an Atom feed where each item in the list is a blog owned by the user who requested it. \u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ ./oacurl https://www.blogger.com/feeds/default/blogs\u003c/div\u003e\u003cbr /\u003e\nTo see the blogs of a specific user you can change the default for a specific user’s profile id instead. For instance, here is a list of my blogs.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ ./oacurl https://www.blogger.com/feeds/16258312240222542576/blogs\u003c/div\u003e\u003cbr /\u003e\nTo make the output XML readable, I suggest piping the output from the commands through \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003etidy\u003c/span\u003e like this:\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ ./oacurl https://www.blogger.com/feeds/default/blogs | tidy -xml -quiet -indent\u003c/div\u003e\u003cbr /\u003e\nI will leave that off the following commands for readability.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003eRetrieving the feed of a specific Blogger blog\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nTo retrieve the content of a blogger blog, we select the blog we want from the list of blogs in the blog feed, and then follow the appropriate link. In this case we are using the post link as it stays within the scope of our OAuth authorisation.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&lt;link rel='http://schemas.google.com/g/2005#post'\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&nbsp;&nbsp;&nbsp; type='application/atom+xml' href= 'http://www.blogger.com/feeds/4967929378133675647/posts/default' /&gt;\u003c/div\u003e\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003ePosting a new entry to a feed\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nIf I wanted to post a new entry to my test blog, all I need to do is create a new entry in Atom format, and post it to the above url. So, I create a file with the following content called \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003epost.xml\u003c/span\u003e:\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&lt;entry xmlns='http://www.w3.org/2005/Atom'&gt;\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&nbsp; &lt;title type=\"text\"&gt;Posting via OACurl&lt;/title&gt;\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&nbsp; &lt;content type=\"xhtml\"&gt;And some &lt;b&gt;content&lt;/b&gt;.&lt;/content&gt;\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e&lt;/entry&gt;\u003c/div\u003e\u003cbr /\u003e\nI can submit this to Blogger to create a new post like this:\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ cat post.xml | ./oacurl -X POST https://www.blogger.com/feeds/4967929378133675647/posts/default\u003c/div\u003e\u003cbr /\u003e\nThis, of course, won’t work for you, as my test blog is only set up for me to post to. Modify the post URL in the command to match the one from one of the Blogger blogs you own. The result from the command is the fully expanded Atom entry for the post that was just created. \u003cbr /\u003e\n\u003cbr /\u003e\nThis Atom entry contains the information you need to modify it. The link with \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003erel='edit'\u003c/span\u003e is the magic entry. For blogger, this is the same as the \u003cspan style=\"font-family: 'Courier New', Courier, monospace;\"\u003erel='self'\u003c/span\u003e link. To edit the content for the blog post I just created, first I retrieve the content at the edit URL:\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ ./oacurl https://www.blogger.com/feeds/4967929378133675647/posts/default/2170959137511831372 &gt; post-edit.xml\u003c/div\u003e\u003cbr /\u003e\nWe can now modify the title and content using a text editor, and then PUT it back, in proper REST style.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ vi post-edit.xml\u003c/div\u003e\u003cdiv style=\"font-family: &quot;Courier New&quot;,Courier,monospace;\"\u003e$ cat post-edit.xml | ./oacurl -X PUT https://www.blogger.com/feeds/4967929378133675647/posts/default/2170959137511831372 \u003c/div\u003e\u003cbr /\u003e\nThe Atom representation also contains the information required to create, retrieve, and delete the comments on this entry. See if you can spot the appropriate URLs in the output XML.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003eUsing the libraries\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nYou can use various libraries with the Blogger GData APIs, for example the Java GData client, but it is very useful to understand what the library is doing for you under the covers. And exploring is fun!\u003cbr /\u003e\n\u003cbr /\u003e\nIf you have any questions after reading this post, please feel free to post your questions to the \u003ca href=\"http://groups.google.com/group/bloggerdev/\"\u003eBlogger Dev Google Group\u003c/a\u003e.\u003cbr /\u003e\n\u003cbr /\u003e\n\u003cspan style=\"font-size: large;\"\u003eReferences\u003c/span\u003e\u003cbr /\u003e\n\u003cbr /\u003e\nOACurl: \u003ca href=\"http://code.google.com/p/oacurl/\"\u003ehttp://code.google.com/p/oacurl/\u003c/a\u003e\u003cbr /\u003e\nOAuth: \u003ca href=\"http://oauth.net/\"\u003ehttp://oauth.net/\u003c/a\u003e \u003cbr /\u003e\nMercurial: \u003ca href=\"http://mercurial.selenic.com/\"\u003ehttp://mercurial.selenic.com/\u003c/a\u003e\u003cbr /\u003e\nMaven: \u003ca href=\"http://maven.apache.org/\"\u003ehttp://maven.apache.org/\u003c/a\u003e\u003cbr /\u003e\nAtom overview: \u003ca href=\"http://en.wikipedia.org/wiki/Atom_%28standard%29\"\u003ehttp://en.wikipedia.org/wiki/Atom_(standard)\u003c/a\u003e \u003cbr /\u003e\nAtom Specification: \u003ca href=\"http://www.atomenabled.org/developers/syndication/atom-format-spec.php\"\u003ehttp://www.atomenabled.org/developers/syndication/atom-format-spec.php\u003c/a\u003e \u003cbr /\u003e\nHTML Tidy: \u003ca href=\"http://www.w3.org/People/Raggett/tidy/\"\u003ehttp://www.w3.org/People/Raggett/tidy/\u003c/a\u003e\u003cbr /\u003e\nJava GData Client: \u003ca href=\"http://code.google.com/p/gdata-java-client/\"\u003ehttp://code.google.com/p/gdata-java-client/\u003c/a\u003e \u003cbr /\u003e\nBlogger Dev Google group: \u003ca href=\"http://groups.google.com/group/bloggerdev\"\u003ehttp://groups.google.com/group/bloggerdev\u003c/a\u003e",
   "author": {
    "id": "16258312240222542576",
    "displayName": "Brett Morgan",
    "url": "http://www.blogger.com/profile/16258312240222542576",
    "image": {
     "url": "http://img2.blogblog.com/img/b16-rounded.gif"
    }
   },
   "replies": {
    "totalItems": "0",
    "selfLink": "https://www.googleapis.com/blogger/v2/blogs/3213900/posts/8398240586497962757/comments"
   }
  }
 ]
}
''';
  
  Map postList = JSON.parse(jsonPostList);
  Element contentDiv = document.query('#content');
  int count = 0;
  
  postList['items'].forEach((post) {
    contentDiv.innerHTML += """
      <h2>${post['title']}</h2>
      ${post['content']}
      <hr>
    """;
  });
  
}


