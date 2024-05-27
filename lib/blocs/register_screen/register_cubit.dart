import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repositories/auth_repository.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const RegisterState.initial());

  void registerWithEmail(
      String email, String password, String name, String lastName) async {
    emit(const RegisterState.loading());
    try {
      await _authRepository.createUserWithEmail(email, password, name, lastName);
    } catch (e) {
      emit(RegisterState.error(e.toString()));
      return;
    }
    emit(const RegisterState.success());
  }
}
