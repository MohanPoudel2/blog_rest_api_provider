import 'package:blog_rest_api_provider/data/model/blog_put_response.dart';

abstract class BlogPutState {}

class BlogPutLoading extends BlogPutState{

}

class BlogPutSuccess extends BlogPutState{
 final BlogPutResponse blogPutResponse;

  BlogPutSuccess(this.blogPutResponse);
}
class BlogPutFailed extends BlogPutState{
  final String errorMessage;

  BlogPutFailed(this.errorMessage);

}

