import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:swipe_test_github_repos/src/services/base/failure.dart';
import 'package:swipe_test_github_repos/src/services/network_service/http_network_service_impl.dart';

final successUri = Uri.parse('http://www.google.com');
final errorUri = Uri.parse('http://www.google.com/error');

final client = MockClient((request) async {
  if (request.url == successUri) {
    return Response(json.encode({"data": "success"}), 200);
  } else {
    throw Failure('failed');
  }
});

void main() {
  final networkService = HttpServiceImpl(client: client);

  group('Http service methods test', () {
    test('Should return success when GET request is successful', () async {
      final response = await networkService.get(successUri);

      expect(response, {"data": "success"});
    });

    test('Should return error when GET request is not successful', () async {
      final response = networkService.get(errorUri);

      expect(response, throwsA(isA<Failure>()));
    });
  });
}