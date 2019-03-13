import 'package:flutter/material.dart';
import 'package:tensor_programming_advanced/models/model.dart';
import 'package:tensor_programming_advanced/models/rocks_api.dart';
import 'package:tensor_programming_advanced/providers/cintribution_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      contributionBloc: ContributionBloc(RocksApi()),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final contributionBloc = ContributionProvider.of(context);
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
        ),
      ),
    );
  }
}
class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
        stream: bloc.results,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('${snapshot.data[index].title}'),
            ),
          );
        });
  }
}