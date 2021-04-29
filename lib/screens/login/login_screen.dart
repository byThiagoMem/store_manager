import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/blocs/login_bloc.dart';
import 'package:store_manager/screens/home/home_screen.dart';
import 'package:store_manager/screens/login/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();


  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
          break;

        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Erro"),
                content: Text("Você nã possui os previlégios necessários"),
              ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }


  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case LoginState.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              );
            case LoginState.FAIL:
            case LoginState.SUCCESS:
            case LoginState.IDLE:
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(),
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.store_mall_directory,
                            color: Colors.pinkAccent,
                            size: 150.0,
                          ),
                          InputField(
                            hint: 'Usuário',
                            icon: Icons.person_outline,
                            obscure: false,
                            stream: _loginBloc.outEmail,
                            onChanged: _loginBloc.changeEmail,
                          ),
                          InputField(
                            hint: 'Senha',
                            icon: Icons.person_outline,
                            obscure: true,
                            stream: _loginBloc.outPassword,
                            onChanged: _loginBloc.changePassword,
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          StreamBuilder<bool>(
                            stream: _loginBloc.outSubmitValid,
                            builder: (context, snapshot) {
                              return SizedBox(
                                height: 50,
                                child: RaisedButton(
                                  onPressed: snapshot.hasData
                                      ? _loginBloc.submit
                                      : null,
                                  color: Colors.pinkAccent,
                                  textColor: Colors.white,
                                  disabledColor:
                                      Colors.pinkAccent.withAlpha(140),
                                  child: Text(
                                    "Entrar",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
          return Container();
        },
      ),
    );
  }
}
