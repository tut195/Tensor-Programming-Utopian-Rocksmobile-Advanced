import 'dart:async';

import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tensor_programming_advanced/models/model.dart';

import '../models/github_api.dart';

class InformationBloc {
  final Future<PackageInfo> packageInfo;
  final GithubApi api;

  Stream<PackageInfo> _infoStream = Stream.empty();
  Stream<GithubModel> _releases = Stream.empty();

  Stream<PackageInfo> get infoStream => _infoStream;

  Stream<GithubModel> get releases => _releases;

  InformationBloc(this.packageInfo, this.api) {
    // Сдесь мы создаём класс observable при помощи
    _releases = Observable.defer(() => Observable.fromFuture(api.getReleases()).asBroadcastStream(), reusable: true);

    _infoStream = Observable.defer(
          () => Observable.fromFuture(packageInfo).asBroadcastStream(),
      reusable: true,
    );
  }
}
