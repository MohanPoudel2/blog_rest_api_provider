import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';
import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:path_provider/path_provider.dart';
import '../model/get_one_post_response.dart';

class BlogApiService {
  static const String baseUrl = "http://rubylearner.com:5000/";

  BlogApiService() {
    getTemporaryDirectory().then((dir) {});
  }

  Future<List<GetAllPostResponse>> getAllPost() async {
    Dio dio = await _getDio();
    final postListResponse = await dio.get(
      '${baseUrl}posts',
    );
    final postList = (postListResponse.data as List).map((e) {
      return GetAllPostResponse.fromJson(e);
    }).toList();
    return postList;
  }

  Future<GetOnePostResponse> getOnePost(int id) async {
    Dio dio = await _getDio();

    final postResponse = await dio.get(
      '${baseUrl}post?id=$id',
    );
    final postList = postResponse.data as List;
    final post = GetOnePostResponse.fromJson(postList[0]);
    return post;
  }

  Future<BlogUploadResponse> uploadPost(
      {required String title,
      required String body,
      required FormData? data,
      required Function(int, int) sendProgress}) async {
    Dio dio = await _getDio();

    final uploadPostResponse = await dio.post(
        '${baseUrl}post?title=$title&body=$body',
        data: data,
        onSendProgress: sendProgress);
    return BlogUploadResponse.fromJson(uploadPostResponse.data);
  }
  Future deletePost({required int id}) async{
    Dio dio=await _getDio();
    final deleteOnePost=await dio.delete('${baseUrl}post?id=$id');
    return deleteOnePost;
  }

  Future<Dio> _getDio() async {
    Dio dio = Dio();
    final dir = await getTemporaryDirectory();
    final fileStore = FileCacheStore(dir.path);
    CacheOptions cacheOptions = CacheOptions(store: fileStore,hitCacheOnErrorExcept: []);
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    return dio;
  }
}
