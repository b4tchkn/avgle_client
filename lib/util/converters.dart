class Converters {
  static String toViewCountFormatted(int viewnumber) {
    String viewCount;
    if (viewnumber < 10000) {
      viewCount = '$viewnumber回';
    } else {
      // ignore: unnecessary_parenthesis
      viewCount = '${(viewnumber / 10000)}万回';
    }
    return viewCount;
  }

  static String toAddedAtFormatted(int addtime) {
    String addedAt;
    final now = DateTime.now();

    final date = DateTime.fromMillisecondsSinceEpoch(addtime * 1000);
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      // ○日前が0のとき
      if (diff.inHours == 0) {
        // ○時間前が0のとき
        addedAt = '${diff.inMinutes}分前';
      } else {
        addedAt = '${diff.inHours}時間前';
      }
    } else {
      addedAt = '${diff.inDays}日前';
    }
    return addedAt;
  }
}
