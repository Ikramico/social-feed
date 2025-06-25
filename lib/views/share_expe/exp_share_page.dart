import 'package:feed/views/share_expe/widgets/custom_button.dart';
import 'package:feed/views/share_expe/widgets/custom_dropdown.dart';
import 'package:feed/views/share_expe/widgets/datepicker.dart';
import 'package:feed/views/share_expe/widgets/header.dart';
import 'package:feed/views/share_expe/widgets/image_upload.dart';
import 'package:feed/views/share_expe/widgets/message_text_field.dart';
import 'package:feed/views/share_expe/widgets/rating.dart';
import 'package:flutter/material.dart';


class ShareExperiencePage extends StatefulWidget {
  const ShareExperiencePage({super.key});

  @override
  State<ShareExperiencePage> createState() => _ShareExperiencePageState();
}

class _ShareExperiencePageState extends State<ShareExperiencePage> {
  String? selectedDepartureAirport;
  String? selectedArrivalAirport;
  String? selectedAirline;
  String? selectedClass;
  DateTime? selectedDate;
  int rating = 0;
  final TextEditingController messageController = TextEditingController();

  final List<String> classOptions = [
    'Any',
    'Business',
    'First',
    'Premium Economy',
    'Economy',
  ];

  final List<String> departureAirports = [
    'JFK - John F. Kennedy International',
    'LAX - Los Angeles International',
    'DXB - Dubai International',
  ];

  final List<String> arrivalAirports = [
    'LHR - London Heathrow',
    'CDG - Charles de Gaulle',
    'NRT - Tokyo Narita',
  ];

  final List<String> airlines = [
    'Emirates',
    'Qatar Airways',
    'Singapore Airlines',
    'Lufthansa',
  ];

  void _handleImageUpload() {
    // Handle image upload logic here
    print('Image upload tapped');
  }

  void _handleSubmit() {
    // Handle form submission logic here
    print('Form submitted');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShareExperienceHeaderWidget(
                title: 'Share',
                onClose: () => Navigator.pop(context),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ImageUploadWidget(onTap: _handleImageUpload),

                    const SizedBox(height: 20),

                    CustomDropdownWidget(
                      label: 'Departure Airport',
                      selectedValue: selectedDepartureAirport,
                      options: departureAirports,
                      onChanged: (value) =>
                          setState(() => selectedDepartureAirport = value),
                    ),

                    const SizedBox(height: 16),

                    CustomDropdownWidget(
                      label: 'Arrival Airport',
                      selectedValue: selectedArrivalAirport,
                      options: arrivalAirports,
                      onChanged: (value) =>
                          setState(() => selectedArrivalAirport = value),
                    ),

                    const SizedBox(height: 16),

                    CustomDropdownWidget(
                      label: 'Airline',
                      selectedValue: selectedAirline,
                      options: airlines,
                      onChanged: (value) =>
                          setState(() => selectedAirline = value),
                    ),

                    const SizedBox(height: 16),

                    CustomDropdownWidget(
                      label: 'Class',
                      selectedValue: selectedClass,
                      options: classOptions,
                      onChanged: (value) =>
                          setState(() => selectedClass = value),
                    ),

                    const SizedBox(height: 20),

                    MessageTextFieldWidget(
                      controller: messageController,
                      hintText: 'Write your message',
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: DatePickerWidget(
                            selectedDate: selectedDate,
                            onDateSelected: (date) =>
                                setState(() => selectedDate = date),
                            placeholder: 'Travel Date',
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: StarRatingWidget(
                            rating: rating,
                            onRatingChanged: (newRating) =>
                                setState(() => rating = newRating),
                            label: 'Rating',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    CustomElevatedButtonWidget(
                      text: 'Submit',
                      onPressed: _handleSubmit,
                      width: 200,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
