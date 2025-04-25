import 'package:church_app/core/di/providers.dart';
import 'package:church_app/core/util/validators.dart';
import 'package:church_app/generated/l10n.dart' show S;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';

/// Página de registro
/// Solicita um email e senha.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _showValidationErrors = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _passwordHasFocus = false;
  bool _confirmPasswordHasFocus = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
  }

  void _onPasswordFocusChange() {
    setState(() {
      _passwordHasFocus = _passwordFocusNode.hasFocus;
    });
  }

  void _onConfirmPasswordFocusChange() {
    setState(() {
      _confirmPasswordHasFocus = _confirmPasswordFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.removeListener(_onConfirmPasswordFocusChange);
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(registerViewModelProvider.notifier);
    final state = ref.watch(registerViewModelProvider);

    ref.listen(registerViewModelProvider, (previous, current) {
      if (current is RegisterError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(current.message)));
      }
      // A classe AuthGate automaticamente redireciona o usuário para a HomePage
      else if (current is RegisterSuccess) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).registration)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: S.of(context).email),
            ),

            TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                labelText: S.of(context).password,
                suffixIcon:
                    _passwordHasFocus
                        ? IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )
                        : null,
              ),
              obscureText: !_passwordVisible,
            ),

            TextField(
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              decoration: InputDecoration(
                labelText: S.of(context).confirmPassword,
                suffixIcon:
                    _confirmPasswordHasFocus
                        ? IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        )
                        : null,
              ),
              obscureText: !_confirmPasswordVisible,
            ),

            const SizedBox(height: 12),

            if (_showValidationErrors && !_emailController.text.isValidEmail())
              Text(
                S.of(context).insertAValidEmail,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),

            if (_showValidationErrors &&
                _emailController.text.isValidEmail() &&
                !_passwordController.text.isValidPassword())
              Text(
                S.of(context).passwordRequiresLettersAndNumbers,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed:
                  state is RegisterLoading
                      ? null // Desativa o botão durante o carregamento4
                      : () {
                        // Exibe mensagem de erro caso a senha não atenda aos requisitos
                        setState(() {
                          _showValidationErrors = true;
                        });

                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final confirmPassword = _confirmPasswordController.text;

                        // Valida o tamanho mínimo da senha e os caracteres exigidos
                        if (!email.isValidEmail() ||
                            !password.isValidPassword()) {
                          return;
                        }

                        viewModel.signUp(email, password, confirmPassword);
                      },
              child:
                  state is RegisterLoading
                      ? const CircularProgressIndicator()
                      : Text(S.of(context).register),
            ),
          ],
        ),
      ),
    );
  }
}
