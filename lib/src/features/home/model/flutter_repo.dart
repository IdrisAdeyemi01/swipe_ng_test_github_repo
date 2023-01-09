class FlutterRepo {
  final String repoName;
  final String repoOwner;
  FlutterRepo({
    required this.repoName,
    required this.repoOwner,
  });

  FlutterRepo copyWith({
    String? repoName,
    String? repoOwner,
  }) {
    return FlutterRepo(
      repoName: repoName ?? this.repoName,
      repoOwner: repoOwner ?? this.repoOwner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'repoName': repoName,
      'repoOwner': repoOwner,
    };
  }

  factory FlutterRepo.fromMap(Map<String, dynamic> map) {
    return FlutterRepo(
      repoName: map['repoName'] ?? '',
      repoOwner: map['repoOwner'] ?? '',
    );
  }

  @override
  String toString() =>
      'FlutterRepo(repoName: $repoName, repoOwner: $repoOwner)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlutterRepo &&
        other.repoName == repoName &&
        other.repoOwner == repoOwner;
  }

  @override
  int get hashCode => repoName.hashCode ^ repoOwner.hashCode;
}
