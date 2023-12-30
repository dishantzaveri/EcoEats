import 'package:envied/envied.dart';

part 'env.g.dart';

//! Generate .env file from .env.example file in the root directory
@Envied(path: 'lib/utils/env/.env') //Path of your .env file
final class Env {
  @EnviedField(varName: 'HERE_SDK_ID')
  static const String hereSdkID = _Env.hereSdkID;

  @EnviedField(varName: 'HERE_SDK_SECRET')
  static const String hereSdkSecret = _Env.hereSdkSecret;
}
