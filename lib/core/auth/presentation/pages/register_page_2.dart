import 'package:church_app/core/auth/presentation/components/sliding_login_card.dart';
import 'package:church_app/core/di/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../domain/util/network_error.dart';
import '../../util/auth_error.dart';
import '../components/sliding_register_card.dart';
import 'package:church_app/generated/l10n.dart' show S;

import '../viewmodels/google_sign_in/google_sign_in_state.dart';

/// Permite que o usuário faça login ou se cadastre no app.
///
/// Clicar no botão de cadastro com email e senha exibe [SlidingRegisterCard].
/// Clicar no inkwell Entrar exibe [SlidingLoginCard].
/// Opções implementadas: Google Auth, cadastro com email e senha e login com email e senha.
class RegisterPage2 extends ConsumerStatefulWidget {
  const RegisterPage2({super.key});

  @override
  ConsumerState<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends ConsumerState<RegisterPage2> {
  bool _showRegisterCard = false;
  bool _showLoginCard = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(googleSignInViewModelProvider.notifier);
    final state = ref.watch(googleSignInViewModelProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    ref.listen(googleSignInViewModelProvider, (previous, current) {
      if (current is SignInError) {
        final error = current.error;
        String? errorMessage;

        switch (error) {
          case AuthError():
            {}
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
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.of(context).welcomeTo,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      ElevatedButton(
                        onPressed:
                            state is SignInLoading
                                ? null
                                : () {
                                  viewModel.signInWithGoogle();
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'lib/core/assets/icons/google_logo.svg',
                                height: 20,
                                width: 20,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    S.of(context).signInGoogleAccount,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8.0),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              S.of(context).or,
                              style: TextStyle(
                                color: Colors.grey.shade900,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.0,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8.0),

                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showRegisterCard = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                size: 20,
                                color: Colors.black87,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    S.of(context).registerEmailPassword,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).haveAnAccount,
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _showLoginCard = true;
                              });
                            },
                            child: Text(
                              S.of(context).enter,
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_showRegisterCard)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlidingRegisterCard(
                  onClose: () {
                    setState(() {
                      _showRegisterCard = false;
                    });
                  },
                ),
              ),
            if (_showLoginCard)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlidingLoginCard(
                  onClose: () {
                    setState(() {
                      _showLoginCard = false;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
