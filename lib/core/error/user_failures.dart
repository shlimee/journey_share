import 'package:journey_share/core/error/failures.dart';

class UserFailure extends Failure {
  @override
  final String message;
  const UserFailure({required this.message}) : super(message: 'User failure!');

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
