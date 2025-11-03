import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/image_generation_bloc.dart';
import '../bloc/image_generation_event.dart';
import '../bloc/image_generation_state.dart';
import '../widgets/gradient_button.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  late final TextEditingController _controller;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    // Restore previous prompt if available
    final state = context.read<ImageGenerationBloc>().state;
    if (state is ImageGenerationSuccess || state is ImageGenerationError) {
      _controller.text = state is ImageGenerationSuccess
          ? state.prompt
          : (state as ImageGenerationError).prompt;
      _isButtonEnabled = _controller.text.trim().isNotEmpty;
    }

    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final isEmpty = _controller.text.trim().isEmpty;
    if (_isButtonEnabled == isEmpty) {
      setState(() {
        _isButtonEnabled = !isEmpty;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGenerate() {
    if (_controller.text.trim().isNotEmpty) {
      context.read<ImageGenerationBloc>().add(
            GenerateImageEvent(_controller.text.trim()),
          );
      context.push('/result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Header
              Text(
                'Magic Image',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 2),

              // Input Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe what you want to see...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                  onSubmitted: (_) => _isButtonEnabled ? _onGenerate() : null,
                ),
              ),

              const Spacer(flex: 2),

              // Generate Button
              GradientButton(
                onPressed: _isButtonEnabled ? _onGenerate : null,
                text: 'Generate',
                isEnabled: _isButtonEnabled,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
