import 'package:comic_mania/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'comic/:id',
            name: ComicScreen.name,
            builder: (context, state) {
              final comicId = state.pathParameters['id'] ?? 'no-id';

              return ComicScreen(comicId: comicId);
            },
          ),
        ]),
  ],
);
