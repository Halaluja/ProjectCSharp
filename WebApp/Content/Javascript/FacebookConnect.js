window.fbAsyncInit = function () {
    FB.init({
        appId: '641985593001832',
        cookie: true,
        xfbml: true,
        version: 'v4.0'
    });
    gapi.load('auth2', function () {
        gapi.auth2.init({ client_id: '761735900256-c5blrp9cn598t6p59t6e90bfopouhkuf.apps.googleusercontent.com' });
    });
};
(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) { return; }
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

