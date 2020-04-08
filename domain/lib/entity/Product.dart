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

  
}