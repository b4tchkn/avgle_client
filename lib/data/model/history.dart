class History {
  const History({this.id, this.keyword});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'keyword': keyword,
    };
  }

  final int id;
  final String keyword;
}
