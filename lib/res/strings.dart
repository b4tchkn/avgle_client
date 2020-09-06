class Strings {
  static const bottomNavItemHomeTitle = 'ホーム';
  static const bottomNavItemExploreTitle = '探索';
  static const bottomNavItemLibraryTitle = 'ライブラリ';

  // For Home
  static const homeModalBottomSheetSaveWatchLater = '後で見るに保存';
  static const homeSaveWatchLaterSuccess = '後で見るに保存しました';
  static const homeSaveWatchLaterFailure = '保存できませんでした';
  static const homeModalBottomSheetSavePlayList = '再生リストに保存';

  // For Profile
  static const profileAppBarTitle = 'アカウント';
  static const profileSignInWithGoogle = 'Googleでサインイン';
  static const profileSignOut = 'サインアウト';
  static const debugPageTitle = 'デバッグ画面';

  // For Library
  static const libraryWatchRecently = '最近視聴したコンテンツ';
  static const libraryHistory = '履歴';
  static const libraryWatchLater = '後で見る';
  static const libraryPlayList = '再生リスト';
  static const libraryNewPlayList = '新しい再生リスト';
  static const libraryPleaseSignIn = 'サインインして\nAvgleをお楽しみください';
  static const librarySignInWithGoogle = 'Googleでサインイン';

  // For WatchLater
  static const watchLaterAppBarTitle = '後で見る';
  static String watchLaterYourWatchLater(String displayName) =>
      '${displayName}の\n後で見る';
}
