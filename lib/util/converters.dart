class Converters {
  static String toViewCountFormatted(int viewnumber) {
    String viewCount;
    if (viewnumber < 10000) {
      viewCount = '$viewnumber回';
    } else {
      // ignore: unnecessary_parenthesis
      viewCount = '${(viewnumber / 10000).toStringAsFixed(1)}万回';
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
      if (diff.inDays > 365) {
        addedAt = '${(diff.inDays / 365).floor()}年前';
      } else {
        addedAt = '${diff.inDays}日前';
      }
    }
    return addedAt;
  }

  static String toVideoDurationFormatted(double duration) {
    String formattedDuration;

    final h = duration ~/ 3600;
    final m = (duration - h * 3600) ~/ 60;
    final s = duration.toInt() - (h * 3600) - (m * 60);
    if (h == 0) {
      formattedDuration =
          '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    } else {
      formattedDuration =
          '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return formattedDuration;
  }
}
