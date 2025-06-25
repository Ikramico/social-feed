
import 'package:dotted_border/dotted_border.dart';
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
  String? selectedClass ;
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Share',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                  DottedBorder(
  options: RectDottedBorderOptions(
    strokeWidth: 1,
    dashPattern: [6, 3],
    color: const Color.fromARGB(255, 209, 209, 230) 
  ),
  child: Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xFFF8F8FF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('lib/assets/images/image-upload.png'),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
            children: [
              const TextSpan(
                text: 'Drop Your Image Here Or ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700
                )
              ),
              TextSpan(
                text: 'Browse',
                style: TextStyle(
                  color:const Color(0xFF364AFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF364AFF)
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),
  const SizedBox(height: 20),

                    _buildDropdownField(
                      'Departure Airport',
                      selectedDepartureAirport,
                      [
                        'JFK - John F. Kennedy International',
                        'LAX - Los Angeles International',
                        'DXB - Dubai International',
                      ],
                      (value) =>
                          setState(() => selectedDepartureAirport = value),
                    ),

                    const SizedBox(height: 16),

                    _buildDropdownField(
                      'Arrival Airport',
                      selectedArrivalAirport,
                      [
                        'LHR - London Heathrow',
                        'CDG - Charles de Gaulle',
                        'NRT - Tokyo Narita',
                      ],
                      (value) => setState(() => selectedArrivalAirport = value),
                    ),

                    const SizedBox(height: 16),

                    // Airline Dropdown
                    _buildDropdownField(
                      'Airline',
                      selectedAirline,
                      [
                        'Emirates',
                        'Qatar Airways',
                        'Singapore Airlines',
                        'Lufthansa',
                      ],
                      (value) => setState(() => selectedAirline = value),
                    ),

                    const SizedBox(height: 16),

                    // Class Dropdown
                    _buildDropdownField(
                      'Class',
                      selectedClass,
                      classOptions,
                      (value) => setState(() => selectedClass = value),
                    ),

                    const SizedBox(height: 20),

                    // Message Text Field
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,
                         color: Colors.grey[300]!
                         ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                          hintText: 'Write your message',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Travel Date and Rating Row
                    Row(
                      children: [
                        // Travel Date
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() => selectedDate = date);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedDate != null
                                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                        : 'Travel Date',
                                    style: TextStyle(
                                      color: selectedDate != null
                                          ? Colors.black
                                          : Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Rating
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                children: List.generate(5, (index) {
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => rating = index + 1),
                                    child: Icon(
                                      Icons.star,
                                      color: index < rating
                                          ? Colors.amber
                                          : Colors.grey.shade300,
                                      size: 24,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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

  Widget _buildDropdownField(
    String label,
    String? selectedValue,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
