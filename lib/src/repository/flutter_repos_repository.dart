import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swipe_test_github_repos/src/features/home/model/flutter_repo.dart';
import 'package:swipe_test_github_repos/src/services/base/api_data.dart';
import 'package:swipe_test_github_repos/src/services/base/failure.dart';
import 'package:swipe_test_github_repos/src/services/network_service/network_service.dart';

class FlutterReposRepository {
  final NetworkService networkService;

  FlutterReposRepository(this.networkService);

  Future<Map<String, dynamic>> getFlutterRepos({
    required int page,
    required int numberOfReposPerPage,
  }) async {
    try {
      String query =
          'q=flutter+language:dart&page=$page&per_page=$numberOfReposPerPage';
      final uri = APIData.fetchFlutterRepos(query: query);
    
      final repos = await networkService.get(uri);
      final totalCount = repos["total_count"];
      final allGottenRepos = repos["items"];

      List<FlutterRepo> flutterRepos = [];
      if (allGottenRepos == null) {
        return {
          "totalCount": 0,
          "listOfFlutterRepos": [],
        };
      }
      for (var repo in allGottenRepos) {
        final name = repo["name"];
        final owner = repo["owner"]["login"];
        final Map<String, String> detailMap = {
          "repoName": name,
          "repoOwner": owner,
        };
        flutterRepos.add(FlutterRepo.fromMap(detailMap));
      }
      return {
        "totalCount": totalCount,
        "listOfFlutterRepos": flutterRepos,
      };
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}

final flutterReposRepository = Provider<FlutterReposRepository>(
    ((ref) => FlutterReposRepository(ref.read(networkService))));
