import 'package:i_watt_app/core/error/failure_handler.dart';
import 'package:i_watt_app/core/util/either.dart';
import 'package:i_watt_app/features/common/domain/entities/about_us_entity.dart';

abstract class AboutUsRepository {
  Future<Either<Failure, AboutUsEntity>> getAbout();
}
