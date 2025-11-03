import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/mock_api_service.dart';

import 'image_generation_event.dart';
import 'image_generation_state.dart';

class ImageGenerationBloc
    extends Bloc<ImageGenerationEvent, ImageGenerationState> {
  final MockApiService apiService;
  String _currentPrompt = '';

  ImageGenerationBloc(this.apiService) : super(const ImageGenerationInitial()) {
    on<GenerateImageEvent>(_onGenerateImage);
    on<RegenerateImageEvent>(_onRegenerateImage);
    on<RetryGenerationEvent>(_onRetryGeneration);
  }

  Future<void> _onGenerateImage(
    GenerateImageEvent event,
    Emitter<ImageGenerationState> emit,
  ) async {
    _currentPrompt = event.prompt;
    
    await _performGeneration(emit);
  }

  Future<void> _onRegenerateImage(
    RegenerateImageEvent event,
    Emitter<ImageGenerationState> emit,
  ) async {
    await _performGeneration(emit);
  }

  Future<void> _onRetryGeneration(
    RetryGenerationEvent event,
    Emitter<ImageGenerationState> emit,
  ) async {
    await _performGeneration(emit);
  }

  Future<void> _performGeneration(Emitter<ImageGenerationState> emit) async {
    emit(ImageGenerationLoading(_currentPrompt));

    try {
      final imageUrl = await apiService.generate(_currentPrompt);
      emit(ImageGenerationSuccess(imageUrl: imageUrl, prompt: _currentPrompt));
    } catch (e) {
      emit(ImageGenerationError(
        message: 'Failed to generate image. Please try again.',
        prompt: _currentPrompt,
      ));
    }
  }
}
