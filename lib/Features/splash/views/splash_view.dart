// import 'package:flutter/material.dart';
// import 'package:mvvm_statemangments/Features/home/data/repos/movie_repo_impl.dart';
// import 'package:mvvm_statemangments/Features/home/domain/repos/movies_repo.dart';
// import 'package:mvvm_statemangments/Features/home/presentation/views/movies_view.dart';

// import '../../../core/utils/service/init_getit.dart';
// import '../../../core/utils/service/navigation_service.dart';
// import '../../../core/widgets/my_error_widget.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   bool _isLoading = false;
//   String _errorMessage = '';
//   final _moviesRepository = getIt<MovieRepo>();

//   Future<void> _loadData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = "";
//     });
//     try {
//       Future.delayed(const Duration(seconds: 3), () async {
//         await getIt<NavigationService>().navigateReplace(const MoviesView());
//         await _moviesRepository.fetchGenres();
//       });

//       //
//       // await getIt<NavigationService>().navigateReplace(const MoviesView());
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     _loadData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: _isLoading
//       //     ?
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("Loading..."),
//             SizedBox(height: 20),
//             // CircularProgressIndicator.adaptive(),
//           ],
//         ),
//       ),
//       // : MyErrorWidget(errorText: _errorMessage, retryFunction: _loadData),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'widgets/splash_view_body_listener.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashViewBodyListener());
  }
}
