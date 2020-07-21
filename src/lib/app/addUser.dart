import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import 'package:example/others/constants.dart';
import 'package:example/domain/models/user/userModel.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController;
  TextEditingController ageTextEditingController;

  @override
  void initState() {
    super.initState();

    nameTextEditingController = TextEditingController();
    ageTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    ageTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthMultiplier = (MediaQuery.of(context).size.width / 100);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2.0 * widthMultiplier),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: Theme.of(context).textTheme.display2.copyWith(
                            color: Colors.white,
                            fontSize: 3.5 * widthMultiplier,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.5 * widthMultiplier,
                ),
                Expanded(
                  child: TextFormField(
                    controller: ageTextEditingController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: Theme.of(context).textTheme.display2.copyWith(
                            color: Colors.white,
                            fontSize: 3.5 * widthMultiplier,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1.0 * widthMultiplier),
            child: RaisedButton(
              color: Colors.amber,
              child: Text(
                'New Add User',
                style: Theme.of(context).textTheme.display2.copyWith(
                      color: Colors.black,
                      fontSize: 4.0 * widthMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: () {
                _formKey.currentState.save();

                final UserModel newContact = UserModel(
                  name: nameTextEditingController.text.trim(),
                  age: int.parse(ageTextEditingController.text.trim()),
                );

                _add(newContact);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _add(UserModel contact) {
    final Box contactsBox = Hive.box(Constants.boxRehber);
    contactsBox.add(contact);

    if (mounted) {
      setState(() {
        nameTextEditingController.clear();
        ageTextEditingController.clear();
      });
    }
  }
}
