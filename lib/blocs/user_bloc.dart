import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_list/models/user.dart';
import 'package:flutter_bloc_login_list/services/api_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc({required this.apiService}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final users = await apiService.fetchUsers(event.page);
      emit(UserLoaded(users: users));
    } catch (error) {
      emit(UserError(error: error.toString()));
    }
  }
}