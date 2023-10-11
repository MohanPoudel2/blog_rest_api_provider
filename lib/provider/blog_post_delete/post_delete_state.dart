abstract class DeletePostState {}

class DeletePostLoading extends DeletePostState {}

class DeletePostSuccess extends DeletePostState {
  final String deleted;

  DeletePostSuccess(this.deleted);

}

class DeletePostFailed extends DeletePostState {
  final String errorMessage;

  DeletePostFailed(this.errorMessage);
}
