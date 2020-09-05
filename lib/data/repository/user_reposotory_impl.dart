import 'package:avgleclient/data/remote/user_data_source.dart';
import 'package:avgleclient/data/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({@required UserDataSource dataSource})
      : _dataSource = dataSource;

  final UserDataSource _dataSource;
  @override
  Future<User> fetchUser() {
    return _dataSource.fetchUser();
  }

  @override
  Future<User> signIn() {
    return _dataSource.signIn();
  }

  @override
  Future<User> signOut() {
    return _dataSource.signOut();
  }
}
