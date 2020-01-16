import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'haufen.dart';

part 'serializers.g.dart';

//add all of the built value types that require serialization
@SerializersFor([
  Haufen,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();