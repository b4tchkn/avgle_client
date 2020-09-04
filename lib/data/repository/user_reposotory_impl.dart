import 'package:avgleclient/data/remote/user_data_source.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({@required UserDataSource dataSource})
      : _dataSource = dataSource;

  final UserDataSource _dataSource;
  @override
  Future<User> fetchUser() {
    return _dataSource.getUser();
  }

  @override
  Future<User> signIn() {
    return _dataSource.signIn();
  }

  @override
  Future<GoogleSignInAccount> signOut() async {
    return await _dataSource.signOut();
  }
}
