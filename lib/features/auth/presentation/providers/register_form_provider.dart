import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String fullName;
  final Email email;
  final Password password;
  final Password password2;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.fullName = "",
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.password2 = const Password.pure()});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          Email? email,
          Password? password,
          Password? password2}) =>
      RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        password2: password2 ?? this.password2,
      );
}

class RegisterFormNotifier extends StateNotifier<RegisterFormNotifier> {
  RegisterFormNotifier(super.state);
}
