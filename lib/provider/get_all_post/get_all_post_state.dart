import '../../data/model/get_all_post_response.dart';

abstract class GetAllPostState {}

class GetAllPostLoading extends GetAllPostState {}

class GetAllPostSuccessful extends GetAllPostState {
  final List<GetAllPostResponse> getAllPostList;

  GetAllPostSuccessful(this.getAllPostList);
}

class GetAllPostFail extends GetAllPostState {
  final String errorMessage;

  GetAllPostFail(this.errorMessage);
}
