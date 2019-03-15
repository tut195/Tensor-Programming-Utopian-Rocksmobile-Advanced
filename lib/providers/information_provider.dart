import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import '../models/github_api.dart';

import 'package:tensor_programming_advanced/blocs/information_bloc.dart';
export 'package:tensor_programming_advanced/blocs/information_bloc.dart';



class InformationProvider extends InheritedWidget {
  final InformationBloc informationBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InformationBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(InformationProvider)
      as InformationProvider)
          .informationBloc;

  InformationProvider({
    Key key,
    InformationBloc informationBloc,
    Widget child,
  })  : this.informationBloc = informationBloc ??
      InformationBloc(
        PackageInfo.fromPlatform(),
        GithubApi(),
      ),
        super(
        key: key,
        child: child,
      );
}