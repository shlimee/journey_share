import 'package:journey_share/core/error/failures.dart';

class PostFailure extends Failure {
  @override
  final String message;
  const PostFailure({required this.message})
      : super(message: 'Authentication server failure!');

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
