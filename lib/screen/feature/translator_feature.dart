import 'package:flutter/material.dart';
import 'package:mind_chat/helper/global.dart';
import 'package:mind_chat/screen/feature/translator_service.dart';
import 'package:mind_chat/widget/custom_btn.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  static const List<String> _languages = [
    'Auto Detect',
    'English',
    'Bengali',
    'Hindi',
    'Arabic',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Urdu',
    'Russian',
    'Portuguese',
  ];

  String _fromLang = 'Auto Detect';
  String _toLang = 'English';

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _pickLanguage({required bool isFrom}) async {
    final options = isFrom
        ? _languages
        : _languages.where((l) => l != 'Auto Detect').toList();

    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: mq.height * .02),
          itemCount: options.length,
          itemBuilder: (context, index) {
            final lang = options[index];
            return ListTile(
              title: Text(lang, textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context, lang),
            );
          },
        );
      },
    );

    if (selected != null) {
      setState(() {
        if (isFrom) {
          _fromLang = selected;
        } else {
          _toLang = selected;
        }
      });
    }
  }

  void _swapLanguages() {
    if (_fromLang == 'Auto Detect') return; // nothing meaningful to swap into "From"
    setState(() {
      final temp = _fromLang;
      _fromLang = _toLang;
      _toLang = temp;
      // swap text too, if there's a result already
      if (_resultController.text.isNotEmpty) {
        final tempText = _inputController.text;
        _inputController.text = _resultController.text;
        _resultController.text = tempText;
      }
    });
  }

  Future<void> _translate() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await TranslatorService.translate(
        text: _inputController.text,
        fromLang: _fromLang,
        toLang: _toLang,
      );
      setState(() => _resultController.text = result);
    } catch (e) {
      setState(() => _errorMessage = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}