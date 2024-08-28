part of 'get_user_cubit.dart';

sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => [];
}

final class GetUserInitial extends GetUserState {}
final class GetUserLoading extends GetUserState {}

final class GetUserSuccess extends GetUserState {
  final List<UsersModel> data;

  const GetUserSuccess({required this.data});
}
final class GetUserError extends GetUserState {
  final String err;

 const GetUserError({required this.err});
}

