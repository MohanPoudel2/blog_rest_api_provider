import 'package:blog_rest_api_provider/data/model/blog_put_response.dart';
import 'package:blog_rest_api_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_provider/provider/blog_put_provider/blog_put_state.dart';
import 'package:flutter/cupertino.dart';

class BlogPutNotifier extends ChangeNotifier{
  BlogPutState getPutState=BlogPutLoading();
  void blogPut({required int id,required String title,required String body})async{
   final BlogApiService apiService=BlogApiService();
   try{
   BlogPutResponse blogPutResponse=await apiService.putPost(id: id, title: title, body: body);
   getPutState =BlogPutSuccess(blogPutResponse);
   notifyListeners();
   }catch(e){
     getPutState =BlogPutFailed('Ops!Something went wrong!');
     notifyListeners();
   }

  }
}