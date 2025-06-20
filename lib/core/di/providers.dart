import 'package:church_app/core/auth/data/auth_service_impl.dart';
import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_viewmodel.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_viewmodel.dart';
import 'package:riverpod/riverpod.dart';
import '../auth/presentation/viewmodels/google_sign_in/google_sign_in_state.dart';
import '../auth/presentation/viewmodels/google_sign_in/google_sign_in_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authServiceProvider = Provider<AuthService<AuthResponse>>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthServiceImpl(supabaseClient: supabaseClient);
});

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

final googleSignInViewModelProvider =
    StateNotifierProvider.autoDispose<GoogleSignInViewModel, GoogleSignInState>(
      (ref) {
        final authService = ref.watch(authServiceProvider);
        return GoogleSignInViewModel(authService: authService);
      },
    );
