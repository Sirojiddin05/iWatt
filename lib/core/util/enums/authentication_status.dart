enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unKnown,
  ;

  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnAuthenticated => this == AuthenticationStatus.unauthenticated;
  bool get isUnKnown => this == AuthenticationStatus.unKnown;
}
