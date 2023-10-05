class UserState {
  final String? email;
  final String? name;
  final String? password;
  final String? token;

  UserState({
    this.email,
    this.name,
    this.password,
    this.token,
  });

  factory UserState.initial() {
    return UserState(
      email: null,
      name: null,
      password: null,
      token: null,
    );
  }
}
