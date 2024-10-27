import 'package:dealz/redux/auth/auth_middelware.dart';
import 'package:dealz/redux/home/home_middelware.dart';
import 'package:redux/redux.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      ...createAuthMiddleware(),
      ...createHomeMiddleware(),
    ],
  );
}
