class Repository {
  final String name;
  final String description;
  final String lastCommitDate;
  final String defaultBranch;
  final int forksCount;
  final int stargazersCount;
  final String language;

  Repository({
    required this.name,
    required this.description,
    required this.lastCommitDate,
    required this.defaultBranch,
    required this.forksCount,
    required this.stargazersCount,
    required this.language,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'] ?? '',
      lastCommitDate: json['pushed_at'],
      defaultBranch: json['default_branch'],
      forksCount: json['forks_count'],
      stargazersCount: json['stargazers_count'],
      language: json['language'] ?? 'Unknown',
    );
  }
}
