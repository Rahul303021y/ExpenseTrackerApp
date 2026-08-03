abstract class LoginEvent {}

class LoginButtonPressedEvent extends LoginEvent {
  String email;
  String password;
  String deviceId;
  String deviceName;

  LoginButtonPressedEvent(
      {required this.email,
      required this.password,
      required this.deviceId,
      required this.deviceName});
}
