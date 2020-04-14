class Product {

  int localId;
  int remoteId;
  String mainImageUrl;
  String name;
  double value;
  bool favorite;

  Product({
    this.localId,
    this.remoteId,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.name = "",
    this.favorite = false
  });

  @override
  String toString() {
    // TODO: implement toString
    return [
      localId,
      remoteId,
      mainImageUrl,
      value,
      name,
      favorite
    ].toString();
  }
  
}