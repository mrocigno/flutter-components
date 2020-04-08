class ProductResponse {

  
  int id;
  String mainImageUrl;
  String name;
  double value;
  bool favorite;

  ProductResponse({
    this.id,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.name = "",
    this.favorite = false
  });

}