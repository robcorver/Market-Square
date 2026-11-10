import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_square/routes/route.dart';
import 'package:market_square/services/auth_service.dart';
import 'package:market_square/services/fake_auth_service.dart';

class SignInScreen extends StatefulWidget{
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen>{
  bool isLoading = false;
  String? errorMessage;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = FakeAuthService();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? messageFor(SignInOutcome outcome) {
  switch (outcome) {
    case SignInOutcome.error:
      return 'Something went wrong on our end, please try again later';
    case SignInOutcome.invalidCredentials:
      return 'Incorrect email or password, try again';
    case SignInOutcome.accountSuspended:
      return 'Account suspended, contact the Administrator';
    case SignInOutcome.signedIn:
      return null;
  }
}

@override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: SvgPicture.asset(
            'assets/logo_horizontal_dark.svg',
            fit: BoxFit.contain),
        ),
        toolbarHeight: 100,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer (flex: 1),

            // Welcome message
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
              ),
            
            // Error Message (if available)
            if(errorMessage != null)
              Container(
                padding: EdgeInsets.all(5.0),
                color: Theme.of(context).colorScheme.errorContainer,
                child: Text(
                  '$errorMessage',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error, backgroundColor: Theme.of(context).colorScheme.errorContainer), 
                  textAlign: TextAlign.center,
                  ),
                ),
        
            // Form Input fields
            Text ('Email Address',
            style: Theme.of(context).textTheme.bodyLarge),
            TextField(
              controller: emailController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          
            Text ('Password',
            style: Theme.of(context).textTheme.bodyLarge),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                setState(() {});
              },
              obscureText: true,
            ),
          
            // Button Section
            FilledButton(
              onPressed: (emailController.text.isEmpty || passwordController.text.isEmpty || isLoading) 
                ? null
                : () async {
                  // set initial condition
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                  });

                  // make network call
                  final result = await authService.signIn(
                    emailController.text, passwordController.text);               
                  
                  // Unpack return and update screen
                  /// If no longer on screen:
                  if (!mounted) return;

                  /// If successful, navigate to home screen
                  if (result.outcome == SignInOutcome.signedIn) {
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home,
                    (route) => false,
                    );
                    return;
                  }

                  /// Error handling:
                  setState((){
                    isLoading = false;
                    errorMessage = messageFor(result.outcome);
                  });
                },
              child: Text('Sign In'),
            ),

            OutlinedButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                },
                child: Text('Cancel'),
                ),

          Spacer (flex: 2),

          // Navigation to Registration Page
          Row(
            children: [
              Text('New here? ',
                style: Theme.of(context).textTheme.bodyLarge),
                TextButton(
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                child: Text('Create an account',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}