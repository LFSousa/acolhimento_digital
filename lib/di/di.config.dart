// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/presentation/controllers/map_controller.dart' as _i5;
import '../app/repositories/places/places_repository.dart' as _i4;
import '../app/repositories/places/places_repository_interface.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.IPlacesRepository>(() => _i4.PlacesRepository());
  gh.factory<_i5.MapController>(
      () => _i5.MapController(get<_i3.IPlacesRepository>()));
  return get;
}
