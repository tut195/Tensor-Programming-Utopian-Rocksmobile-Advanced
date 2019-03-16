import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tensor_programming_advanced/blocs/base_provider.dart';
import 'package:tensor_programming_advanced/blocs/contribution_bloc.dart';
import 'package:tensor_programming_advanced/blocs/steem_bloc.dart';
import 'package:tensor_programming_advanced/components/bottom_bar.dart';
import 'package:tensor_programming_advanced/components/information_drawer.dart';
import 'package:tensor_programming_advanced/components/list_page.dart';
import 'package:tensor_programming_advanced/models/github_api.dart';
import 'package:tensor_programming_advanced/models/rocks_api.dart';
import 'package:tensor_programming_advanced/models/steem_api.dart';
import 'package:tensor_programming_advanced/providers/information_provider.dart';
//import 'package:tensor_programming_advanced/providers/cintribution_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContributionBloc>(
        builder: (BuildContext context, ContributionBloc bloc) =>
            bloc ??
            ContributionBloc(
              RocksApi(),
            ),
        onDispose: (BuildContext context, ContributionBloc bloc) => bloc.dispose(),
        child: RootApp());
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = Provider.of<ContributionBloc>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Utopian Rocks Mobile',
      theme: ThemeData(
        primaryColor: Color(0xff24292e),
        accentColor: Color(0xff26A69A),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: BlocProvider<SteemBloc>(
            builder: (_, bloc) => bloc ?? SteemBloc(SteemApi()),
            onDispose: (_, bloc) => bloc.dispose(),
            child: BottomBar(contributionBloc),
          ),
          appBar: AppBar(
            title: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Image.asset(
                    'assets/images/utopy.png',
                  ),
                ),
                Text(
                  'Utopian Rocks Mobile',
                ),
              ],
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
          endDrawer: BlocProvider<InformationBloc>(
            builder: (_, bloc) => InformationBloc(
              PackageInfo.fromPlatform(),
              GithubApi(),
            ),
            onDispose: (_, bloc) => bloc.dispose(),
            child: InformationDrawer(),
          ),
        ),
      ),
    );
  }
}