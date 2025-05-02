import 'package:church_app/core/auth/data/auth_service_impl.dart';
import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_viewmodel.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_viewmodel.dart';
import 'package:riverpod/riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthServiceImpl());

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
      final authService = ref.watch(authServiceProvider);
      return LoginViewModel(authService: authService);
    });

final registerViewModelProvider =
    StateNotifierProvider.autoDispose<RegisterViewModel, RegisterState>((ref) {
      final authService = ref.watch(authServiceProvider);
      return RegisterViewModel(authService: authService);
    });
