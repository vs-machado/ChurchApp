import 'package:church_app/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(registerViewModelProvider.notifier);

    // Quando o usuário se cadastra com sucesso a tela é fechada
    ref.listen(registerViewModelProvider, (previous, current) {
      if(current.isError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(current.errorMessage.toString()))
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
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

          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(labelText: 'Confirmar senha'),
            obscureText: true,
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed:
                () => viewModel.signUp(
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                ),
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}
