import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:czy_dojade/helpers/string_ext.dart';
import 'package:czy_dojade/screens/home_screen.dart';
import 'package:czy_dojade/screens/register_screen.dart';
import 'package:czy_dojade/widgets/logo_widget.dart';
import 'package:flutter/material.dart';

import '../blocs/login_screen/login_cubit.dart';

class LoginScreen extends BlocConsumerWidget<LoginCubit, LoginState> {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormFieldState> emailKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isObscured = ValueNotifier(true);

  @override
  void listener(BuildContext context, LoginCubit bloc, LoginState state) {
    state.maybeMap(
      error: (state) {
        isLoading.value = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      },
      success: (state) => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const HomeScreen()), (_) => false),
      loading: (state) => isLoading.value = true,
      orElse: () => isLoading.value = (state is Loading),
    );
  }

  @override
  Widget build(context, bloc, state) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(size: 250),
              const SizedBox(
                height: 46,
              ),
              ..._form(bloc, theme, context),
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Divider(
                  color: theme.primaryColorLight,
                ),
              ),
              InkWell(
                child: const Text(
                  'Don\'t have an account? Create one now!',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _form(LoginCubit bloc, ThemeData theme, BuildContext context) {
    return [
      TextFormField(
        key: emailKey,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 32, maxWidth: 32),
          labelText: 'E-mail',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'E-mail can\'t be empty';
          }
          return value.matchesEmail() ? null : 'E-mail invalid';
        },
      ),
      const SizedBox(height: 16),
      ValueListenableBuilder(
        builder: (_, obscured, __) => TextFormField(
          key: passwordKey,
          obscureText: obscured,
          decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 32, maxWidth: 32),
              suffixIconConstraints:
                  const BoxConstraints(maxHeight: 32, maxWidth: 40),
              suffixIcon: InkWell(
                onTap: () => isObscured.value = !obscured,
                child: const Padding(
                  padding: EdgeInsets.only(right: 32.0),
                  child: Icon(Icons.visibility, size: 32),
                ),
              )),

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password can\'t be empty';
            }
            return value.matchesPassword() ? null : 'Password invalid';
          },
        ),
        valueListenable: isObscured,
      ),
      const SizedBox(height: 12),
      Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          child: const Text(
            'Forgot your password?',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
          },
        ),
      ),
      const SizedBox(height: 20),
      ValueListenableBuilder(
        builder: (_, isLoading, __) => ElevatedButton(
          // style: theme.flatButtonThemeInverted,
          onPressed: isLoading ? null : () => _validateAndLogin(bloc),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        valueListenable: isLoading,
      ),
    ];
  }

  _validateAndLogin(LoginCubit bloc) {
    if (formKey.currentState!.validate()) {
      bloc.loginWithEmail(
          emailKey.currentState!.value, passwordKey.currentState!.value);
    }
  }
}
