import 'package:admin_panel_web/core/constances/media_const.dart';
import 'package:admin_panel_web/core/theme/fonts/landk_fonts.dart';
import 'package:admin_panel_web/core/tools/tools_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/colors/landk_colors.dart';
import '../../../core/language/lang.dart';
import '../cubit/auth_cubit.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.isEmpty
                    ? 'Authentication Failure'
                    : state.errorMessage),
              ),
            );
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              color: organge,
              child: SvgPicture.asset(iLogo),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                vSpace(10),
                Text(
                  AppLocalizations.of(context)!.welcomeAdmin,
                  style: h3,
                ),
                Text(
                  AppLocalizations.of(context)!.enterYourEmailAndPassword,
                  style: h6,
                ),
                vSpace(5),
                const _Email(),
                vSpace(2),
                const _Password(),
                vSpace(5),
                const _SignInBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SignInBtn extends StatelessWidget {
  const _SignInBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<AuthCubit>().logInWithCredentials(),
          style: ButtonStyle(
            alignment: Alignment.center,
            minimumSize: MaterialStateProperty.all(
              Size(30.w, 10.h),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(organge),
          ),
          child: state.status == FormzSubmissionStatus.inProgress
              ? const Center(child: CircularProgressIndicator())
              : Text(
                  AppLocalizations.of(context)!.signIn,
                  style: btnFont,
                ),
        );
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.email != next.email,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            key: const Key('email-input'),
            onChanged: (email) => context.read<AuthCubit>().emailChanged(email),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              labelText: AppLocalizations.of(context)!.email,
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, next) => previous.password != next.password,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: TextField(
            keyboardType: TextInputType.visiblePassword,
            key: const Key('password-input'),
            onChanged: (password) =>
                context.read<AuthCubit>().passwordChanged(password),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.password),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              labelText: AppLocalizations.of(context)!.password,
              errorText: state.password.displayError != null
                  ? 'invalid password'
                  : null,
            ),
          ),
        );
      },
    );
  }
}
