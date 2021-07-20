import 'dart:convert';

class ProfileSS {
    ProfileSS({
        this.id,
        this.createdDate,
        this.updateDate,
        this.updateByUsername,
        this.name,
        this.pageUsername,
        this.imageUrl,
        this.coverUrl,
        this.coverPosition,
        this.ownerUser,
        this.isOfficial,
        this.category,
        this.banned,
        this.lineId,
        this.facebookUrl,
        this.twitterUrl,
        this.websiteUrl,
        this.mobileNo,
        this.address,
        this.email,
        this.backgroundStory,
    });

    String id;
    DateTime createdDate;
    DateTime updateDate;
    String updateByUsername;
    String name;
    String pageUsername;
    String imageUrl;
    String coverUrl;
    int coverPosition;
    String ownerUser;
    bool isOfficial;
    String category;
    bool banned;
    String lineId;
    String facebookUrl;
    String twitterUrl;
    String websiteUrl;
    String mobileNo;
    String address;
    String email;
    String backgroundStory;

    factory ProfileSS.fromRawJson(String str) => ProfileSS.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileSS.fromJson(Map<String, dynamic> json) => ProfileSS(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        updateByUsername: json["updateByUsername"],
        name: json["name"],
        pageUsername: json["pageUsername"],
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"],
        coverPosition: json["coverPosition"],
        ownerUser: json["ownerUser"],
        isOfficial: json["isOfficial"],
        category: json["category"],
        banned: json["banned"],
        lineId: json["lineId"] == null ? null : json["lineId"],
        facebookUrl: json["facebookURL"] == null ? null : json["facebookURL"],
        twitterUrl: json["twitterURL"] == null ? null : json["twitterURL"],
        websiteUrl: json["websiteURL"] == null ? null : json["websiteURL"],
        mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
        backgroundStory: json["backgroundStory"] == null ? null : json["backgroundStory"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "updateByUsername": updateByUsername,
        "name": name,
        "pageUsername": pageUsername,
        "imageURL": imageUrl,
        "coverURL": coverUrl,
        "coverPosition": coverPosition,
        "ownerUser": ownerUser,
        "isOfficial": isOfficial,
        "category": category,
        "banned": banned,
        "lineId": lineId == null ? null : lineId,
        "facebookURL": facebookUrl == null ? null : facebookUrl,
        "twitterURL": twitterUrl == null ? null : twitterUrl,
        "websiteURL": websiteUrl == null ? null : websiteUrl,
        "mobileNo": mobileNo == null ? null : mobileNo,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
        "backgroundStory": backgroundStory == null ? null : backgroundStory,
    };
}
