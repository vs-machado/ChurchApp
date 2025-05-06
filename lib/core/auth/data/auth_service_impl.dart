import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Serviço de autenticação do Supabase
class AuthServiceImpl implements AuthService<AuthResponse> {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get GoogleSignIn instance
  GoogleSignIn _getGoogleSignIn() {
    return GoogleSignIn(
      clientId: dotenv.env['IOS_CLIENT_ID'],
      serverClientId: dotenv.env['WEB_CLIENT_ID'],
      scopes: ['email', 'profile'],
    );
  }

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
  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = _getGoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
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
    final session = _supabase.auth.currentSession;
    final provider = session?.user.appMetadata['provider'] as String?;

    await _supabase.auth.signOut();

    // Também desloga da conta Google caso o auth provider seja a Google
    if (provider == 'google') {
      try {
        final googleSignIn = _getGoogleSignIn();
        await googleSignIn.signOut();
      } catch (e) {}
    }
  }

  @override
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  @override
  String? get userId {
    return _supabase.auth.currentUser?.id;
  }

  @override
  Future<void> updateUserProfile({required Map<String, dynamic> data}) async {
    final id = userId;
    if (id != null) {
      await _supabase.from('users').update(data).eq('id', id);
    }
  }

  @override
  Map<String, dynamic>? getCurrentUserMetadata() {
    return _supabase.auth.currentUser?.userMetadata;
  }
}
