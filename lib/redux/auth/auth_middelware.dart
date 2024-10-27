import 'package:dealz/data/repository/auth_repository.dart';
import 'package:dealz/redux/action_report.dart';
import 'package:dealz/redux/app/app_state.dart';
import 'package:dealz/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createAuthMiddleware([
  AuthRepository _repository = const AuthRepository(),
]) {
  final login = _login(_repository);
  final register = _register(_repository);
  final verifyPhone = _verifyPhone(_repository);
  final sendOTp = _sendOTp(_repository);
  final getSocialMedia = _getSocialMedia(_repository);
  final logout = _logout(_repository);
  final editProfile = _editProfile(_repository);
  final deleteAccount = _deleteAccount(_repository);
  final forgetPassword = _forgetPassword(_repository);
  final checkOTP = _checkOTP(_repository);
  final resetPassword = _resetPassword(_repository);
  final resendOTP = _resendOTP(_repository);
  final getUserProfile = _getUserProfile(_repository);

  return [
    TypedMiddleware<AppState, LoginAction>(login),
    TypedMiddleware<AppState, RegisterAction>(register),
    TypedMiddleware<AppState, VerifyPhoneAction>(verifyPhone),
    TypedMiddleware<AppState, SendOTPAction>(sendOTp),
    TypedMiddleware<AppState, GetSocialMediaAction>(getSocialMedia),
    TypedMiddleware<AppState, LogOutAction>(logout),
    TypedMiddleware<AppState, EditProfileAction>(editProfile),
    TypedMiddleware<AppState, DeleteAccountAction>(deleteAccount),
    TypedMiddleware<AppState, ForgetPasswordAction>(forgetPassword),
    TypedMiddleware<AppState, ForgetPasswordCheckOTPAction>(checkOTP),
    TypedMiddleware<AppState, ResetPasswordAction>(resetPassword),
    TypedMiddleware<AppState, ResendOTPAction>(resendOTP),
    TypedMiddleware<AppState, GetUserProfileAction>(getUserProfile),
  ];
}

Middleware<AppState> _login(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.login(action.phone, action.password).then((user) {
      next(SyncUserAction(user: user));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _register(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createUserAccount(action.phone, action.userName, action.password, action.email).then((user) {
      next(SyncUserAction(user: user));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _verifyPhone(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.verifyPhone(action.code).then((user) {
      next(SyncUserAction(user: user));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _sendOTp(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.sendOTP(action.userId).then((status) {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getSocialMedia(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.getSocialMedia().then((socialMedia) {
      completed(next, action);
      next(SyncSocialMediaAction(socialMedia: socialMedia));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _logout(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.logout().then((data) {
      next(action);
      completed(next, action);
      SharedPreferences.getInstance().then((value) => value.clear());
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _editProfile(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.updateProfile(action.user).then((user) {
      next(SyncUserAction(user: user));
      completed(next, action);
    }) /*.catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    })*/
        ;
  };
}

Middleware<AppState> _deleteAccount(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.deleteUser().then((status) async {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _forgetPassword(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.forgetPassword(action.phone).then((status) async {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _checkOTP(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.forgetPasswordCheckOTP(action.phone, action.code).then((token) async {
      next(SyncTokenAction(token));
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _resetPassword(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.resetPassword(action.password, store.state.authState.token!).then((token) async {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _resendOTP(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.resendOTP(action.phone).then((token) async {
      completed(next, action);
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

Middleware<AppState> _getUserProfile(AuthRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.getMyProfile().then((user) async {
      completed(next, action);
      next(SyncUserAction(user: user));
    }).catchError((error) {
      String message = error.toString();
      catchError(next, action, error.response.data['message']);
    });
  };
}

void catchError(NextDispatcher next, action, error) {
  next(
    AuthStatusAction(
      report: ActionReport(actionName: action.actionName, status: ActionStatus.error, msg: error.toString()),
    ),
  );
}

void completed(NextDispatcher next, action) {
  next(
    AuthStatusAction(
      report: ActionReport(
          actionName: action.actionName, status: ActionStatus.complete, msg: "${action.actionName} is completed"),
    ),
  );
}

void running(NextDispatcher next, action) {
  next(
    AuthStatusAction(
      report: ActionReport(
          actionName: action.actionName, status: ActionStatus.running, msg: "${action.actionName} is running"),
    ),
  );
}

void idEmpty(NextDispatcher next, action) {
  next(
    AuthStatusAction(
      report: ActionReport(actionName: action.actionName, status: ActionStatus.error, msg: "Id is empty"),
    ),
  );
}
