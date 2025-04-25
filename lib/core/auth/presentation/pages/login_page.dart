import 'package:church_app/core/auth/presentation/pages/register_page.dart';
import 'package:church_app/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    ref.listen(loginViewModelProvider, (previous, current) {
      if (current is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(current.message))
        );
      }
    });

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),

          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Senha'),
            obscureText: true,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: state is LoginLoading
                ? null
                : () =>
                viewModel.login(
                  _emailController.text,
                  _passwordController.text,
                ),
            child: state is LoginLoading
                ? const CircularProgressIndicator()
                : const Text('Login'),
          ),

          const SizedBox(height: 12),

          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                ),
            child: const Center(
              child: Text(
                'Não possui uma conta? Cadastre-se',
                style: TextStyle(fontSize: 12, color: Colors.blueAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
