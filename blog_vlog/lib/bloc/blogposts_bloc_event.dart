part of 'blogposts_bloc_bloc.dart';

@immutable
abstract class BlogpostsBlocEvent {}

class InitialEvent extends BlogpostsBlocEvent{}

class LoginEvent extends BlogpostsBlocEvent{}

class SignupEvent extends BlogpostsBlocEvent{}

class AddBlogPostEvent extends BlogpostsBlocEvent{}

class GetBlogPostsEvent extends BlogpostsBlocEvent{}