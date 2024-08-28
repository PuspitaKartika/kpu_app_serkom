import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpu_app_serkom/model/user_model.dart';
import 'package:kpu_app_serkom/repositories/user_repo.dart';

part 'add_user_state.dart';

class   AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit() : super(AddUserInitial());

  final _repo = UsersRepo();
  void addUser(UsersModel data) async {
    emit( AddUserLoading());
    try {
      await _repo.addUsers(data);
      emit( const AddUserSuccess(data: "berhasil"));
    } catch (e) {
      emit( AddUserFailure(error: e.toString()));
    }
  }
}
