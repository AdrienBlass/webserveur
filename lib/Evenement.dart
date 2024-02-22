class Evenement {
  String auteur;
  String type;
  String description;
  double localisationX;
  double localisationY;
  String dateCreation;
  String ville;
  bool isFavorite;
  int FavouriteCount;


  Evenement(this.auteur,this.type,this.description,this.ville,
      this.localisationX,this.localisationY, this.dateCreation, this.isFavorite,
      this.FavouriteCount);


  factory Evenement.fromJson(Map<String, dynamic> json)
  {
    return Evenement(json["auteur"],
        json["type"],
        json["description"],
        json["ville"],
        json["localisationX"],
        json["localisationY"],
        json["dateCreation"],
        json["isFavorite"],
        json["FavouriteCount"]);
  }



}

