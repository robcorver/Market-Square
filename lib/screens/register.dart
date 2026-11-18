import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:market_square/models/request_model.dart';
import 'package:market_square/screens/terms_and_conditions.dart';
import 'package:market_square/screens/privacy_policy.dart';
import 'package:market_square/services/real_property_service.dart';
import 'package:market_square/services/fake_property_service.dart';
import 'package:market_square/services/property_service.dart';
import 'package:market_square/services/request_service.dart';
import 'package:market_square/services/fake_request_service.dart';
import 'package:market_square/models/fetch_outcome.dart';
import 'package:market_square/routes/route.dart';
import 'package:email_validator/email_validator.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // State objects
  bool isLoading = false;
  String? onScreenMessage;
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PropertyService propertyService = RealPropertyService();
  List<DropdownMenuEntry<String>> buildingsList = [];
  String? selectedBuildingId;
  List<DropdownMenuEntry<String>> unitList = [];
  String? selectedUnitId;
  final RequestService requestService = FakeRequestService();
  bool acceptedTerms = false;
  final TapGestureRecognizer termsRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer privacyRecognizer = TapGestureRecognizer();

  // Generate on-screen message
  String messageFor(SubmissionOutcome outcome) {
    switch (outcome) {
      case SubmissionOutcome.error:
        return 'Something went wrong on our side, try again later';

      case SubmissionOutcome.invalid:
        return 'Form not accepted, please review inputs';

      case SubmissionOutcome.accepted:
        return "Form submitted, you'll receive an email once it's been reviewed";
    }
  }

  // Fetch all buildings
  void loadBuildings() async {
    final allBuildings = await propertyService.getBuildings();

    if (!mounted) return;

    // Parse output
    switch (allBuildings.outcome) {
      // Error - Update error message
      case FetchOutcome.error:
        setState(() {
          onScreenMessage = 'Something went wrong on our side, try again later';
        });

      // Success - Unpack buildings and add to dropdown
      case FetchOutcome.success:
        setState(() {
          buildingsList = allBuildings.buildings
              .map(
                (building) => DropdownMenuEntry(
                  label: (building.name + (', ') + (building.address)),
                  value: building.id,
                ),
              )
              .toList();
        });
    }
  }

  // Fetch units for selected building
  void loadUnits(String buildingId) async {
    final buildingUnits = await propertyService.getUnits(buildingId);

    if (!mounted) return;

    // Parse output
    switch (buildingUnits.outcome) {
      case FetchOutcome.error:
        setState(() {
          onScreenMessage = 'Something went wrong on our side, try again later';
        });

      case FetchOutcome.success:
        setState(() {
          unitList = buildingUnits.units
              .map(
                (unit) =>
                    DropdownMenuEntry(label: unit.aptNumber, value: unit.id),
              )
              .toList();
        });
    }
  }

  @override
  void initState() {
    super.initState();
    loadBuildings();
    termsRecognizer.onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => TermsAndConditions(),
        ),
      );
    };
    privacyRecognizer.onTap = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => PrivacyPolicy(),
        ),
      );
    };
  }

  @override
  void dispose() {
    lastNameController.dispose();
    emailController.dispose();
    termsRecognizer.dispose();
    privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? invalidEmailError =
        (emailController.text.trim().isNotEmpty &&
            (!EmailValidator.validate(emailController.text.trim()))
        ? 'Invalid email address'
        : null);

    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10.0,
            children: [
              // Intro Text
              Text(
                "You'll need approval from your property manager first - only takes a sec to complete",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              if (onScreenMessage != null)
                Container(
                  padding: EdgeInsets.all(5.0),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Text(
                    '$onScreenMessage',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .errorContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Form Fields
              Text(
                'Last Name',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: lastNameController,
                onChanged: (value) {
                  setState(() {});
                },
              ),

              Text(
                'Email Address',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  errorText: invalidEmailError,
                ),
              ),

              Text(
                'Building',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              DropdownMenu<String>(
                hintText: 'select your building',
                width: 300.0,
                dropdownMenuEntries: buildingsList,
                onSelected: (value) {
                  if (value == null || value == selectedBuildingId) return;

                  loadUnits(value);
                  setState(() {
                    selectedUnitId = null;
                    unitList = [];
                    selectedBuildingId = value;
                  });
                },
              ),

              Text(
                'Apartment Unit',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              DropdownMenu<String>(
                key: ValueKey(selectedBuildingId),
                enabled: (selectedBuildingId != null),
                hintText: 'select your unit',
                width: 300.0,
                dropdownMenuEntries: unitList,
                onSelected: (value) {
                  setState(() {
                    selectedUnitId = value;
                  });
                },
              ),

              CheckboxListTile(
                value: acceptedTerms,
                onChanged: (bool? value) {
                  setState(() {
                    acceptedTerms = value!;
                  });
                },
                title: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(text: 'Accept '),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(decoration: TextDecoration.underline),
                        recognizer: termsRecognizer,
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(decoration: TextDecoration.underline),
                        recognizer: privacyRecognizer,
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              FilledButton(
                onPressed:
                    (lastNameController.text.trim().isEmpty ||
                        !EmailValidator.validate(emailController.text.trim()) ||
                        selectedBuildingId == null ||
                        selectedUnitId == null ||
                        !acceptedTerms ||
                        isLoading)
                    ? null
                    : () async {
                        // Guard: stop if no building or unit are selected
                        final buildingId = selectedBuildingId;
                        final unitId = selectedUnitId;
                        if (buildingId == null || unitId == null) {
                          debugPrint('Submit tapped without building or apt');
                          return;
                        }

                        setState(() {
                          isLoading = true;
                          onScreenMessage = null;
                        });

                        // Make call
                        NewTenantRequestModel request = NewTenantRequestModel(
                          lastName: lastNameController.text,
                          emailAddress: emailController.text,
                          buildingId: buildingId,
                          unitId: unitId,
                        );

                        final outcome = await requestService.submitRegistration(
                          request,
                        );

                        // if no longer on screen
                        if (!mounted) return;

                        // Process Result
                        if (outcome == SubmissionOutcome.accepted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.registerSuccess,
                            ModalRoute.withName(AppRoutes.welcome),
                          );
                        } else {
                          setState(() {
                            isLoading = false;
                            onScreenMessage = messageFor(outcome);
                          });
                        }
                      },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
