import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:journey_share/core/usecase.dart';
import 'package:journey_share/domain/usecases/get_posts.dart';
import 'package:journey_share/domain/usecases/get_user_posts.dart';
import 'package:journey_share/domain/usecases/publish.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/post/post.state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  final GetUserPosts getUserPosts;
  final Publish publish;

  @override
  PostState get initialState => EmptyState();

  PostBloc({
    required this.getPosts,
    required this.publish,
    required this.getUserPosts,
  }) : super(EmptyState()) {
    on<OnLoadingAllPosts>((event, emit) async {
      final postResult = await getPosts.call(NoParams());
      postResult.fold(
        (failure) {
          print(failure.message);
          emit(PostErrorState(
              errorCode: 414, errorMessage: failure.message.toString()));
        },
        (result) {
          emit(LoadedState(fetchedPosts: result));
        },
      );
    });
    on<OnLoadingUserPosts>((event, emit) async {
      final postResult =
          await getUserPosts.call(GetUserPostsParams(userId: event.userId));
      postResult.fold(
        (failure) {
          emit(PostErrorState(
              errorCode: 414, errorMessage: failure.message.toString()));
        },
        (result) {
          emit(
              LoadedUserPostsState(fetchedPosts: result, userId: event.userId));
        },
      );
    });
    on<OnLoaded>((event, emit) {});
    on<OnCreate>((event, emit) async {
      emit(CreateState(imageFile: event.fileToUpload));
    });
    on<OnPublish>((event, emit) async {
      final res = await _publish(event);
    });
  }

  dynamic _publish(OnPublish event) async {
    final response = await publish(
        Params(file: event.fileToPublish, description: event.description));
    return response;
  }
}
