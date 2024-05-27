import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:czy_dojade/helpers/string_ext.dart';
import 'package:czy_dojade/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../blocs/register_screen/register_cubit.dart';
import '../widgets/logo_widget.dart';

class RegisterScreen extends BlocConsumerWidget<RegisterCubit, RegisterState> {
  RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormFieldState> nameKey = GlobalKey();
  final GlobalKey<FormFieldState> lastNameKey = GlobalKey();
  final GlobalKey<FormFieldState> emailKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordKey = GlobalKey();
  final GlobalKey<FormFieldState> repeatKey = GlobalKey();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<bool> isObscured = ValueNotifier(true);

  @override
  void listener(BuildContext context, RegisterCubit bloc, RegisterState state) {
    state.maybeMap(
      error: (state) {
        isLoading.value = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      },
      loading: (state) => isLoading.value = true,
      success: (state) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (_) => false);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Yippee')));
      },
      orElse: () => isLoading.value = (state is Loading),
    );
  }

  @override
  Widget build(context, bloc, state) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(size: 250),
            const SizedBox(
              height: 46,
            ),
            _form(bloc, theme),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(
                color: theme.primaryColorLight,
              ),
            ),
            InkWell(
              child: const Text(
                'Already have an account? Login here!',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _form(RegisterCubit bloc, ThemeData theme) {
    return Form(
      key: formKey,
      child: ValueListenableBuilder(
          valueListenable: isObscured,
          builder: (_, obscured, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  key: nameKey,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 32, maxWidth: 32),
                    labelText: 'First name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: lastNameKey,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    prefixIconConstraints:
                    const BoxConstraints(maxHeight: 32, maxWidth: 32),
                    labelText: 'Last name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: emailKey,
                  style:
                      const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
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
                TextFormField(
                  key: passwordKey,
                  style:
                      const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
                  textAlign: TextAlign.center,
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
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    return value.matchesPassword() ? null : 'Password invalid';
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: repeatKey,
                  style:
                      const TextStyle(color: Color(0xFFB1E3F9), fontSize: 20),
                  textAlign: TextAlign.center,
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
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordKey.currentState!.value) {
                      return 'Passwords aren\'t the same';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (_, isLoading, __) {
                      return SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => _validateAndRegister(bloc),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
          }),
    );
  }

  _validateAndRegister(RegisterCubit bloc) {
    if (formKey.currentState!.validate()) {
      bloc.registerWithEmail(
          emailKey.currentState!.value, passwordKey.currentState!.value, nameKey.currentState!.value, lastNameKey.currentState!.value);
    }
  }
}
