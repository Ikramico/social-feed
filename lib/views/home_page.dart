import 'package:feed/controller/review_controller.dart';
import 'package:feed/widgets/action_button.dart';
import 'package:feed/widgets/review/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ReviewController reviewController = Get.find<ReviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Airline Review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ActionButtons(),
          Expanded(
            child: Obx(() {
              if (reviewController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount:
                    reviewController.reviews.length + 1, // +1 for the banner
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // First item is the banner
                    return Column(
                      children: [
                        _buildQatarBanner(),
                        const SizedBox(height: 25),
                      ],
                    );
                  }

                  // Subtract 1 from index since banner takes index 0
                  final review = reviewController.reviews[index - 1];
                  return ReviewCard(review: review);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildQatarBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'lib/assets/images/image 8.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit
              .cover, // This ensures the image covers the entire container
        ),
      ),
    );
  }
}
