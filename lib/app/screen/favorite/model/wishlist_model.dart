
class WishlistAdd {
    WishlistAdd({
        this.data,
    });

    List<Datum>? data;

    factory WishlistAdd.fromJson(Map<String, dynamic> json) => WishlistAdd(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.turfCatogery,
        this.turfType,
        this.turfInfo,
        this.turfAmenities,
        this.turfImages,
        this.turfTime,
        this.id,
        this.turfCreatorId,
        this.turfName,
        this.turfPlace,
        this.turfMuncipality,
        this.turfDistrict,
    });

    TurfCatogery? turfCatogery;
    TurfType? turfType;
    TurfInfo? turfInfo;
    TurfAmenities? turfAmenities;
    TurfImages? turfImages;
    TurfTime? turfTime;
    String? id;
    String? turfCreatorId;
    String? turfName;
    String? turfPlace;
    String? turfMuncipality;
    String? turfDistrict;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        turfCatogery: json["turf_catogery"] == null ? null : TurfCatogery.fromJson(json["turf_catogery"]),
        turfType: json["turf_type"] == null ? null : TurfType.fromJson(json["turf_type"]),
        turfInfo: json["turf_info"] == null ? null : TurfInfo.fromJson(json["turf_info"]),
        turfAmenities: json["turf_amenities"] == null ? null : TurfAmenities.fromJson(json["turf_amenities"]),
        turfImages: json["turf_images"] == null ? null : TurfImages.fromJson(json["turf_images"]),
        turfTime: json["turf_time"] == null ? null : TurfTime.fromJson(json["turf_time"]),
        id: json["_id"],
        turfCreatorId: json["turf_creator_id"],
        turfName: json["turf_name"],
        turfPlace: json["turf_place"],
        turfMuncipality: json["turf_muncipality"],
        turfDistrict: json["turf_district"],
    );

    Map<String, dynamic> toJson() => {
        "turf_catogery": turfCatogery == null ? null : turfCatogery!.toJson(),
        "turf_type": turfType == null ? null : turfType!.toJson(),
        "turf_info": turfInfo == null ? null : turfInfo!.toJson(),
        "turf_amenities": turfAmenities == null ? null : turfAmenities!.toJson(),
        "turf_images": turfImages == null ? null : turfImages!.toJson(),
        "turf_time": turfTime == null ? null : turfTime!.toJson(),
        "_id": id,
        "turf_creator_id": turfCreatorId,
        "turf_name": turfName,
        "turf_place": turfPlace,
        "turf_muncipality": turfMuncipality,
        "turf_district": turfDistrict,
    };
}

class TurfAmenities {
    TurfAmenities({
        this.turfWashroom,
        this.turfWater,
        this.turfDressing,
        this.turfParking,
        this.turfGallery,
        this.turfCafeteria,
    });

    bool? turfWashroom;
    bool? turfWater;
    bool? turfDressing;
    bool? turfParking;
    bool? turfGallery;
    bool? turfCafeteria;

    factory TurfAmenities.fromJson(Map<String, dynamic> json) => TurfAmenities(
        turfWashroom: json["turf_washroom"],
        turfWater: json["turf_water"],
        turfDressing: json["turf_dressing"],
        turfParking: json["turf_parking"],
        turfGallery: json["turf_gallery"],
        turfCafeteria: json["turf_cafeteria"],
    );

    Map<String, dynamic> toJson() => {
        "turf_washroom": turfWashroom,
        "turf_water": turfWater,
        "turf_dressing": turfDressing,
        "turf_parking": turfParking,
        "turf_gallery": turfGallery,
        "turf_cafeteria": turfCafeteria,
    };
}

class TurfCatogery {
    TurfCatogery({
        this.turfCricket,
        this.turfFootball,
        this.turfBadminton,
        this.turfYoga,
    });

    bool? turfCricket;
    bool? turfFootball;
    bool? turfBadminton;
    bool? turfYoga;

    factory TurfCatogery.fromJson(Map<String, dynamic> json) => TurfCatogery(
        turfCricket: json["turf_cricket"],
        turfFootball: json["turf_football"],
        turfBadminton: json["turf_badminton"],
        turfYoga: json["turf_yoga"],
    );

    Map<String, dynamic> toJson() => {
        "turf_cricket": turfCricket,
        "turf_football": turfFootball,
        "turf_badminton": turfBadminton,
        "turf_yoga": turfYoga,
    };
}

class TurfImages {
    TurfImages({
        this.turfImages1,
        this.turfImages2,
        this.turfImages3,
    });

    String? turfImages1;
    String? turfImages2;
    String? turfImages3;

    factory TurfImages.fromJson(Map<String, dynamic> json) => TurfImages(
        turfImages1: json["turf_images1"],
        turfImages2: json["turf_images2"],
        turfImages3: json["turf_images3"],
    );

    Map<String, dynamic> toJson() => {
        "turf_images1": turfImages1,
        "turf_images2": turfImages2,
        "turf_images3": turfImages3,
    };
}

class TurfInfo {
    TurfInfo({
        this.turfIsAvailale,
        this.turfRating,
        this.turfMap,
    });

    bool? turfIsAvailale;
    double? turfRating;
    String? turfMap;

    factory TurfInfo.fromJson(Map<String, dynamic> json) => TurfInfo(
        turfIsAvailale: json["turf_isAvailale"],
        turfRating: json["turf_rating"].toDouble(),
        turfMap: json["turf_map"],
    );

    Map<String, dynamic> toJson() => {
        "turf_isAvailale": turfIsAvailale,
        "turf_rating": turfRating,
        "turf_map": turfMap,
    };
}

class TurfTime {
    TurfTime({
        this.timeMorning,
        this.timeAfternoon,
        this.timeEvening,
    });

    String? timeMorning;
    String? timeAfternoon;
    String? timeEvening;

    factory TurfTime.fromJson(Map<String, dynamic> json) => TurfTime(
        timeMorning: json["time_morning"],
        timeAfternoon: json["time_afternoon"],
        timeEvening: json["time_evening"],
    );

    Map<String, dynamic> toJson() => {
        "time_morning": timeMorning,
        "time_afternoon": timeAfternoon,
        "time_evening": timeEvening,
    };
}

class TurfType {
    TurfType({
        this.turfSevens,
        this.turfSixes,
    });

    bool? turfSevens;
    bool? turfSixes;

    factory TurfType.fromJson(Map<String, dynamic> json) => TurfType(
        turfSevens: json["turf_sevens"],
        turfSixes: json["turf_sixes"],
    );

    Map<String, dynamic> toJson() => {
        "turf_sevens": turfSevens,
        "turf_sixes": turfSixes,
    };
}
