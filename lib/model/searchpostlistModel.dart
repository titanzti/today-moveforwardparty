// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PostSearchModel welcomeFromJson(String str) => PostSearchModel.fromJson(json.decode(str));

String welcomeToJson(PostSearchModel data) => json.encode(data.toJson());

class PostSearchModel {
    PostSearchModel({
        this.post,
        this.user,
        this.page,
    });

    Post post;
    User user;
    Page page;

    factory PostSearchModel.fromJson(Map<String, dynamic> json) => PostSearchModel(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]),
    );

    Map<String, dynamic> toJson() => {
        "post": post == null ? null : post.toJson(),
        "user": user == null ? null : user.toJson(),
        "page": page == null ? null : page.toJson(),
    };
}

class Page {
    Page({
        this.id,
        this.createdDate,
        this.updateDate,
        this.name,
        this.pageUsername,
        this.imageUrl,
        this.coverUrl,
        this.coverPosition,
        this.ownerUser,
        this.isOfficial,
        this.category,
        this.banned,
        this.email,
    });

    String id;
    DateTime createdDate;
    DateTime updateDate;
    String name;
    String pageUsername;
    String imageUrl;
    String coverUrl;
    int coverPosition;
    String ownerUser;
    bool isOfficial;
    String category;
    bool banned;
    String email;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"] == null ? null : json["id"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        name: json["name"] ,
        pageUsername: json["pageUsername"] == null ? null : json["pageUsername"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        coverUrl: json["coverURL"] == null ? null : json["coverURL"],
        coverPosition: json["coverPosition"] == null ? null : json["coverPosition"],
        ownerUser: json["ownerUser"] == null ? null : json["ownerUser"],
        isOfficial: json["isOfficial"] == null ? null : json["isOfficial"],
        category: json["category"] == null ? null : json["category"],
        banned: json["banned"] == null ? null : json["banned"],
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdDate": createdDate == null ? null : createdDate.toIso8601String(),
        "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
        "name": name ,
        "pageUsername": pageUsername == null ? null : pageUsername,
        "imageURL": imageUrl == null ? null : imageUrl,
        "coverURL": coverUrl == null ? null : coverUrl,
        "coverPosition": coverPosition == null ? null : coverPosition,
        "ownerUser": ownerUser == null ? null : ownerUser,
        "isOfficial": isOfficial == null ? null : isOfficial,
        "category": category == null ? null : category,
        "banned": banned == null ? null : banned,
        "email": email == null ? null : email,
    };
}

class Post {
    Post({
        this.id,
        this.title,
        this.detail,
        this.isDraft,
        this.hidden,
        this.type,
        this.userTags,
        this.coverImage,
        this.pinned,
        this.deleted,
        this.ownerUser,
        this.commentCount,
        this.repostCount,
        this.shareCount,
        this.likeCount,
        this.viewCount,
        this.createdDate,
        this.startDateTime,
        // this.story,
        this.emergencyEvent,
        this.emergencyEventTag,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.gallery,
        this.needs,
        this.fulfillment,
        this.hashTags,
    });

    String id;
    String title;
    String detail;
    bool isDraft;
    bool hidden;
    String type;
    List<dynamic> userTags;
    String coverImage;
    bool pinned;
    bool deleted;
    String ownerUser;
    int commentCount;
    int repostCount;
    int shareCount;
    int likeCount;
    int viewCount;
    DateTime createdDate;
    DateTime startDateTime;
    // dynamic story;
    EmergencyEvent emergencyEvent;
    String emergencyEventTag;
    String pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    List<dynamic> gallery;
    List<dynamic> needs;
    List<dynamic> fulfillment;
    List<dynamic> hashTags;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        detail: json["detail"] == null ? null : json["detail"],
        isDraft: json["isDraft"] == null ? null : json["isDraft"],
        hidden: json["hidden"] == null ? null : json["hidden"],
        type: json["type"] == null ? null : json["type"],
        userTags: json["userTags"] == null ? null : List<dynamic>.from(json["userTags"].map((x) => x)),
        coverImage: json["coverImage"] == null ? null : json["coverImage"],
        pinned: json["pinned"] == null ? null : json["pinned"],
        deleted: json["deleted"] == null ? null : json["deleted"],
        ownerUser: json["ownerUser"] == null ? null : json["ownerUser"],
        commentCount: json["commentCount"] == null ? null : json["commentCount"],
        repostCount: json["repostCount"] == null ? null : json["repostCount"],
        shareCount: json["shareCount"] == null ? null : json["shareCount"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        viewCount: json["viewCount"] == null ? null : json["viewCount"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        startDateTime: json["startDateTime"] == null ? null : DateTime.parse(json["startDateTime"]),
        // story: json["story"],
        emergencyEvent: json["emergencyEvent"] == null ? null : EmergencyEvent.fromJson(json["emergencyEvent"]),
        emergencyEventTag: json["emergencyEventTag"] == null ? null : json["emergencyEventTag"],
        pageId: json["pageId"] == null ? null : json["pageId"],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        gallery: json["gallery"] == null ? null : List<dynamic>.from(json["gallery"].map((x) => x)),
        needs: json["needs"] == null ? null : List<dynamic>.from(json["needs"].map((x) => x)),
        fulfillment: json["fulfillment"] == null ? null : List<dynamic>.from(json["fulfillment"].map((x) => x)),
        hashTags: json["hashTags"] == null ? null : List<dynamic>.from(json["hashTags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "detail": detail == null ? null : detail,
        "isDraft": isDraft == null ? null : isDraft,
        "hidden": hidden == null ? null : hidden,
        "type": type == null ? null : type,
        "userTags": userTags == null ? null : List<dynamic>.from(userTags.map((x) => x)),
        "coverImage": coverImage == null ? null : coverImage,
        "pinned": pinned == null ? null : pinned,
        "deleted": deleted == null ? null : deleted,
        "ownerUser": ownerUser == null ? null : ownerUser,
        "commentCount": commentCount == null ? null : commentCount,
        "repostCount": repostCount == null ? null : repostCount,
        "shareCount": shareCount == null ? null : shareCount,
        "likeCount": likeCount == null ? null : likeCount,
        "viewCount": viewCount == null ? null : viewCount,
        "createdDate": createdDate == null ? null : createdDate.toIso8601String(),
        "startDateTime": startDateTime == null ? null : startDateTime.toIso8601String(),
        // "story": story,
        "emergencyEvent": emergencyEvent == null ? null : emergencyEvent.toJson(),
        "emergencyEventTag": emergencyEventTag == null ? null : emergencyEventTag,
        "pageId": pageId == null ? null : pageId,
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
        "gallery": gallery == null ? null : List<dynamic>.from(gallery.map((x) => x)),
        "needs": needs == null ? null : List<dynamic>.from(needs.map((x) => x)),
        "fulfillment": fulfillment == null ? null : List<dynamic>.from(fulfillment.map((x) => x)),
        "hashTags": hashTags == null ? null : List<dynamic>.from(hashTags.map((x) => x)),
    };
}

class EmergencyEvent {
    EmergencyEvent({
        this.hashTag,
    });

    String hashTag;

    factory EmergencyEvent.fromJson(Map<String, dynamic> json) => EmergencyEvent(
        hashTag: json["hashTag"] == null ? null : json["hashTag"],
    );

    Map<String, dynamic> toJson() => {
        "hashTag": hashTag == null ? null : hashTag,
    };
}

class User {
    User({
        this.displayName,
        this.imageUrl,
        this.email,
        this.isAdmin,
        this.uniqueId,
    });

    String displayName;
    String imageUrl;
    String email;
    bool isAdmin;
    String uniqueId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        displayName: json["displayName"] == null ? null : json["displayName"],
        imageUrl: json["imageURL"] == null ? null : json["imageURL"],
        email: json["email"] == null ? null : json["email"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        uniqueId: json["uniqueId"] == null ? null : json["uniqueId"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName == null ? null : displayName,
        "imageURL": imageUrl == null ? null : imageUrl,
        "email": email == null ? null : email,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "uniqueId": uniqueId == null ? null : uniqueId,
    };
}
