part of 'add_user_cubit.dart';

sealed class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

final class AddUserInitial extends AddUserState {}
final class AddUserLoading extends AddUserState {}
final class AddUserSuccess extends AddUserState {
  final String data;

  const AddUserSuccess({required this.data});
}
final class AddUserFailure extends AddUserState {
  final String error;

  const AddUserFailure({required this.error});
}



