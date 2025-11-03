import 'dart:math';

class MockApiService {
  final Random _random = Random();

  Future<String> generate(String prompt) async {
    await Future.delayed(Duration(milliseconds: 2000 + _random.nextInt(1000)));

    // ~50% chance of error
    if (_random.nextBool()) {
      throw Exception('Generation failed');
    }

    // Return placeholder image
    return 'assets/images/test_image.jpg';
  }
}
