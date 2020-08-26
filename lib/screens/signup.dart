import 'package:flutter/material.dart';
import 'package:loginstudy/firebase_provider.dart';
import 'package:loginstudy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(fp == null){
      fp = Provider.of<FirebaseProvider>(context);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  login_Gradient1,
                  login_Gradient2,
                  login_Gradient3,
                  login_Gradient4,
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildNameField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildPhoneField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildEmailField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildPWField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildConfirmPWField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  bulidRegisterField(),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildSignInField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInField() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? | ',
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            TextSpan(
              text: 'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bulidRegisterField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        /*shadow style*/
        onPressed: () {
          _signUp();
        },
        padding: EdgeInsets.all(14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        /*box color*/
        child: Text(
          'Register',
          style: TextStyle(
            color: btnTextColor,
            fontSize: 20.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildConfirmPWField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            obscureText: true,
            /*비밀번호 안보이게*/
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              hintText: 'Enter confirm password',
              hintStyle: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPWField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            controller: _pwController,
            obscureText: true,
            /*비밀번호 안보이게*/
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            controller: _idController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your E-mail',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone No',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone_iphone,
                color: Colors.white,
              ),
              hintText: 'Enter your phone number',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: loginBoxDeco,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              hintText: 'Enter your name',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  void _signUp() async {
    _scaffoldKey.currentState..hideCurrentSnackBar()..showSnackBar(SnackBar(
      duration: Duration(seconds: 10),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          Text(" 가입 중입니다...   "),
        ],
      ),
    ));

    bool result = await fp.signUpWithEmail(_idController.text, _pwController.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if(result){
      Navigator.pop(context);
    }else{

      showLastFBMessage();
      _idController.text = '';
      _pwController.text = '';
    }
  }

  showLastFBMessage() {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(fp.getLastFBMessage()),
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}
