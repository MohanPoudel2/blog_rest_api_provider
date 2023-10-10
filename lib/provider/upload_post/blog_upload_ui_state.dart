import 'package:blog_rest_api_provider/data/model/blog_upload_response.dart';

abstract class BlogUploadUiState{}
class BlogUploadFormState extends BlogUploadUiState{}
class BlogUploadLoading extends BlogUploadUiState{
  final double progress;

  BlogUploadLoading(this.progress);

}
class BlogUploadSuccess extends BlogUploadUiState{
  final BlogUploadResponse blogUploadResponse;

  BlogUploadSuccess(this.blogUploadResponse);


}
class BlogUploadFailed extends BlogUploadUiState{
  final String errorMessage;

  BlogUploadFailed(this.errorMessage);

}