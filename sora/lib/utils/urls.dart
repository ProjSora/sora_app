import 'package:http/http.dart' as http;

var loginUrl = Uri.http('localhost:8000', 'sora/app_login');
var registUrl = Uri.http('localhost:8000', 'sora/regist_user');
var emailAuthUrl = Uri.http('localhost:8000', 'sora/email_auth');
var phoneAuthUrl = Uri.http('localhost:8000', 'sora/phone_auth');

var readUserUrl = Uri.http('localhost:8000', 'sora/read_user');
var updateUserUrl = Uri.http('localhost:8000', 'sora/update_user');
var deleteUserUrl = Uri.http('localhost:8000', 'sora/delete_user');
var writePostUrl = Uri.http('localhost:8000', 'sora/write_post');
var readPostUrl = Uri.http('localhost:8000', 'sora/read_post');
var updatePostUrl = Uri.http('localhost:8000', 'sora/update_post');
var deletePostUrl = Uri.http('localhost:8000', 'sora/delete_post');


/**
 * django urls.py
 * urlpatterns = [
    url('app_login', views.AppLogin.as_view(), name='app_login'),
    url('regist_user', views.RegistUser.as_view(), name='regist_user'),
    url('read_user', views.ReadUserInfo.as_view(), name='read_user'),
    url('update_user', views.UpdateUserInfo.as_view(), name='update_user'),
    url('delete_user', views.DeleteUserInfo.as_view(), name='delete_user'),
    url('write_post', views.WritePost.as_view(), name='write_post'),
    url('read_post', views.ReadPost.as_view(), name='read_post'),
    url('update_post', views.UpdatePost.as_view(), name='update_post'),
    url('delete_post', views.DeletePost.as_view(), name='delete_post'),
]
 */
