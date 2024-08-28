import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import '../../repositories/user_repo.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
   final _repo = UsersRepo();
  void getUser() async {
    emit(GetUserLoading());
    try {
      final data = await _repo.getListUsers();
      emit(GetUserSuccess(data: data));
    } catch (e) {
      emit(GetUserError(err: e.toString()));
    }
  }
}
