
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import 'http_network_service_impl.dart';

abstract class NetworkService {
  Future<dynamic> get(Uri uri);
}

final networkService = Provider<NetworkService>(
  ((ref) => HttpServiceImpl(client: Client())),
);