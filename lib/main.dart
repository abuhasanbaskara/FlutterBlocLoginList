import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login_list/blocs/login_bloc.dart';
import 'package:flutter_bloc_login_list/services/api_service.dart';
import 'package:flutter_bloc_login_list/views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM BLoC Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => LoginBloc(apiService: ApiService()),
        child: LoginView(),
      ),
    );
  }
}
