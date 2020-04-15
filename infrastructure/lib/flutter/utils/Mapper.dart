abstract class Mapper<Entity> {

  Entity fromResponse(Map<String, Object> input);

  Map<String, Object> toDataMap(Entity input);

  Entity fromDataMap(Map<String, Object> input);

}