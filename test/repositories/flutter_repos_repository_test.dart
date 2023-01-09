import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swipe_test_github_repos/src/repository/flutter_repos_repository.dart';
import 'package:swipe_test_github_repos/src/services/base/failure.dart';
import 'package:swipe_test_github_repos/src/services/network_service/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  final networkService = MockNetworkService();

  final flutterReposRepository = FlutterReposRepository(networkService);

  setUp(() {
    registerFallbackValue(Uri.parse('uri'));
  });

  group('FlutterRepos Repository', () {
    test('Should return Flutter repos on success', () async {
      when(() => networkService.get(any())).thenAnswer(
        (_) => Future.value({"results": []}),
      );

      final flutterRepos = await flutterReposRepository.getFlutterRepos(
          page: 1, numberOfReposPerPage: 10);

      expect(
          flutterRepos,
          equals({
            "totalCount": 0,
            "listOfFlutterRepos": [],
          }));
    });

    test('Should throw failure on error', () async {
      when(() => networkService.get(any())).thenThrow(Failure('error'));

      final response = flutterReposRepository.getFlutterRepos(
          page: 1, numberOfReposPerPage: 10);

      expect(response, throwsA(isA<Failure>()));
    });
  });
}
