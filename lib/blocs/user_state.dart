part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  final List<User> users;

  UserLoading({required this.users});

  @override
  List<Object> get props => [users];
}

class UserLoaded extends UserState {
  final List<User> users;
  final int page;
  final bool hasReachedMax;

  UserLoaded({
    required this.users,
    required this.page,
    required this.hasReachedMax,
  });

  UserLoaded copyWith({
    List<User>? users,
    int? page,
    bool? hasReachedMax,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, page, hasReachedMax];
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});

  @override
  List<Object> get props => [error];
}
