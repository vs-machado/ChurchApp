import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Serviço de autenticação do Supabase
class AuthServiceImpl extends AuthService<AuthResponse> {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
