class NumberRespones {
  NumberRespones({
    this.status,
    this.id,
    this.message,
    this.error,
  });
  bool? error;
  bool? status;
  String? id;
  String? message;

  factory NumberRespones.fromJson(Map<String, dynamic> json) => NumberRespones(
        status: json["status"],
        id: json["_id"],
        message: json["message"],
        error: json["error"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "message": message,
      };
}

//================================= Number Login Respones ===================================

class NumberOtpRespones {
  NumberOtpRespones({
    this.status,
    this.token,
    this.message,
    this.error,
    this.refreshToken,
  });
  bool? error;
  bool? status;
  String? token;
  String? message;
  String? refreshToken;

  factory NumberOtpRespones.fromJson(Map<String, dynamic> json) =>
      NumberOtpRespones(
        status: json["status"],
        token: json["token"],
        message: json["message"],
        error: json["error"] ?? true,
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jwt": token,
        "message": message,
      };
}

//================================= Number Verify ===================================

class NumberVerify {
  NumberVerify({
    this.userOtp,
    this.userNumber,
    this.id,
    this.error,
    this.message,
  });

  String? message;
  bool? error;
  String? userOtp;
  int? userNumber;
  String? id;

  factory NumberVerify.fromJson(Map<String, dynamic> json) => NumberVerify(
      userOtp: json["user_otp"],
      userNumber: json["user_number"],
      id: json["_id"],
      message: json["message"]);

  Map<String, dynamic> toJson() => {
        "user_otp": userOtp,
        "user_number": userNumber,
        "_id": id,
      };
}
