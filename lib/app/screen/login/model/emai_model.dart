//================================= EMAIL VERIFY ===================================

class EmailSignupResponse {
  EmailSignupResponse({
    this.status,
    this.id,
    this.message,
    this.error,
  });

  bool? error;
  bool? status;
  String? id;
  String? message;

  factory EmailSignupResponse.fromJson(Map<String, dynamic> json) =>
      EmailSignupResponse(
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

class EmailLoginResponse {
  EmailLoginResponse({
    this.status,
    this.message,
    this.token,
    this.error,
    this.refreshToken,
    this.id,
  });
  bool? error;
  bool? status;
  String? message;
  String? token;
  String? refreshToken;
  String? id;

  factory EmailLoginResponse.fromJson(Map<String, dynamic> json) =>
      EmailLoginResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        error: json["error"] ?? true,
        refreshToken: json["refreshToken"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}

class EmailVerifyResponse {
  EmailVerifyResponse({
    this.status,
    this.message,
    this.token,
    this.error,
    this.refreshToken,
    this.id,
  });
  bool? error;
  bool? status;
  String? message;
  String? token;
  String? refreshToken;
  String? id;


  factory EmailVerifyResponse.fromJson(Map<String, dynamic> json) =>
      EmailVerifyResponse(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        error: json["error"] ??  true,
        refreshToken: json["refreshToken"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
