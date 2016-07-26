var postsWrapper = document.querySelector('#content')
var posts = postsWrapper.querySelectorAll('.post.type-post.status-publish')

function parsePosts() {
    pos = []
    
    for (var i = 0; i < posts.length; i++) {
        var post = posts[i];
        var postTitle = post.querySelector('h2.entry-title a').textContent;
        var postURL = post.querySelector('h2.entry-title a').getAttribute('href');
        pos.push({'postTitle' : postTitle, 'postURL' : postURL});
    }
    
    return pos
}

var postsList = parsePosts();
webkit.messageHandlers.didGetPosts.postMessage(postsList);