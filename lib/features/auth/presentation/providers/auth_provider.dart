import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastucture.dart';

enum AuthStatus { checking, authenticated, notAuthtenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, User? user, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
      return;
    } on CustomError catch (e) {
      print("[CUSTOM]"+e.message);
      logout(e.message);
    } catch (e) {
      print("[NOT-CONTROLLED]" + e.toString());
      logout("Something wen't wrong");
    }
  }

  void _setLoggedUser(User user) {
    print("user::" + user.fullName);
    // TODO: necesito guardar el token físicamente
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
    print("finished");
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {}

  Future<void> logout([String? errorMessage]) async {
    // TODO: Handle token
    state = state.copyWith(
        authStatus: AuthStatus.notAuthtenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});
