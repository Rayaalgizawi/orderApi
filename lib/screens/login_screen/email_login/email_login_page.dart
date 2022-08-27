import 'package:beauty_pariour2/screens/loginFirstScreen/login_first_step_screen.dart';
import 'package:beauty_pariour2/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'email_login_bloc.dart';

class EmaillogininPage extends StatefulWidget {
  const EmaillogininPage({Key? key}) : super(key: key);

//rayaalgizawi@gmail.com
//password roro_96
  @override
  State<EmaillogininPage> createState() => _EmaillogininPageState();
}

class _EmaillogininPageState extends State<EmaillogininPage> {
  final bloc = Emailoginbloc();
  bool showSpinner = false;
  @override
  void dispose() {
    bloc.emailController.dispose();
    bloc.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beauty Cosmetics'),
          backgroundColor: const Color(0xffde5d83),
          centerTitle: true,
        ),
        body: showSpinner
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/signup.svg"),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: bloc.emailController,
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: bloc.passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Enter your password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user =
                                await firebaseauth.signInWithEmailAndPassword(
                                    email: bloc.emailController.text,
                                    password: bloc.passwordController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const LoginFirstStepScreen();
                              }),
                            );
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        child: const Text(
                          'Login ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void signInWithEmailAndPassword() async {
    final user = (await firebaseauth.signInWithEmailAndPassword(
      email: bloc.emailController.text,
      password: bloc.passwordController.text,
    ))
        .user;

    if (user != null) {
      var email = user.email;
      print(email);
    } else {
      print("object");
    }
  }
}
