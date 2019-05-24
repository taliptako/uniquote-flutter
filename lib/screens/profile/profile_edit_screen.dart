import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:uniquote/config/sl.dart';
import 'package:uniquote/stores/root_store.dart';
import 'package:uniquote/config/config.dart';
import 'package:uniquote/models/user_store.dart';
import 'package:uniquote/data/user_api.dart';

class ProfileEditScreen extends StatefulWidget {
  final UserStore user;

  const ProfileEditScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  RootStore _rootStore = sl<RootStore>();
  Config _config = sl<Config>();

  UserApi _userApi = UserApi();

  final _editForm = GlobalKey<FormState>();

  var _image;

  final _bioController = TextEditingController();

  DateTime date;

  String bio;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _editForm,
          child: ListView(
            children: <Widget>[],
          ),
        ));
  }

  buildFields() {
    return Column(
      children: <Widget>[
        TextFormField(
          enabled: false,
          decoration: InputDecoration(
            labelText: '${widget.user.email}',
            icon: Icon(Icons.email),
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
        TextFormField(
          enabled: false,
          decoration: InputDecoration(
            labelText: '${widget.user.name}',
            icon: Icon(Icons.grade),
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
        DateTimePickerFormField(
          inputType: InputType.date,
          initialValue: widget.user.born,
          format: DateFormat('yyyy-MM-dd'),
          editable: true,
          decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              labelText: 'Birthday',
              hasFloatingPlaceholder: false),
          onChanged: (dt) => setState(() => date = dt),
        ),
        TextFormField(
          maxLines: 4,
          enabled: true,
          controller: _bioController,
          onSaved: (bioInput) => bio = bioInput,
          decoration: InputDecoration(
            labelText: 'Bio',
            icon: Icon(Icons.person_pin),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width / 3,
          child: RaisedButton(
            color: Colors.deepPurple,
            onPressed: () async {
              _editForm.currentState.save();
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector buildAvatar() {
    if (widget.user.avatarLg == null && _image == null) {
      return GestureDetector(
        onTap: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {
            _image = image;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {
          _image = image;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _image != null
              ? CircleAvatar(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.black,
                      )),
                  radius: 60,
                  backgroundImage: FileImage(_image),
                )
              : CircleAvatar(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.black,
                      )),
                  radius: 60,
                  backgroundImage:
                      NetworkImage(_config.storageUrl + widget.user.avatarLg),
                ),
        ],
      ),
    );
  }
}
