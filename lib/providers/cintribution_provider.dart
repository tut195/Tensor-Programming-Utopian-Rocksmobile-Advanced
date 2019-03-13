import 'package:flutter/material.dart';
import 'package:tensor_programming_advanced/blocs/contribution_bloc.dart';
export 'package:tensor_programming_advanced/blocs/contribution_bloc.dart';
import 'package:tensor_programming_advanced/models/rocks_api.dart';

class ContributionProvider extends InheritedWidget {
  final ContributionBloc contributionBloc;

  @override
  updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContributionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ContributionProvider)
      as ContributionProvider)
          .contributionBloc;

  ContributionProvider({
    Key key,
    ContributionBloc contributionBloc,
    Widget child,
  })  : this.contributionBloc = contributionBloc ??
      ContributionBloc(
        RocksApi(),
      ),
        super(child: child, key: key);
}