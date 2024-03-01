import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {
  @override
  String toString() => 'MainInitial';
}

class MainLoading extends MainState {
  @override
  String toString() => 'MainLoading';
}

class MainRefreshUserInfoState extends MainState {
  @override
  String toString() => 'MainRefreshUserInfoState';
}

class MainFailure extends MainState {
  final String error;

  const MainFailure(this.error);

  @override
  String toString() => 'MainFailure { error: $error }';
}

class MainNavigationState extends MainState {
  final int position;

  const MainNavigationState(this.position);

  @override
  String toString() => 'MainNavigationState';
}

class MainRefreshAuthState extends MainState {
  @override
  String toString() {
    return 'MainRefreshAuthState{}';
  }
}

class MainRefreshAccountState extends MainState {
  @override
  String toString() {
    return 'MainRefreshAccountState{}';
  }
}

class MainRefreshAllTabState extends MainState {
  @override
  String toString() {
    return 'MainRefreshAllTabState{}';
  }
}

class TermsPolicyState extends MainState {
  final String content;

  const TermsPolicyState({required this.content});

  @override
  String toString() => 'TermsPolicyState';
}

class AcceptPolicyState extends MainState {
  @override
  String toString() => 'AcceptPolicyState';
}

class CheckConnectionFailedState extends MainState {
  @override
  String toString() => 'CheckConnectionFailedState';
}

class NavigationPageState extends MainState {
  final String page;

  const NavigationPageState({required this.page});

  @override
  List<Object> get props => [page];

  String toString() => 'NavigationPageState';
}

class NavigationTabState extends MainState {
  final int positionTab;

  const NavigationTabState({required this.positionTab});

  @override
  List<Object> get props => [positionTab];

  @override
  String toString() => 'NavigationTabState';
}

class MainRefreshHomePage extends MainState {
  @override
  String toString() => 'MainRefreshHomePage';
}

class MainStartCountNotificationUnRead extends MainState {
  @override
  String toString() => 'MainStartCountNotificationUnRead';
}

class MainEndCountNotificationUnRead extends MainState {
  @override
  String toString() => 'MainEndCountNotificationUnRead';
}

class RefreshDataHomeState extends MainState {
  @override
  String toString() => 'RefreshDataHomeState';
}

class RefreshAllInappState extends MainState {
  @override
  String toString() => 'RefreshAllInappState';
}

class RefreshAllTabState extends MainState {
  @override
  String toString() => 'RefreshAllTabState';
}
