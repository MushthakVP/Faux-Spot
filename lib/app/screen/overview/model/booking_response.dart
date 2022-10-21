
class BookingResponse {
    BookingResponse({
        this.status,
        this.data,
        this.message,
    });

    String? message;
    bool? status;
    List<BookingList>? data;

    factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
        status: json["status"],
        data: List<BookingList>.from(json["data"].map((x) => BookingList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BookingList {
    BookingList({
        this.id,
        this.bookingDate,
        this.bookingStatus,
        this.userId,
        this.turfId,
        this.turfIndex,
        this.bookingPrice,
    });

    String? id;
    String? bookingDate;
    bool? bookingStatus;
    String? userId;
    String? turfId;
    List<int>? turfIndex;
    int? bookingPrice;

    factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
        id: json["_id"],
        bookingDate: json["booking_date"],
        bookingStatus: json["booking_status"],
        userId: json["user_id"],
        turfId: json["turf_id"],
        turfIndex: List<int>.from(json["turf_index"].map((x) => x)),
        bookingPrice: json["booking_price"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "booking_date": bookingDate,
        "booking_status": bookingStatus,
        "user_id": userId,
        "turf_id": turfId,
        "turf_index": List<dynamic>.from(turfIndex!.map((x) => x)),
        "booking_price": bookingPrice,
    };
}
