import 'dart:convert';

class ProfileSS {
    ProfileSS({
        this.id,

        this.name,
        this.imageUrl,
       
    });

    String id;

    String name;
    String imageUrl;
   

    factory ProfileSS.fromRawJson(String str) => ProfileSS.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileSS.fromJson(Map<String, dynamic> json) => ProfileSS(
        id: json["id"],
     
        name: json["name"],
      
        imageUrl: json["imageURL"],
    
    );

    Map<String, dynamic> toJson() => {
        "id": id,
      
        "name": name,
        "imageURL": imageUrl,
      
    };
}
