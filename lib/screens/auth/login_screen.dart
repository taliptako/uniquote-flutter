import 'package:flutter/material.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:validators/validators.dart';

import 'package:uniquote/screens/auth/title.dart';
import 'package:uniquote/screens/auth/social_buttons.dart';
import 'package:uniquote/screens/auth/bottom_text.dart';
import 'package:uniquote/components/progress.dart';
import 'package:uniquote/controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController _authController = AuthController();
  final _formKey = new GlobalKey<FormState>();
  Color _eyeButtonColor = Colors.grey;

  String _email, _password;

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
        children: <Widget>[
          SizedBox(height: kToolbarHeight),
          TitleWidget(),
          fields(),
          SizedBox(
            height: 25.0,
          ),
          loginButton(context),
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'or login with',
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SocialButtons(),
          SizedBox(height: 20.0),
          BottomText(),
        ],
      ),
    );
  }

  Row loginButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: GradientButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              increaseWidthBy: 190,
              increaseHeightBy: 15,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 17),
              ),
              callback: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  Progress.show(context);

                  final result =
                      await _authController.emailLogin(_email, _password);
                  if (result == true) {
                    _authController.successPush(context);
                  } else {
                    _authController.logoutPush(context);
                  }
                }
              },
              gradient: LinearGradient(colors: [
                Colors.deepPurple,
                Colors.deepPurple[800],
              ])),
        )
      ],
    );
  }

  Column fields() {
    return Column(
      children: <Widget>[
        TextFormField(
          onSaved: (emailInput) => _email = emailInput,
          keyboardType: TextInputType.emailAddress,
          validator: (emailInput) {
            if (emailInput.isEmpty) {
              return 'Please enter an email';
            } else {
              if (!isEmail(emailInput)) {
                return 'Please enter valid email';
              }
            }
          },
          decoration: InputDecoration(labelText: 'Email Address'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          onSaved: (passwordInput) => _password = passwordInput,
          validator: (passwordInput) {
            if (passwordInput.isEmpty) {
              return 'Please enter a password';
            }
            if (passwordInput.length < 6) {
              return "Password cant be less then 6 characters";
            }
          },
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                if (_isObscured) {
                  setState(() {
                    _isObscured = false;
                    _eyeButtonColor = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscured = true;
                    _eyeButtonColor = Colors.grey;
                  });
                }
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColor,
              ),
            ),
          ),
          obscureText: _isObscured,
        ),
      ],
    );
  }
}
