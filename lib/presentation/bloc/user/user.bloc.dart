import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/domain/usecases/get_user.dart';
import 'package:journey_share/presentation/bloc/user/user.event.dart';
import 'package:journey_share/presentation/bloc/user/user.state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  UserState get initialState => EmptyState();

  UserBloc({required this.getUser}) : super(EmptyState()) {
    on<FetchUser>(
      (FetchUser event, emit) async {
        final result = await getUser(GetUserParams(userId: event.userId));

        return result.fold((l) {
          print(l.toString());
          return UserError(
              errorCode: 414, errorMessage: 'error fetching user!');
        }, (r) {
          print('user loaded');
          emit(UserLoaded(user: r));
        });
      },
    );
  }
}
