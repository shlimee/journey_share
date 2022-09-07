import 'package:journey_share/core/error/failures.dart';

class AuthServerFailure extends Failure {
  @override
  final String message;
  const AuthServerFailure({required this.message})
      : super(message: 'Authentication server failure!');

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CredentialsDoesntMatch extends Failure {
  const CredentialsDoesntMatch()
      : super(message: 'Could not find account with these credentials!');

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CredentialsAlreadyTakenFailure extends Failure {
  const CredentialsAlreadyTakenFailure()
      : super(message: 'These credentials are taken!');

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
