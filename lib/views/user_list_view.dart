import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_list/blocs/user_bloc.dart';
import 'package:flutter_bloc_login_list/services/api_service.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(apiService: ApiService())..add(FetchUsers(page: 1)),
      child: Scaffold(
        appBar: AppBar(title: Text('User List')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    leading: Image.network(user.avatar),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  );
                },
              );
            } else if (state is UserError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('No users found'));
            }
          },
        ),
      ),
    );
  }
}