import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipe_test_github_repos/src/core/theme/app_theme.dart';
import 'package:swipe_test_github_repos/src/features/home/view/home_view.dart';
import 'package:swipe_test_github_repos/src/services/snackbar_service/snackbar_service.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwipeNG Test',
      theme: AppTheme.lightTheme,
      scaffoldMessengerKey: ref.watch(snackbarService).scaffoldMessengerKey,
      home: const HomeView(),
    );
  }
}
