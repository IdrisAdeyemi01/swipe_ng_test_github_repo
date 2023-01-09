import 'package:swipe_test_github_repos/src/core/utilities/view_state.dart';
import 'package:swipe_test_github_repos/src/features/home/model/flutter_repo.dart';

class HomeState {
  final List<FlutterRepo> flutterRepos;
  final ViewState viewState;
  final int? numberOfFlutterRepos;
  final int? totalCountOfRetrievedRepos;
  final int pageNumber;

  const HomeState._({
    required this.flutterRepos,
    required this.viewState,
    required this.pageNumber,
    this.numberOfFlutterRepos,
    this.totalCountOfRetrievedRepos,
  });

  factory HomeState.initial() => const HomeState._(
        flutterRepos: [],
        viewState: ViewState.idle,
        pageNumber: 1,
      );

  HomeState copyWith({
    List<FlutterRepo>? flutterRepos,
    ViewState? viewState,
    int? numberOfFlutterRepos,
    int? totalCountOfRetrievedRepos,
    int? pageNumber,
  }) {
    return HomeState._(
      flutterRepos: flutterRepos ?? this.flutterRepos,
      viewState: viewState ?? this.viewState,
      pageNumber: pageNumber ?? this.pageNumber,
      numberOfFlutterRepos: numberOfFlutterRepos ?? this.numberOfFlutterRepos,
      totalCountOfRetrievedRepos:
          totalCountOfRetrievedRepos ?? this.totalCountOfRetrievedRepos,
    );
  }
}
