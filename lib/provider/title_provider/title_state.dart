import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';


abstract class GetTitleState {}

class TitleLoading extends GetTitleState{
}
class TitleSuccessFul extends GetTitleState{
 final GetOnePostResponse getOnePostResponse;

  TitleSuccessFul(this.getOnePostResponse);
}
class TitleFailed extends GetTitleState{
  final String errorMessage;

  TitleFailed(this.errorMessage);

}

