class HomeWishlist {
  HomeWishlist({
    this.status,
    this.length,
  });

  bool? status;
  int? length;

  factory HomeWishlist.fromJson(Map<String, dynamic> json) => HomeWishlist(
        status: json["status"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "length": length,
      };
}
