import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:swipe_test_github_repos/src/core/constants/constants.dart';
import 'package:swipe_test_github_repos/src/features/home/model/flutter_repo.dart';
import 'package:swipe_test_github_repos/src/features/home/notifier/home_notifier.dart';
import 'package:swipe_test_github_repos/src/core/utilities/view_state.dart';

import 'widgets/repo_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          AppStrings.flutterRepos,
          style: textTheme.headline5,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
        child: Consumer(
          builder: ((context, ref, child) {
            final homeViewState = ref.watch(homeViewNotifier);
            if (homeViewState.viewState.isLoading) {
              return const _LoadingReposView();
            } else if (homeViewState.viewState.isError) {
              return const _ErrorView();
            } else {
              return _LoadedReposView(
                flutterRepos: homeViewState.flutterRepos,
              );
            }
          }),
        ),
      ),
    );
  }
}

class _LoadedReposView extends HookConsumerWidget {
  const _LoadedReposView({
    Key? key,
    required this.flutterRepos,
  }) : super(key: key);
  final List<FlutterRepo> flutterRepos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.read(homeViewNotifier.notifier);
    final state = ref.read(homeViewNotifier);
    final scrollController = useScrollController();
    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          homeProvider.getMoreFlutterRepos();
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(homeViewNotifier.notifier).getFlutterRepos(),
      child: flutterRepos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Github returned zero repos',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => ref
                        .refresh(homeViewNotifier.notifier)
                        .getFlutterRepos(),
                    child: const Text('Try again'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: scrollController,
              itemCount: flutterRepos.length,
              itemBuilder: (context, index) {
                if (index == flutterRepos.length - 1 &&
                    state.numberOfFlutterRepos! <
                        state.totalCountOfRetrievedRepos!) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return RepoTile(
                  index: index,
                  flutterRepo: flutterRepos[index],
                );
              },
            ),
    );
  }
}

class _LoadingReposView extends StatelessWidget {
  const _LoadingReposView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: ((context, index) => Shimmer.fromColors(
              baseColor: AppColors.darkGrey,
              highlightColor: AppColors.grey,
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )),
      ),
    );
  }
}

class _ErrorView extends ConsumerWidget {
  const _ErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'An error occured, please try again',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () =>
                ref.refresh(homeViewNotifier.notifier).getFlutterRepos(),
            child: const Text('Get Repos'),
          ),
        ],
      ),
    );
  }
}
