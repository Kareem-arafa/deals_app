import 'package:dealz/redux/auth/auth_reducer.dart';
import 'package:dealz/redux/home/home_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action.actionName == "LogOutAction" || action.actionName == "DeleteAccountAction") {
    return AppState.initial();
  } else {
    return AppState(
      authState: authReducer(state.authState, action),
      homeState: homeReducer(state.homeState, action),
    );
  }
}
