class NumberRespones {
    NumberRespones({
        this.status,
        this.id,
        this.error,
        this.message,
    });

    String? message;
    bool? error;
    bool? status;
    String? id;

    factory NumberRespones.fromJson(Map<String, dynamic> json) => NumberRespones(
        status: json["status"],
        id: json["_id"],
        error: json["error"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
    };
}

//================================= Number Login Respones ===================================


class NumberLoginRespones {
    NumberLoginRespones({
        this.status,
        this.jwt,
        this.error,
        this.message,
    });

    String? message;
    bool? error;
    bool? status;
    String? jwt;

    factory NumberLoginRespones.fromJson(Map<String, dynamic> json) => NumberLoginRespones(
        status: json["status"],
        jwt: json["jwt"],
        error: json["error"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "jwt": jwt,
    };
}

//================================= Number Verify ===================================

class NumberVerify {
    NumberVerify({
        this.userOtp,
        this.userNumber,
        this.id,
    });

    String? userOtp;
    int? userNumber;
    String? id;

    factory NumberVerify.fromJson(Map<String, dynamic> json) => NumberVerify(
        userOtp: json["user_otp"],
        userNumber: json["user_number"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_otp": userOtp,
        "user_number": userNumber,
        "_id": id,
    };
}
