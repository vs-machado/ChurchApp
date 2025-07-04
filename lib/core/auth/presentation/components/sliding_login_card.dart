import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:church_app/core/di/providers.dart';
import 'package:church_app/core/auth/domain/validators.dart';
import 'package:church_app/core/auth/presentation/viewmodels/login/login_state.dart';
import 'package:church_app/core/auth/util/auth_error.dart';
import 'package:church_app/core/domain/util/network_error.dart';
import 'package:church_app/generated/l10n.dart' show S;

/// Tela de login do app.
/// Exibe dois text inputs: email e senha.
/// Caso o usuário faça login com sucesso: redireciona para a HomePage.
/// Caso o login falhe: exibe mensagem de erro através de um Text ou Snackbar.
/// Texts são utilizados para exibir erros de validação ou autenticação.
/// Ver: [AuthError] e [EmailValidators].
/// Snackbars exibem erros de internet.
/// Ver: [NetworkError].
class SlidingLoginCard extends ConsumerStatefulWidget {
  final Function onClose;

  const SlidingLoginCard({super.key, required this.onClose});

  @override
  ConsumerState<SlidingLoginCard> createState() => _SlidingLoginCardState();
}

class _SlidingLoginCardState extends ConsumerState<SlidingLoginCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _passwordVisible = false;

  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;

  // Utilizado para exibir mensagem de erro de autenticação ou validação de emails e senhas
  AuthError? _currentValidationError;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  // Utilizado para alternar ícone entre outlined e filled
  void _onEmailFocusChange() {
    setState(() {
      _emailHasFocus = _emailFocusNode.hasFocus;
    });
  }

  // Alterna ícone entre outlined e filled, e
  // exibe ícone que torna a senha vísivel ou invisível quando clicado
  void _onPasswordFocusChange() {
    setState(() {
      _passwordHasFocus = _passwordFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.removeListener(_onEmailFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _closeCard() async {
    await _animationController.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);

    ref.listen(loginViewModelProvider, (previous, current) {
      if (current is LoginError) {
        final error = current.error;
        String? errorMessage;

        switch (error) {
          case AuthError():
            setState(() {
              _currentValidationError = error;
            });
            break;
          case NetworkError():
            errorMessage = error.toErrorString(context);
            break;
          case Error():
            errorMessage = S.of(context).somethingWentWrong;
            break;
        }

        if (errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      } else if (current is LoginSuccess) {
        _closeCard();
      }
    });

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            MediaQuery.of(context).size.height * _animation.value,
          ),
          child: PopScope<Object?>(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                _closeCard();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20.0,
                        ),
                        onPressed: _closeCard,
                        padding: const EdgeInsets.all(0.0),
                      ),
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: 42.0),
                            child: Text(
                              S.of(context).login,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                            prefixIcon: Icon(
                              _emailHasFocus
                                  ? Icons.email
                                  : Icons.email_outlined,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocusNode,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                            prefixIcon: Icon(
                              _passwordHasFocus
                                  ? Icons.lock
                                  : Icons.lock_outline,
                            ),
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
                        const SizedBox(height: 24.0),
                        Builder(
                          builder: (context) {
                            if (_currentValidationError != null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _currentValidationError!.toErrorString(
                                      context,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        ElevatedButton(
                          onPressed:
                              state is LoginLoading
                                  ? null
                                  : () {
                                    final email = _emailController.text;
                                    final password = _passwordController.text;

                                    setState(() {
                                      _currentValidationError = null;
                                    });

                                    if (!email.isValidEmail()) {
                                      setState(() {
                                        _currentValidationError =
                                            AuthError.invalidEmail;
                                      });
                                      return;
                                    }
                                    if (password.isEmpty) {
                                      setState(() {
                                        _currentValidationError =
                                            AuthError.emptyPassword;
                                      });
                                      return;
                                    }

                                    viewModel.login(email, password);
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            // Or your app's theme color
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),

                          child:
                              state is LoginLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    S.of(context).login, // Changed text
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                        // Adicionar botão "esqueceu sua senha?" futuramente
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
