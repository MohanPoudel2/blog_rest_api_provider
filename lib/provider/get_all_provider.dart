
import 'package:blog_rest_api_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/get_all_post_state.dart';
import 'package:flutter/foundation.dart';

class GetAllProvider extends ChangeNotifier{
  GetAllPostState getAllPostState=GetAllPostLoading();
  final BlogApiService _apiService=BlogApiService();
   Future<void> getAllPost()async {
     getAllPostState=GetAllPostLoading();
     notifyListeners();
     try{
       final List<GetAllPostResponse> getAllPostList=await  _apiService.getAllPost();
       getAllPostState=GetAllPostSuccessful(getAllPostList);
       notifyListeners();
     }catch(e){
       getAllPostState=GetAllPostFail(e.toString());
     }


   }
}