import 'failures.dart';

class SearchFailure extends Failure {
  @override
  final String message;
  const SearchFailure({required this.message})
      : super(message: 'Search failure!');

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
