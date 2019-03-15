import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tensor_programming_advanced/blocs/base_provider.dart';
import 'package:tensor_programming_advanced/blocs/contribution_bloc.dart';
import 'package:tensor_programming_advanced/components/information_drawer.dart';
import 'package:tensor_programming_advanced/components/list_page.dart';
import 'package:tensor_programming_advanced/models/github_api.dart';
import 'package:tensor_programming_advanced/models/rocks_api.dart';
import 'package:tensor_programming_advanced/providers/information_provider.dart';
//import 'package:tensor_programming_advanced/providers/cintribution_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContributionBloc>(
        builder: (BuildContext context, ContributionBloc bloc) => bloc ?? ContributionBloc(RocksApi()),
        onDispose: (BuildContext context, ContributionBloc bloc) => bloc.dispose(),
        child: RootApp());
  }
}

class RootApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final contributionBloc = Provider.of<ContributionBloc>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile My!!!',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Utopian Rocks Mobile My!!!',
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'Waiting for Review',
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'Waiting on Upvote',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage('unreviewed', contributionBloc),
              ListPage('pending', contributionBloc),
            ],
          ),
          endDrawer: InformationProvider(
            child: InformationDrawer(),
            informationBloc: InformationBloc(PackageInfo.fromPlatform(), GithubApi()),
          ),
        ),
      ),
    );
  }
}
