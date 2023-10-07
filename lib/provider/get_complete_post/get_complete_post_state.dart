
import 'package:blog_rest_api_provider/data/model/get_one_post_response.dart';

abstract class GetCompletePostState{}
class GetCompletePostLoading extends GetCompletePostState{}


class GetCompletePostSuccess extends GetCompletePostState{
   final GetOnePostResponse getOnePostResponse;

  GetCompletePostSuccess(this.getOnePostResponse);
}
class GetCompletePostFailed extends GetCompletePostState{
  final String errorMessage;

  GetCompletePostFailed(this.errorMessage);

}
