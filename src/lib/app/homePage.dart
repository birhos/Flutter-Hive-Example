import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:example/app/addUser.dart';
import 'package:example/others/constants.dart';
import 'package:example/domain/models/user/userModel.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthMultiplier = (MediaQuery.of(context).size.width / 100);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Hive',
          style: Theme.of(context).textTheme.display1.copyWith(
                color: Colors.white,
                fontSize: 5.0 * widthMultiplier,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Container(
        width: widthMultiplier * 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: _buildListView(),
            ),
            AddUser(),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Constants.boxRehber).listenable(),
      builder: (BuildContext context, Box contactsBox, Widget child) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: contactsBox.length,
          itemBuilder: (BuildContext context, int index) {
            final UserModel user = contactsBox.getAt(index) as UserModel;

            return ListTile(
              title: Text(
                user.name,
              ),
              subtitle: Text(
                user.age.toString(),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      contactsBox.putAt(
                        index,
                        UserModel(
                          name: '${user.name}*',
                          age: user.age + 1,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      contactsBox.deleteAt(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
