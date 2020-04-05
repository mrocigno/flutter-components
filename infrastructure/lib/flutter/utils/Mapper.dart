abstract class Mapper<ResponseObject, Entity> {

  Entity transform(ResponseObject input);

  ResponseObject reverse(Entity input);

  Map<String, Object> toMap(Entity input);

  Entity fromMap(Map<String, Object> input);

}