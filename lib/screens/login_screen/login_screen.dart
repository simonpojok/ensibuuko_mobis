import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mobis/screens/login_error_screen/login_error_screen.dart';
import 'package:mobis/screens/login_screen/login_screen_cubit.dart';

class LoginScreen extends StatefulWidget {
  static const path = "login-screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'UG';
  PhoneNumber number = PhoneNumber(isoCode: 'UG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocListener<LoginScreenCubit, LoginScreenState>(
            listener: (context, state) {
              if (state is LoginScreenSuccess) {
                context.go('/');
              } else if (state is LoginScreenError) {
                context.go(
                    '/welcome-screen/${LoginScreen.path}/${LoginErrorScreen.path}');
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You need to have an existing account',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: _formKey,
                    child: InternationalPhoneNumberInput(
                      spaceBetweenSelectorAndTextField: 0,
                      formatInput: false,
                      onInputChanged: (PhoneNumber number) {},
                      onInputValidated: (bool value) {},
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                        showFlags: true,
                        leadingPadding: 0,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                        decimal: true,
                      ),
                      inputBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      onSaved: (PhoneNumber number) {
                        context
                            .read<LoginScreenCubit>()
                            .loginUserWithPhoneNumber(number.phoneNumber ?? '');
                      },
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                    },
                    child: const Text('Submit'),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
