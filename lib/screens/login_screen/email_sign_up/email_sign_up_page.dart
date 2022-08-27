import 'package:beauty_pariour2/screens/loginFirstScreen/login_first_step_screen.dart';
import 'package:beauty_pariour2/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../email_login/email_login_page.dart';
import 'email_sin_up_bloc.dart';

class EmailSignUpPage extends StatefulWidget {
  const EmailSignUpPage({Key? key}) : super(key: key);

  @override
  State<EmailSignUpPage> createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  final bloc = Emailsinupbloc();
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
        backgroundColor: const Color.fromARGB(255, 244, 97, 166),
        body: showSpinner
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Form(
                  key: bloc.formKey,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 35, top: 30),
                        child: const Text(
                          'Create\nAccount',
                          style: TextStyle(color: Colors.white, fontSize: 33),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.28),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 35, right: 35),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: bloc.emailController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Colors.pink,
                                          ),
                                        ),
                                        hintText: "Please Enter Email",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      controller: bloc.passwordController,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Colors.pink,
                                            ),
                                          ),
                                          hintText: "Please Enter Password",
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              const Color(0xff4c505b),
                                          child: IconButton(
                                            color: Colors.white,
                                            onPressed: () async {
                                              if (bloc.formKey.currentState!
                                                  .validate()) {
                                                _register();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Enter Your Email & password")));
                                              }
                                              setState(() {
                                                showSpinner = false;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Have an account?",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EmaillogininPage(),
                                                ));
                                          },
                                          child: const Text(
                                            " Sign In",
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(bloc.success == null
                                    ? ''
                                    : (bloc.success!
                                        ? 'Successfully registered ${bloc.userEmail!}'
                                        : 'Registration failed?')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _register() async {
    final user = (await firebaseauth.createUserWithEmailAndPassword(
      email: bloc.emailController.text,
      password: bloc.passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        bloc.success = true;
        bloc.userEmail = user.email;
        setState(() {
          showSpinner = true;
        });
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return const LoginFirstStepScreen();
        }),
      );
    } else {
      setState(() {
        bloc.success = true;
        showSpinner = false;
      });
    }
  }
}
