import 'package:church_app/core/auth/domain/auth_service.dart';
import 'package:church_app/feature/posts/presentation/viewmodels/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final AuthService _authService;

  HomeViewModel({required AuthService authService})
    : _authService = authService,
      super(HomeInitial());

  void logout() {
    _authService.signOut();
  }
}
