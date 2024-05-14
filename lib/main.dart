import 'package:czy_dojade/blocs/login_screen/login_cubit.dart';
import 'package:czy_dojade/repositories/auth_repository.dart';
import 'package:czy_dojade/screens/home_screen.dart';
import 'package:czy_dojade/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthRepository('http://192.168.100.8:8080');
    return MaterialApp(
      title: 'Czy dojade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0049B7)
        ),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(providers: [
        RepositoryProvider(create: (_) => auth)
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => LoginCubit(auth))
      ],
      child: LoginScreen())),
    );
  }
}