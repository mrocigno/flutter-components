class Product {

  int localId;
  int remoteId;
  String mainImageUrl;
  String provider;
  String name;
  String description;
  double value;
  bool favorite;

  Product({
    this.localId,
    this.remoteId,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.provider = "",
    this.name = "",
    this.description = "",
    this.favorite = false
  });

  @override
  String toString() {
    return [
      localId,
      remoteId,
      mainImageUrl,
      value,
      provider,
      name,
      description,
      favorite
    ].toString();
  }
  
}