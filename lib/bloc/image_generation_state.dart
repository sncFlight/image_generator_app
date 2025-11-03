import 'package:equatable/equatable.dart';

abstract class ImageGenerationState extends Equatable {
  const ImageGenerationState();

  @override
  List<Object?> get props => [];
}

class ImageGenerationInitial extends ImageGenerationState {
  const ImageGenerationInitial();
}

class ImageGenerationLoading extends ImageGenerationState {
  final String prompt;

  const ImageGenerationLoading(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

class ImageGenerationSuccess extends ImageGenerationState {
  final String imageUrl;
  final String prompt;

  const ImageGenerationSuccess({
    required this.imageUrl,
    required this.prompt,
  });

  @override
  List<Object?> get props => [imageUrl, prompt];
}

class ImageGenerationError extends ImageGenerationState {
  final String message;
  final String prompt;

  const ImageGenerationError({
    required this.message,
    required this.prompt,
  });

  @override
  List<Object?> get props => [message, prompt];
}
