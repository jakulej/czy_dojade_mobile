import 'package:czy_dojade/blocs/login_screen/login_cubit.dart';
import 'package:czy_dojade/blocs/register_screen/register_cubit.dart';
import 'package:czy_dojade/repositories/auth_repository.dart';
import 'package:czy_dojade/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  final auth = AuthRepository();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => auth),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginCubit(auth)),
          BlocProvider(create: (_) => RegisterCubit(auth))
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Czy dojade',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0049B7)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
