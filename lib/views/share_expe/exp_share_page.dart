import 'package:feed/controller/review_controller.dart';
import 'package:feed/views/share_expe/widgets/custom_button.dart';
import 'package:feed/views/share_expe/widgets/custom_dropdown.dart';
import 'package:feed/views/share_expe/widgets/datepicker.dart';
import 'package:feed/views/share_expe/widgets/header.dart';
import 'package:feed/views/share_expe/widgets/image_upload.dart';
import 'package:feed/views/share_expe/widgets/message_text_field.dart';
import 'package:feed/views/share_expe/widgets/rating.dart';
import 'package:feed/views/share_expe/widgets/search_airport_dropdown.dart';
import 'package:feed/models/airport_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareExperiencePage extends StatefulWidget {
  const ShareExperiencePage({super.key});

  @override
  State<ShareExperiencePage> createState() => _ShareExperiencePageState();
}

class _ShareExperiencePageState extends State<ShareExperiencePage> {
  final ReviewController reviewController = Get.find<ReviewController>();

  Airport? selectedDepartureAirport;
  Airport? selectedArrivalAirport;
  String? selectedAirline;
  String? selectedClass;
  DateTime? selectedDate;
  int rating = 0;
  String? uploadedImageUrl;
  final TextEditingController messageController = TextEditingController();

  bool isSubmitting = false;

  final List<String> classOptions = [
    'Economy',
    'Premium Economy',
    'Business',
    'First',
  ];

  final List<String> airlines = [
    'Emirates',
    'Qatar Airways',
    'Singapore Airlines',
    'Lufthansa',
    'British Airways',
    'Air France',
    'KLM',
    'Swiss International Air Lines',
    'Turkish Airlines',
    'Etihad Airways',
    'Cathay Pacific',
    'Japan Airlines',
    'ANA (All Nippon Airways)',
    'Korean Air',
    'Thai Airways',
    'Malaysia Airlines',
    'United Airlines',
    'American Airlines',
    'Delta Air Lines',
    'Air Canada',
    'Virgin Atlantic',
    'Qantas',
    'Air New Zealand',
    'Scandinavian Airlines',
    'Finnair',
    'Austrian Airlines',
    'Brussels Airlines',
    'TAP Air Portugal',
    'Aeroflot',
    'China Eastern Airlines',
    'China Southern Airlines',
    'Air China',
    'Asiana Airlines',
    'EVA Air',
    'Garuda Indonesia',
    'Philippine Airlines',
    'Vietnam Airlines',
    'Air India',
    'IndiGo',
    'SpiceJet',
    'Vistara',
  ];

  void _handleImageUpload() {
    // Handle image upload logic here
    // For now, we'll simulate an uploaded image URL
    setState(() {
      uploadedImageUrl =
          'https://images.unsplash.com/photo-1556388158-158ea5ccacbd?w=400&h=300&fit=crop';
    });

    Get.snackbar(
      'Image Uploaded',
      'Image has been uploaded successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    print('Image upload tapped - URL: $uploadedImageUrl');
  }

  Future<void> _handleSubmit() async {
    // Validate form
    if (selectedDepartureAirport == null) {
      _showErrorSnackbar('Please select a departure airport');
      return;
    }
    if (selectedArrivalAirport == null) {
      _showErrorSnackbar('Please select an arrival airport');
      return;
    }
    if (selectedDepartureAirport!.iata == selectedArrivalAirport!.iata) {
      _showErrorSnackbar('Departure and arrival airports cannot be the same');
      return;
    }
    if (selectedAirline == null) {
      _showErrorSnackbar('Please select an airline');
      return;
    }
    if (selectedClass == null) {
      _showErrorSnackbar('Please select a class');
      return;
    }
    if (selectedDate == null) {
      _showErrorSnackbar('Please select a travel date');
      return;
    }
    if (rating == 0) {
      _showErrorSnackbar('Please provide a rating');
      return;
    }
    if (messageController.text.trim().isEmpty) {
      _showErrorSnackbar('Please write a message about your experience');
      return;
    }
    if (messageController.text.trim().length < 10) {
      _showErrorSnackbar(
        'Please write a more detailed message (at least 10 characters)',
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      // Add the review using the controller
      await reviewController.addNewReview(
        departureAirport: selectedDepartureAirport!,
        arrivalAirport: selectedArrivalAirport!,
        airline: selectedAirline!,
        travelClass: selectedClass!,
        travelDate: selectedDate!,
        rating: rating,
        reviewText: messageController.text.trim(),
        imageUrl: uploadedImageUrl,
        // You can add user info here if you have user management
        userName: 'Current User', // Replace with actual user name
        userAvatar:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face', // Replace with actual user avatar
      );

      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      _showErrorSnackbar('Failed to submit review. Please try again.');
      print('Error submitting review: $e');
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Required Field',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Success!'),
            ],
          ),
          content: const Text(
            'Your flight experience has been shared successfully! It will now appear in your feed.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close share experience page
                // Optionally navigate to feed page
                // Get.toNamed('/feed');
              },
              child: const Text('View Feed'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _resetForm(); // Reset form for new entry
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('Share Another'),
            ),
          ],
        );
      },
    );
  }

  void _resetForm() {
    setState(() {
      selectedDepartureAirport = null;
      selectedArrivalAirport = null;
      selectedAirline = null;
      selectedClass = null;
      selectedDate = null;
      rating = 0;
      uploadedImageUrl = null;
      messageController.clear();
    });
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
                title: 'Share Experience',
                onClose: () => Navigator.pop(context),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      ImageUploadWidget(onTap: _handleImageUpload),

                      if (uploadedImageUrl != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'Image uploaded successfully',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      SearchableAirportDropdown(
                        label: 'Departure Airport',
                        selectedAirport: selectedDepartureAirport,
                        onChanged: (airport) =>
                            setState(() => selectedDepartureAirport = airport),
                      ),

                      const SizedBox(height: 16),

                      SearchableAirportDropdown(
                        label: 'Arrival Airport',
                        selectedAirport: selectedArrivalAirport,
                        onChanged: (airport) =>
                            setState(() => selectedArrivalAirport = airport),
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
                        hintText:
                            'Write your message about the flight experience...',
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
                        text: isSubmitting
                            ? 'Submitting...'
                            : 'Submit',
                        onPressed: _handleSubmit,
                        width: 200,
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
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
