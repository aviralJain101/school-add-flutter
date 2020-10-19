import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';
import 'package:school_ad/models/http_exception.dart';
import 'package:school_ad/models/user.dart';

enum AuthMode {Signup,Login}

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: ExactAssetImage('assets/login.jpg'),
            //     fit: BoxFit.cover
            //   ),
            // ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: AuthCard(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String,String> _authData = {
    'email':'',
    'password':'',
    'userName':'',
    'city': ''
  };
  bool _isLoading = false;
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
    _opacityAnimation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn
    ));
    _slideAnimation = Tween<Offset>(begin: Offset(0.0,-1.5),end: Offset(0.0,0.0)).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialogue(String message){
    showDialog(context: context,builder: (context)=>AlertDialog(
      title: Text('An Error Occured'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(child: Text('Okay'),onPressed: (){
          Navigator.of(context).pop();
        },)
      ],
    ));
  }

  Future<void> _submit()async{
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try{
      if(_authMode == AuthMode.Signup){
        await Provider.of<Auth>(context,listen: false).signUp(_authData['email'],_authData['password'], _authData['userName'], _authData['city']);
      }else{
        await Provider.of<Auth>(context, listen: false).login(_authData['email'], _authData['password'], _authData['city']);
      }    
    }on HttpException catch(error){
      var message = 'Authentication failed';
      if(error.toString().contains('EMAIL_EXISTS')){
        message = 'Email already in use';
      }else if(error.toString().contains('INVALID_EMAIL')){
        message = 'Please enter a valid email address';
      }else if(error.toString().contains('EMAIL_NOT_FOUND')){
        message = 'Could not find the user with that email. Please SignUp';
      }else if(error.toString().contains('WEAK_PASSWORD')){
        message = 'Your password is too weak';
      }else if(error.toString().contains('INVALID_PASSWORD')){
        message = 'Invalid password';
      }
      _showErrorDialogue(message);
    }catch(error){
      const message = 'Could not authenticate. Please enter a correct email and password or Check your internet connection';
      _showErrorDialogue(message);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode(){
    if(_authMode==AuthMode.Login){
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    }else{
      setState(() {
        _authMode = AuthMode.Login;
      });
     _controller.reverse();
    }
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading?Center(child: CircularProgressIndicator(),) : Card(
      color: Colors.white.withOpacity(0.7),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10)
      // ),
      elevation: 8,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 400 : 320,
        constraints: BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width*0.75,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value.isEmpty||!value.contains('@')){
                      return 'Invalid Email';
                    }
                  },
                  onSaved: (value){
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value){
                    if(value.isEmpty||value.length<5){
                      return 'Password is too short';
                    }
                  },
                  onSaved: (value){
                    _authData['password'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'City of School'),
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Enter the city for your School';
                    }
                  },
                  onSaved: (value){
                    _authData['city'] = value;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode==AuthMode.Signup?60:0,
                    maxHeight: _authMode==AuthMode.Signup?120:0
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: InputDecoration(labelText: 'User Name'),
                        validator: _authMode == AuthMode.Signup?(value){
                          if(value.isEmpty){
                            return 'Please provide a user name';
                          }
                        }:null,
                        onSaved: _authMode == AuthMode.Signup?(value){
                          _authData['userName'] = value;
                        }:null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text(_authMode == AuthMode.Login?'LOGIN':'SIGN UP'),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                  color: Theme.of(context).primaryColor,
                ),
                FlatButton(
                  child: Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}