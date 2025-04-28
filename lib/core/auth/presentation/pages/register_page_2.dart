import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../components/sliding_register_card.dart';
import 'package:church_app/generated/l10n.dart' show S;

class RegisterPage2 extends ConsumerStatefulWidget {
  const RegisterPage2({super.key});

  @override
  ConsumerState<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends ConsumerState<RegisterPage2> {
  bool _showRegisterCard = false;

  @override
  Widget build(BuildContext context) {
    // Set status bar to be visible on black background
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Stack(
          children: [
            // Background image or color can go here

            // Main card at the bottom
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
                      const Text(
                        'Bem vindo ao Reino Church!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Google sign-in button
                      ElevatedButton(
                        onPressed: () {
                          // Implementar google sign-in/sign-up
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
                                    'Entrar com conta Google',
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

                      // Divider with "or" text
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
                              'ou',
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

                      // Email registration button
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
                                    'Registrar com email e senha',
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

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Possui uma conta? ',
                            style: const TextStyle(
                              fontSize: 13.0,
                              color: Colors.black54,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigate to login page
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/login');
                            },
                            child: Text(
                              'Entrar',
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

            // Sliding registration card
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
          ],
        ),
      ),
    );
  }
}
