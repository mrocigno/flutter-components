class ItemResponse {

  final int id;
  final String mainImageUrl;
  final String name;
  final double value;
  bool favorite;

  ItemResponse({
    this.id,
    this.mainImageUrl = "",
    this.value = 0.0,
    this.name = "",
    this.favorite = false
  });

}