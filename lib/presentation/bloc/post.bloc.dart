import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/usecases/get_posts.dart';
import 'package:journey_share/presentation/bloc/event/post.events.dart';
import 'package:journey_share/presentation/bloc/state/post.state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  GetPosts getPosts;

  @override
  PostState get initialState => EmptyState();

  PostBloc({required this.getPosts}) : super(EmptyState()) {
    on<OnLoadingPosts>((event, emit) async {
      print('loading Posts..');
      final postResult = await getPosts.call(NoParams());
      postResult.fold(
        (failure) {
          print(failure);
          emit(ErrorState(
              errorCode: 414, errorMessage: failure.message.toString()));
        },
        (result) {
          print("success: " + result.toString());
          emit(LoadedState(fetchedPosts: result));
        },
      );
    });

    on<OnLoaded>((event, emit) {
      print('loaded Posts!');
    });
  }
}
