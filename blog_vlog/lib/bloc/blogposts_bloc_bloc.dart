import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'blogposts_bloc_event.dart';
part 'blogposts_bloc_state.dart';

class BlogpostsBlocBloc extends Bloc<BlogpostsBlocEvent, BlogpostsBlocState> {
  BlogpostsBlocBloc() : super(BlogpostsBlocInitial()) {
    on<BlogpostsBlocEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<InitialEvent>((event, emit) {
      //  implement event handler
      emit(InitialEvent() as BlogpostsBlocState);
    });

    on<LoginEvent>(((event, emit) {
      emit(LoginEvent() as BlogpostsBlocState);
    }));
  }
}
