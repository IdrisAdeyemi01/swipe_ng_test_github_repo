import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipe_test_github_repos/src/core/utilities/view_state.dart';
import 'package:swipe_test_github_repos/src/repository/flutter_repos_repository.dart';

import '../../../services/base/failure.dart';
import '../../../services/snackbar_service/snackbar_service.dart';
import '../state/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this._ref) : super(HomeState.initial()) {
    getFlutterRepos();
  }

  final Ref _ref;

  Future<void> getFlutterRepos() async {
    int page = 1;
    int numberOfReposPerPage = 10;
    try {
      state = state.copyWith(viewState: ViewState.loading);
      final repos = await _ref.read(flutterReposRepository).getFlutterRepos(
            page: page,
            numberOfReposPerPage: numberOfReposPerPage,
          );
      print('Passed here 1');
      state = state.copyWith(
          viewState: ViewState.idle,
          totalCountOfRetrievedRepos: repos['totalCount'],
          flutterRepos: repos["listOfFlutterRepos"],
          numberOfFlutterRepos: numberOfReposPerPage,
          pageNumber: page++);
    } on Failure {
      _ref.read(snackbarService).showErrorSnackBar(
          'An error occured while fetching repos from Github');
      state = state.copyWith(
        viewState: ViewState.error,
      );
    }
  }

  Future<void> getMoreFlutterRepos() async {
    int numberOfReposPerPage = 10;
    try {
      if (state.numberOfFlutterRepos! >= state.totalCountOfRetrievedRepos!) {
        _ref
            .read(snackbarService)
            .showErrorSnackBar('You have reached the end of the list');
      } else {
        final repos = await _ref.read(flutterReposRepository).getFlutterRepos(
              page: state.pageNumber,
              numberOfReposPerPage: numberOfReposPerPage,
            );
        final totalCount = repos['totalCount'];
        final listOfFlutterRepos = repos["listOfFlutterRepos"];

        state = state.copyWith(
          viewState: ViewState.idle,
          totalCountOfRetrievedRepos: totalCount,
          flutterRepos: [...state.flutterRepos, ...listOfFlutterRepos],
          pageNumber: state.pageNumber + 1,
        );
      }
    } on Failure {
      _ref.read(snackbarService).showErrorSnackBar(
          'An error occured while fetching repos from Github');
      state = state.copyWith(
        viewState: ViewState.error,
      );
    } finally {
      state = state.copyWith(
          viewState: ViewState.idle, pageNumber: state.pageNumber);
    }
  }
}

final homeViewNotifier = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier(ref),
);
