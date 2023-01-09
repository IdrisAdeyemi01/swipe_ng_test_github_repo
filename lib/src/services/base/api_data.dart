class APIData {
  static const host = 'api.github.com';
  static const String scheme = 'https';

  static Uri baseUri() => Uri(scheme: scheme, host: host, path: '');

  static Uri errorUri() => Uri(scheme: scheme, host: host, path: '/nopath');

  static Uri fetchFlutterRepos({required String query}) => Uri(
        scheme: scheme,
        host: host,
        path: 'search/repositories',
        query:  query,
      );

  static Uri fetchMore(String url) => Uri.parse(url);
}