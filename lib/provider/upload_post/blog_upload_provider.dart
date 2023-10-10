import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/upload_post/blog_upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BlogUploadNotifier extends ChangeNotifier {
  BlogUploadUiState blogUploadUiState = BlogUploadFormState();
  final BlogApiService _apiService = BlogApiService();

  void upload(
      {required String title,
      required String body,
      required FormData? data}) async {
    blogUploadUiState = BlogUploadLoading(0);
    notifyListeners();
    try {
      BlogUploadResponse blogUploadResponse = await _apiService.uploadPost(
        title: title,
        body: body,
        data: data,
        sendProgress: (int send,int size) {
          double progress=((send/size)*100);
          blogUploadUiState=BlogUploadLoading(progress);
          notifyListeners();
      }
      );
      blogUploadUiState = BlogUploadSuccess(blogUploadResponse);
      notifyListeners();
    } catch (e) {
      blogUploadUiState = BlogUploadFailed('Something Wrong!');
      notifyListeners();
    }

  }
  void tryAgain(){
    blogUploadUiState=BlogUploadFormState();
    notifyListeners();
  }
}
