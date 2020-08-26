import 'package:flutter/material.dart';
import 'package:loginstudy/screens/signup.dart';
import 'package:loginstudy/screens/weatherScreen.dart';
import 'package:loginstudy/shared/constants.dart';
import 'package:provider/provider.dart';

import '../firebase_provider.dart';


class LoginIn extends StatefulWidget {
  @override
  _LoginInState createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    logger.d(fp.getUser());

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

                /* import 해주어야 오류 발생하지 않음*/
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
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildEmailTextField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildPWTextField(),
                  buildForgetPWField(),
                  buildLoginbtnField(),
                  buildTextForm(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildSocialbtnField(),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildSignUpField(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Email",
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
          /*박스 데코레이션 불러오기*/
          height: 60.0,
          child: TextField(
            controller: _mailCon,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              /*이메일 선 지우기*/
              contentPadding: EdgeInsets.only(top: 14.0),
              /*Email 입력 영역 패딩 주기*/
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(color: Colors.white54), /*컬러 투명도 설정*/
            ),
          ), /*박스 두께 설정*/
        ),
      ],
    );
  }

  /*method extract 후 반환형을 모두 Widget으로 바꿔주기*/
  Widget buildSignUpField() {
    return GestureDetector(
      /*뭐지?*/
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: RichText(
        /*RichText가 뭐지?*/
        text: TextSpan(
          /*텍스트스팬은?*/
          children: [
            TextSpan(
              text: 'Don\'t have an Account? | ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSocialbtnField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      /*이게뭐지?*/
      children: <Widget>[
        Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                /*그림자 색상 설정*/
                offset: Offset(0, 2),
                /*그림자 위치? 크기?*/
                blurRadius: 8.0, /*그림자 블러 반경*/
              )
            ],
            image: DecorationImage(
              image: AssetImage('assets/facebook-2.jpg'),
            ),
          ),
        ),
        Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                /*그림자 색상 설정*/
                offset: Offset(0, 2),
                /*그림자 위치? 크기?*/
                blurRadius: 8.0, /*그림자 블러 반경*/
              )
            ],
            image: DecorationImage(
              image: AssetImage('assets/kakao-talk.png'),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildTextForm() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Sign in with',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }


  Widget buildLoginbtnField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      /*컨테이너 padding*/
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        /*컨테이너 쉐도우 스타일*/
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          /*컨테이너 모양 동그랗게 만들기*/
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        /*박스 색상 설정*/
        child: Text(
          'Login',
          style: TextStyle(
            color: btnTextColor,
            /*constant에서 정해놓은 색깔*/
            letterSpacing: 2.0,
            /*글자사이 간격*/
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _signIn();
        },
      ),
    );
  }
  void _signIn() async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   Signing-In...")
          ],
        ),
      ));
    bool result = await fp.signInWithEmail(_mailCon.text, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherScreen()));
    }
    else {
      showLastFBMessage();
      _mailCon.text = '';
      _pwCon.text = '';
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


  Widget buildForgetPWField() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        /*Forget Password 버튼을 클릭하면 아래 문장 콘솔에 출력*/
        onPressed: () {
          print('press forget password button');
        },
        padding: EdgeInsets.only(right: 0.0),
        /*글씨 오른쪽 라인에 붙게*/
        child: Text(
          'Forget Password?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildPWTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Password",
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
          /*박스 데코레이션 불러오기*/
          height: 60.0,
          child: TextField(
            controller: _pwCon,
            obscureText: true,
            /*비밀번호 안보이게 만드는 메서드*/
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              /*이메일 선 지우기*/
              contentPadding: EdgeInsets.only(top: 14.0),
              /*Email 입력 영역 패딩 주기*/
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(color: Colors.white54), /*컬러 투명도 설정*/
            ),
          ), /*박스 두께 설정*/
        ),
      ],
    );
  }

}










