//================================= EMAIL VERIFY ===================================

class EmailSignupRespones {
  EmailSignupRespones({
    this.status,
    this.id,
    this.message,
    this.error,
  });

  bool? error;
  bool? status;
  String? id;
  String? message;

  factory EmailSignupRespones.fromJson(Map<String, dynamic> json) =>
      EmailSignupRespones(
        status: json["status"],
        id: json["id"],
        message: json["message"],
        error: json["error"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "message": message,
      };
}

//================================= EMAIL SIGNUP ===================================

class EmailLoginRespones {
  EmailLoginRespones({
    this.status,
    this.message,
    this.token,
    this.error,
    this.refreshToken,
  });
  bool? error;
  bool? status;
  String? message;
  String? token;
  String? refreshToken;

  factory EmailLoginRespones.fromJson(Map<String, dynamic> json) =>
      EmailLoginRespones(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        error: json["error"] ?? true,
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}

class EmailVerifyRespones {
  EmailVerifyRespones({
    this.status,
    this.message,
    this.token,
    this.error,
    this.refreshToken,
  });
  bool? error;
  bool? status;
  String? message;
  String? token;
  String? refreshToken;

  factory EmailVerifyRespones.fromJson(Map<String, dynamic> json) =>
      EmailVerifyRespones(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        error: json["error"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
