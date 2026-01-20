// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/band_calculator/presentation/cubit/calculator_cubit.dart'
    as _i883;
import 'features/home/presentation/cubit/home_cubit.dart' as _i403;
import 'features/profile/data/repositories/profile_repository_impl.dart'
    as _i277;
import 'features/profile/domain/repositories/profile_repository.dart' as _i626;
import 'features/profile/presentation/bloc/profile_bloc.dart' as _i284;
import 'features/settings/presentation/cubit/theme_cubit.dart' as _i276;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i883.CalculatorCubit>(() => _i883.CalculatorCubit());
    gh.factory<_i403.HomeCubit>(() => _i403.HomeCubit());
    gh.factory<_i276.ThemeCubit>(() => _i276.ThemeCubit());
    gh.lazySingleton<_i626.ProfileRepository>(
      () => _i277.ProfileRepositoryImpl(),
    );
    gh.factory<_i284.ProfileBloc>(
      () => _i284.ProfileBloc(gh<_i626.ProfileRepository>()),
    );
    gh.lazySingleton<_i1015.AuthRepository>(() => _i111.AuthRepositoryImpl());
    gh.factory<_i363.AuthBloc>(
      () => _i363.AuthBloc(gh<_i1015.AuthRepository>()),
    );
    return this;
  }
}
