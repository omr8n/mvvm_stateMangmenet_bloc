import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemangments_cubit/Features/home/data/repos/movie_repo_impl.dart';
import 'package:mvvm_statemangments_cubit/Features/home/domain/repos/movies_repo.dart';
import 'package:mvvm_statemangments_cubit/Features/home/presentation/manger/favorites/favorites_bloc.dart';
import 'package:mvvm_statemangments_cubit/Features/splash/views/splash_view.dart';
import 'package:mvvm_statemangments_cubit/core/utils/service/helper/shared_preferences_singleton.dart';

import 'Features/home/presentation/manger/movies/movies_bloc.dart';
import 'Features/home/presentation/views/movies_view.dart';

import 'core/constants/my_theme_data.dart';
import 'core/theme/theme_bloc.dart';
import 'core/utils/service/init_getit.dart';
import 'core/utils/service/navigation_service.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) async {
    await dotenv.load(fileName: "assets/.env");
    await Prefs.init();
    runApp(const MoviesApp());
  });
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => getIt<ThemeBloc>()..add(LoadThemeEvent()), //..loadTheme(),
        ),
        BlocProvider(create: (_) => getIt<MoviesBloc>()),
        BlocProvider(
          create: (_) => getIt<FavoritesBloc>(),
          //.  ..add(LoadFavorites()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: getIt<NavigationService>().navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme:
                state is LightThemeState
                    ? MyThemeData.lightTheme
                    : MyThemeData.darkTheme,
            home: const SplashView(),
            // const SplashScreen(), //const MovieDetailsScreen(), //const FavoritesScreen(), //const MoviesScreen(),
          );
        },
      ),
    );
  }
}
