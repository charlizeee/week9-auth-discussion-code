import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/userdata_model.dart';
import '../providers/userdata_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    final firstName = TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Input Required';
        }
      },
    );

    final lastName = TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Input Required';
        }
      },
    );

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
        return 'Please enter a valid email address';
        }
        return null;
      },
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } 
        if(value.length < 6){
          return 'Password must be at least 6 characters!';
        }
        return null;
      },
    );

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            _formKey.currentState!.save();  

            userData user = userData(
              null, 
              firstNameController.text, 
              lastNameController.text, 
              emailController.text
            );
            context.read<userDataProvider>().addItem(user);
            //added
            await context
                .read<MyAuthProvider>()
                .signUp(emailController.text, passwordController.text);
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget form(){
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
            firstName, 
            lastName,
            email,
            password,
            ],
          ),
        )
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            form(),
            SignupButton,
            backButton
          ],
        ),
      ),
    );
  }
}
