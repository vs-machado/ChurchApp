import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:church_app/core/di/providers.dart';
import 'package:church_app/core/auth/domain/validators.dart';
import 'package:church_app/core/auth/presentation/viewmodels/register/register_state.dart';
import 'package:church_app/core/auth/util/auth_error.dart';
import 'package:church_app/core/domain/util/network_error.dart';
import 'package:church_app/generated/l10n.dart' show S;

/// Tela de cadastro do app.
/// Exibe três text inputs: email, senha e confirmar senha.
/// Caso o usuário se cadastre com sucesso: redireciona para a HomePage.
/// Caso o cadastro falhe: exibe mensagem de erro através de um Text ou Snackbar
/// Texts são utilizados para exibir erros de validação ou autenticação.
/// Ver: [AuthError] e [EmailValidators].
/// Snackbars exibem erros de internet.
/// Ver: [NetworkErrors]
class SlidingRegisterCard extends ConsumerStatefulWidget {
  final Function onClose;

  const SlidingRegisterCard({super.key, required this.onClose});

  @override
  ConsumerState<SlidingRegisterCard> createState() =>
      _SlidingRegisterCardState();
}

class _SlidingRegisterCardState extends ConsumerState<SlidingRegisterCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;
  bool _confirmPasswordHasFocus = false;

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
    _confirmPasswordFocusNode.addListener(_onConfirmPasswordFocusChange);
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
    _emailFocusNode.removeListener(_onEmailFocusChange);
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _confirmPasswordFocusNode.removeListener(_onConfirmPasswordFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _closeCard() async {
    await _animationController.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(registerViewModelProvider.notifier);
    final state = ref.watch(registerViewModelProvider);

    ref.listen(registerViewModelProvider, (previous, current) {
      if (current is RegisterError) {
        final error = current.error;
        String? errorMessage;

        switch (error) {
          case AuthError():
            setState(() {
              _currentValidationError = error;
            });
          case NetworkError():
            errorMessage = error.toErrorString(context);
          case Error():
            errorMessage = S.of(context).somethingWentWrong;
        }

        if (errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      } else if (current is RegisterSuccess) {
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
                            // Offset for the icon button width
                            child: Text(
                              S.of(context).createYourAccount,
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
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          decoration: InputDecoration(
                            labelText: S.of(context).confirmPassword,
                            prefixIcon: Icon(
                              _confirmPasswordHasFocus
                                  ? Icons.lock
                                  : Icons.lock_outline,
                            ),
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
                              state is RegisterLoading
                                  ? null
                                  : () {
                                    final email = _emailController.text;
                                    final password = _passwordController.text;
                                    final confirmPassword =
                                        _confirmPasswordController.text;

                                    AuthError? errorToShow;

                                    if (!email.isValidEmail()) {
                                      errorToShow = AuthError.invalidEmail;
                                    } else if (password != confirmPassword) {
                                      errorToShow =
                                          AuthError.passwordsAreNotTheSame;
                                    } else if (!password.isValidPassword()) {
                                      errorToShow =
                                          AuthError
                                              .passwordRequiresLettersAndNumbers;
                                    }

                                    setState(() {
                                      _currentValidationError = errorToShow;
                                    });

                                    if (errorToShow == null) {
                                      viewModel.signUp(
                                        email,
                                        password,
                                        confirmPassword,
                                      );
                                    }
                                  },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child:
                              state is RegisterLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    S.of(context).register,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
