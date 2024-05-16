import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login_list/models/user.dart';
import 'package:flutter_bloc_login_list/services/api_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  int currentPage = 1;
  bool hasReachedMax = false;

  UserBloc({required this.apiService}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (state is UserLoading) return;

    final currentState = state;
    var users = <User>[];

    if (currentState is UserLoaded) {
      users = currentState.users;
      currentPage = currentState.page;
      hasReachedMax = currentState.hasReachedMax;
    }

    if (hasReachedMax) {
      print('Reached max users');
      return;
    }

    emit(UserLoading(users: users));

    try {
      print('Fetching users from page: $currentPage');
      final response = await apiService.fetchUsers(page: currentPage);
      if (response.isEmpty) {
        hasReachedMax = true;
      } else {
        currentPage++;
        users.addAll(response);
      }
      print('Fetched ${response.length} users from page: $currentPage');
      emit(UserLoaded(
        users: users,
        page: currentPage,
        hasReachedMax: response.isEmpty,
      ));
    } catch (error) {
      print('Error fetching users: $error');
      emit(UserError(error: error.toString()));
    }
  }
}