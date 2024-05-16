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
            if (state is UserLoading && state.users.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      !state.hasReachedMax) {
                    context.read<UserBloc>().add(FetchUsers(page: state.page));
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.hasReachedMax ? state.users.length : state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final user = state.users[index];
                    return ListTile(
                      leading: Image.network(user.avatar),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    );
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.error));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}