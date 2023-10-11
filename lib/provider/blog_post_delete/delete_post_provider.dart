import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/blog_post_delete/post_delete_state.dart';
import 'package:flutter/cupertino.dart';

class DeletePostNotifier extends ChangeNotifier{
  DeletePostState deletePostState=DeletePostLoading();
  final BlogApiService _apiService=BlogApiService();
  void deleteOnePost({required int id}) async{
    deletePostState= DeletePostLoading();
    try{
     await _apiService.deletePost(id: id);
     deletePostState =DeletePostSuccess('Successfully Deleted');
     notifyListeners();
    }catch(e){
      deletePostState=DeletePostFailed('Deletion Failed!Please try again');
      notifyListeners();
    }
  }
}