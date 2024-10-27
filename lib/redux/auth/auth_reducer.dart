import 'package:dealz/redux/auth/auth_actions.dart';
import 'package:dealz/redux/auth/auth_state.dart';
import 'package:redux/redux.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthStatusAction>(_syncAuthState),
  TypedReducer<AuthState, SyncUserAction>(_syncUser),
  TypedReducer<AuthState, SyncUserIdAction>(_syncUserId),
  TypedReducer<AuthState, SyncSocialMediaAction>(_syncSocialMedia),
  TypedReducer<AuthState, SyncTokenAction>(_syncToken),
]);

AuthState _syncAuthState(AuthState state, AuthStatusAction action) {
  var status = state.status;
  status.update(action.report.actionName ?? '', (v) => action.report, ifAbsent: () => action.report);

  return state.copyWith(status: status);
}

AuthState _syncUser(AuthState state, SyncUserAction action) {
  return state.copyWith(user: action.user);
}

AuthState _syncUserId(AuthState state, SyncUserIdAction action) {
  return state.copyWith(userId: action.userId);
}

AuthState _syncToken(AuthState state, SyncTokenAction action) {
  return state.copyWith(token: action.token);
}

AuthState _syncSocialMedia(AuthState state, SyncSocialMediaAction action) {
  for (var social in action.socialMedia) {
    state.socialMedia.update(social.id.toString(), (value) => social, ifAbsent: () => social);
  }
  return state.copyWith(socialMedia: state.socialMedia);
}
