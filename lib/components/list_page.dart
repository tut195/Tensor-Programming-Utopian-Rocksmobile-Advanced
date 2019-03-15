import 'package:flutter/material.dart';
import 'package:tensor_programming_advanced/models/model.dart';
import 'package:tensor_programming_advanced/providers/cintribution_provider.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
      stream: bloc.results,
      builder: (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
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
      },
    );
  }
}
