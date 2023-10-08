import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/title_provider/title_state.dart';
import 'package:flutter/cupertino.dart';

class GetTitleNotifier extends ChangeNotifier{
  GetTitleState getTitleState=TitleLoading();
 final BlogApiService _apiService=BlogApiService();
 void getTitle({required int id}) async{
   getTitleState=TitleLoading();
   try{
     GetOnePostResponse getOnePostResponse=await _apiService.getOnePost(id);
     getTitleState=TitleSuccessFul(getOnePostResponse);
     notifyListeners();
   }catch(e){
     getTitleState=TitleFailed('error');
     notifyListeners();
   }
 }
}