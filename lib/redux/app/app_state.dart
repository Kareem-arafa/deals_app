import 'package:dealz/redux/auth/auth_state.dart';
import 'package:dealz/redux/home/home_state.dart';

class AppState {
  final AuthState authState;
  final HomeState homeState;

  AppState({
    required this.authState,
    required this.homeState,
  });

  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      homeState: HomeState.initial(),
    );
  }
}
