import 'package:crafty_bay/data/model/create_profile_data.dart';
import 'package:crafty_bay/presentation/UI/screens/email_identification_screen.dart';
import 'package:crafty_bay/presentation/UI/widgets/bottom_popup_message.dart';
import 'package:crafty_bay/presentation/UI/widgets/button_loading_indicator.dart';
import 'package:crafty_bay/presentation/utils/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/state_holders/create_profile_controller.dart';
import '../widgets/app_logo.dart';

class SetProfile extends StatefulWidget {
  const SetProfile({super.key, required this.heading});
  final String heading;

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 10,
              left: 26,
              right: 26,
              bottom: 26),
          child: Form(
            key: _theFormKey,
            child: Column(
              children: [
                const AppLogo(logoSize: 110),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.heading,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Get started with us with your details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _tECFirstName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your first name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _tECLastName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your last name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _tECMobile,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly enter your phone number!';
                      } else if (InputValidator.phoneNumberValidator
                              .hasMatch(i) ==
                          false) {
                        return 'Please enter a valid phone number!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _tECCity,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your city name!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(hintText: 'City'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _tECShipping,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? i) {
                    if (i != null) {
                      if (i.trim().isEmpty) {
                        return 'Kindly share your shipping address!';
                      }
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(hintText: 'Shipping Address'),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CreateProfileController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.loading,
                      replacement: const ButtonLoadingIndicator(),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_theFormKey.currentState!.validate()) {
                            ReadProfileData profileData = ReadProfileData(
                              cusName: '${_tECFirstName.text} ${_tECLastName.text}',
                              cusPhone: _tECMobile.text,
                              cusCity: _tECCity.text,
                              shipAdd: _tECShipping.text,
                              shipCity: 'dummy',
                              shipCountry: 'dummy',
                              shipName: 'dummy',
                              shipPhone: _tECMobile.text,
                              shipPostcode: 'dummy',
                              shipState: _tECCity.text,
                              cusAdd: _tECShipping.text,
                              cusCountry: _tECShipping.text,
                              cusFax: 'dummy',
                              cusPostcode: 'dummy',
                              cusState: _tECShipping.text
                            );
                            bool created =await controller.createProfile(profileData);
                            if(created){
                              bottomPopUpMessage(context, 'Profile updated!');
                              Get.back();
                            }else{
                              bottomPopUpMessage(context, controller.errorMessage, showError: true);
                              Get.off(()=>const EmailIdentificationScreen());
                            }
                          }
                        },
                        child: Text(
                          'Completed',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------------------Functions---------------------------------------

  //---------------------------------------Variable----------------------------------------
  final GlobalKey<FormState> _theFormKey = GlobalKey<FormState>();
  final TextEditingController _tECFirstName = TextEditingController();
  final TextEditingController _tECLastName = TextEditingController();
  final TextEditingController _tECMobile = TextEditingController();
  final TextEditingController _tECCity = TextEditingController();
  final TextEditingController _tECShipping = TextEditingController();
}
