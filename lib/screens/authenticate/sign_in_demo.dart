import 'package:WMR/screens/authenticate/sign_in.dart';
import 'package:WMR/services/auth.dart';
import 'package:WMR/shared/constants.dart';
import 'package:WMR/shared/loading2.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
//import 'package:upgrader/upgrader.dart';

//import 'package:WMR/shared/globals.dart' as globals;
//import 'package:WMR/shared/size_config.dart';
import 'package:WMR/services/apis.dart';
//import 'package:WMR/screens/home/expired.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'package:global_configuration/global_configuration.dart'

//SS _storage = SS();
class SignInDemo extends StatefulWidget {
  final Function toggleView;
  SignInDemo({this.toggleView});

  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //final _storage.SS = new FlutterSecureStorage();

  String error;
  bool loading = false;
  bool _saveEmail = false;
  bool _forgotPassword = false;
  int numAccounts;
  int numWatchlists;
  int initialTab = 0;
  int delay = 1500;
  //String email;
  //bool _read = false;

  final _st = FlutterSecureStorage();

  @override
  void initState() {
    //loading = true;
    //_readAll();

    super.initState();
  }

  // Future<Null> _readAll() async {
  //   await _st.delete(key: 'token');
  //   await _st.read(key: 'email').then((e) {
  //     setState(() {
  //       if (e != null) {
  //         email = e.toString();
  //         _saveEmail = true;
  //       } else {
  //         email = '';
  //         _saveEmail = false;
  //       }
  //     });
  //     loading = false;
  //   });
  // }

  // void _deleteAll() async {
  //   await _st.deleteAll();
  //   _readAll();
  // }

  // Future<String> loadSettingsFuture; // <-Add this

  // @override
  // void initState() {
  //   loadSettingsFuture = _deleteAll(); // <- Change This
  //   //accountIndex = _items['accountIndex'];

  //   super.initState();
  // }

  // Future<Null> _deleteAll() async {
  //   //await _storage.deleteAll();
  //   //sEmail = await _storage.read("email");
  //   sEmail = await _storage.read("token");
  //   await _storage.delete("token");
  // }

  // text field state
   String email = 'demo@watchmyrisk.com';
   String password = '*1Demo123';

  //String email = 'test22@watchmyrisk.com';
  //String password = 'tester';

  //String email = '';
  //Future<String> sEmail = _storage.read("email");
  //final storage = new FlutterSecureStorage();

// Read value

  //String password = '';
  //String email = '';

  bool _validate() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      if (_saveEmail) {
        _st.write(key: 'email', value: email);
      } else {
        _st.delete(key: 'email');
      }
      return true;
    } else {
      _st.delete(key: 'email');
      return false;
    }
  }

  Widget showError() {
    //print(error);
    if (error == null) return SizedBox(height: 0.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.grey[400],
      ),
      //color: Colors.grey[200],
      //width: double.infinity,
      //padding: EdgeInsets.all(3.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 0),
            child: Icon(
              Icons.error_outline,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: AutoSizeText(
              error,
              style: TextStyle(fontSize: 14, color: Colors.red[900]),
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  error = null;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Future storeData() async {
    loading = true;
    List accounts = await getAccounts();
    // String accountNames = "";
    // accounts.forEach((account) {
    //   accountNames += account['name'] + ',';

    //  });
    //List watchLists = await getWatchlists();
    // print("Storing data. LA: ${accounts.length}");
    // print("Storing data. WL: ${watchLists.length}");
    //await _storage.write('numAccounts', accounts.length);
    //await _storage.write('accountNames', accountNames);
    //await _storage.write('numManualPortfolios', watchLists.length);
    //await _storage.write('tIndex', 0);

    // if (accounts.length > 0 ) {
    //     //await _storage.write('numLinkedAccounts', accounts.length);
    //     await _storage.write('tIndex', 1);
    //     await _storage.write('account', accounts[0]);
    //     await _storage.write('accountIndex', 0);
    //     await _storage.write('defaultAccount', accounts[0]);
    //}
    // if (watchLists.length > 0 )    {
    //     await _storage.write('watchlistIndex', 0);
    //     //await _storage.write('numManualPortfolios', watchLists.length);
    //     await _storage.write('watchlist', watchLists[0]);
    //     await _storage.write('defaultWatchlist', watchLists[0]);
    // }

    loading = false;
    return accounts.length;
  }

  Widget showMessage() {
    if (_forgotPassword) {
      return Text(
          "Please submit your email. You will receive an email, allowing you to change your password.");
    } else {
      return SizedBox(
        height: 0.0,
      );
    }
  }

  Widget showPassword() {
    return Visibility(
      child: Column(
        children: [
          TextFormField(
            //initialValue: "",
            //initialValue: "tester",
            initialValue: "*1Demo123",
            obscureText: true,
            decoration: InputDecoration(
              hintText: "password",
            ),
            // validator: (value) =>
            //     value.length < 6 ? 'Enter a password 6+ chars long' : null,
            onSaved: (value) => password = value,
            // onChanged: (val) {
            //   setState(() => password = val);
            // },
          ),
          SizedBox(height: h2),
        ],
      ),
      visible: !_forgotPassword,
    );
  }

  Widget showForgotText() {
    if (_forgotPassword) {
      return GestureDetector(
          child: Text(
            "Sign in",
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          onTap: () {
            //print("Changing password");
            setState(() => _forgotPassword = false);
          });
    } else {
      return Column(
        children: [
          GestureDetector(
              child: Text(
                "Forgot my password",
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              onTap: () {
                //print("Changing password");
                setState(() => _forgotPassword = true);
              }),
              SizedBox(height: 30,),
              Text("Don't have an account yet?"),
              SizedBox(height: 5,),
              GestureDetector(
              child: Text(
                "Sign up here",
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
              onTap: () {
                //print("Changing password");
                Navigator.of(context).pushReplacementNamed('/sign_on');
              }),
        ],
      );
    }
  }

  Widget showSubmit() {
    if (_forgotPassword) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: h3,
          ),
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                //side: BorderSide(color: Colors.red)
              ),
              color: Colors.grey[600],
              child: Text(
                'Submit',
                style: white_14(),
              ),
              onPressed: () async {
                if (_validate()) {
                  //setState(() => loading = true);
                  //setState(() => _forgotPassword = false);

                  //await _auth.signInWithEmailAndPassword(email, password);
                  dynamic result = await _auth.resetPassword(email);
                  //print("Result:$result");
                  if (!(result.startsWith("ERROR: "))) {
                    Flushbar(
                      //padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Colors.lightBlue[700],
                      titleText: Center(
                          child: Text("Please check your email!",
                              style: white14Bold())),
                      messageText: Center(
                          child: Text(
                        "",
                        style: titleStyle(),
                      )),
                      duration: Duration(seconds: 5),
                    )..show(context);
                    Future.delayed(Duration(milliseconds: 3000), () async {
                      setState(() => _forgotPassword = false);

                      //await Navigator.of(context).pushReplacementNamed('/sign_in');
                    });
                  } else {
                    String _error = result.replaceAll('ERROR: ', '');
                    setState(() {
                      loading = false;
                      error = _error;
                    });
                  }
                }
              }),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("Remember my email", style: white_10()),
          // Checkbox(
          //   value: _saveEmail,
          //   onChanged: (value) {
          //     setState(() {
          //       _saveEmail = value;
          //     });
          //   },
          //   //  activeTrackColor: Colors.lightGreenAccent,
          //   activeColor: Colors.grey[800],
          //   checkColor: Colors.greenAccent,
          // ),
          // SizedBox(width: w4),
          RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                //side: BorderSide(color: Colors.red)
              ),
              color: Colors.grey[600],
              child: Text(
                'Sign In',
                style: white_14(),
              ),
              onPressed: () async {
                if (_validate()) {
                  setState(() => loading = true);
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);

                  if (result == null) {
                    //print("Bad credentials");
                    setState(() {
                      loading = false;
                      error =
                          'Could not sign in with those credentials. Please try again.';
                    });
                  } else {
                    String token = await result.getIdToken();
                    //IdTokenResult _token = await result.getIdToken();
                    //String token = _token.token;
                    await _st.delete(key: 'token');
                    await _st.delete(key: 'user');
                    _st.write(key: 'token', value: token.toString());
                    _st.write(key: 'user', value: 'demo');
                    //List accounts = await getAccounts();
                    // if (accounts.length > 0 ){
                    await Navigator.of(context).pushReplacementNamed('/home');
                  }
                }
              }),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only call clearSavedSettings() during testing to reset internal values.
    //Upgrader().clearSavedSettings();
    // final appcastURL = 'https://www.watchmyrisk.com/upgrader/appcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    // final _width = MediaQuery.of(context).size.width;
    // final _height = MediaQuery.of(context).size.height;

    //final user_token = Provider.of<Token>(context);
    //return loading
    if (loading == true) {
      return Loading();
    } else {
      SizeConfig().init(context);
      //print("Email: $email, save:$_saveEmail");
      var children2 = <Widget>[
        Container(
          height: 80,
          width: 100,
          //color:Colors.blue,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(

              image: AssetImage(
                //'assets/WMR_40x40.png',
                'assets/WMR.png',
              ),
              fit: BoxFit.contain,
              
            ),
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(height: h1),
        Text(
          'Watch My Risk',
          style: white14Bold(),
        ),
        SizedBox(height: h2),

        showError(),
        showMessage(),
        //SizedBox(height: h2),
        // TextFormField(
        //   validator: NameValidator.validate,
        //   style: TextStyle(fontSize: 22.0),
        //   decoration: buildSignUpInputDecoration("Name"),
        //   onSaved: (value) => email = value,
        // ),

        // TextFormField(
        //   validator: EmailValidator.validate,
        //   style: TextStyle(fontSize: 22.0),
        //   //decoration: buildSignUpInputDecoration("Email"),
        //   onSaved: (value) => email = value,
        // ),

        TextFormField(
          initialValue: "demo@watchmyrisk.com",
          //initialValue: "test22@watchmyrisk.com",
          //initialValue: email,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'email',
          ),
          validator: (val) => val.isEmpty ? 'Enter an email' : null,
          onSaved: (value) => email = value,
          // onChanged: (val) {
          //   setState(() => email = val);
          // },
        ),

        showPassword(),
        //SizedBox(height: h5),
        showSubmit(),
        SizedBox(
          height: h3,
        ),
        //SizedBox(height:h3),
        //showForgotText(),
      ];
      return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          //child: ChangeNotifierProvider(
          //child: (
          //create: (context) => WmrProviders(),
          //create: (context) => Accounts(),
          child: Scaffold(
            //backgroundColor: Colors.brown[100],
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              centerTitle: true,
              // No Back Arrow
              titleSpacing: 0.0,
              automaticallyImplyLeading: true,
              //backgroundColor: Colors.lightBlueAccent[800],
              elevation: 0.0,
              
              title: 
                  Text(
                    "Demo account",
                    style: white14Bold(),
                  ),

              leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
              },
            ),
                  
              ),

              // actions: <Widget>[
              //   FlatButton.icon(
              //       icon: Icon(Icons.person),
              //       label: Text('Register'),
              //       //onPressed: () => widget.toggleView(),
              //       onPressed: () {
              //         Navigator.of(context).pushReplacementNamed('/sign_on');
              //       }),
              // ],
            
            //body: UpgradeAlert(
            //appcastConfig: cfg,
            //child: Container(
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: children2,
                  ),
                ),
              ),
            ),
          ));
    }
  }
}
