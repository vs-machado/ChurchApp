import 'package:church_app/core/auth/presentation/pages/login_page.dart';
import 'package:church_app/feature/posts/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// GATE de autenticação. Caso o usuário não esteja autenticado, ele será redirecionado para a tela de login.	
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        } 
      },
    );
  }
}