import 'package:flutter/material.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:validators/validators.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';

import 'package:uniquote/screens/auth/register/register_title.dart';
import 'package:uniquote/screens/auth/register/register_bottom.dart';
import 'package:uniquote/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController _authController = AuthController();
  final _formKey = new GlobalKey<FormState>();
  var _passKey = GlobalKey<FormFieldState>();

  Color _eyeButtonColor1 = Colors.grey;
  Color _eyeButtonColor2 = Colors.grey;
  bool _isObscured1 = true;
  bool _isObscured2 = true;

  String _email, _name, _password, _passwordC;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
        children: <Widget>[
          SizedBox(height: kToolbarHeight),
          RegisterTitle(),
          fields(),
          SizedBox(
            height: 25.0,
          ),
          loginButton(context),
          SizedBox(
            height: 20.0,
          ),
          RegisterBottom(),
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
                'Register',
                style: TextStyle(fontSize: 17),
              ),
              callback: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  final result = await _authController.register(
                      _name, _email, _password, _passwordC);
                  if (result == true) {
                    _authController.successPush(context);
                  } else {
                    _authController.registerPush(context);
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
          onSaved: (nameInput) => _name = nameInput,
          validator: (nameInput) {
            if (nameInput.isEmpty) {
              return 'Please enter an nickname';
            }
            if (!isAlphanumeric(nameInput)) {
              return 'Nickname should not contain any special characters or spaces';
            }
          },
          decoration: InputDecoration(
              labelText: 'Nickname', icon: Icon(Icons.person_outline)),
        ),
        TextFormField(
          onSaved: (emailInput) => _email = emailInput,
          keyboardType: TextInputType.emailAddress,
          validator: (emailInput) {
            if (emailInput.isEmpty) {
              return 'Please enter an email';
            } else {
              if (!isEmail(emailInput)) {
                return 'Please enter an valid email';
              }
            }
          },
          decoration: InputDecoration(
              labelText: 'Email Address',
              icon: Icon(GroovinMaterialIcons.email_outline)),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          onSaved: (passwordInput) => _password = passwordInput,
          key: _passKey,
          validator: (passwordInput) {
            if (passwordInput.isEmpty) {
              return 'Please enter a password';
            }
            if (passwordInput.length < 6) {
              return "Passwords cant be less then 6 characters";
            }
          },
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline),
            labelText: 'Password',
            suffixIcon: IconButton(
              onPressed: () {
                if (_isObscured1) {
                  setState(() {
                    _isObscured1 = false;
                    _eyeButtonColor1 = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscured1 = true;
                    _eyeButtonColor1 = Colors.grey;
                  });
                }
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColor1,
              ),
            ),
          ),
          obscureText: _isObscured1,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          onSaved: (passwordCInput) => _passwordC = passwordCInput,
          validator: (passwordCInput) {
            if (passwordCInput.isEmpty) {
              return 'Please enter password again';
            }
            var password = _passKey.currentState.value;
            if (!equals(passwordCInput, password)) {
              return "Passwords are not same";
            }
          },
          decoration: InputDecoration(
            icon: Icon(Icons.lock_outline),
            labelText: 'Password Again',
            suffixIcon: IconButton(
              onPressed: () {
                if (_isObscured2) {
                  setState(() {
                    _isObscured2 = false;
                    _eyeButtonColor2 = Theme.of(context).primaryColor;
                  });
                } else {
                  setState(() {
                    _isObscured2 = true;
                    _eyeButtonColor2 = Colors.grey;
                  });
                }
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeButtonColor2,
              ),
            ),
          ),
          obscureText: _isObscured2,
        ),
      ],
    );
  }
}
