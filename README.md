# mind_chat

A Flutter-based AI companion app built as a hands-on learning project to explore 
Flutter/Dart development alongside practical AI integrations — chat, image generation, 
translation, and document intelligence, all in one app.

# Features
### AI ChatBot
A conversational chatbot powered by Google's Gemini (gemini-2.5-flash), with chat history, 
typing indicators, and a smooth animated UI.
### AI Image Creator
Generate images from text prompts using Hugging Face's Inference API with 
the FLUX.1-schnell model — completely free-tier friendly.
### Language Translator
Translate text between multiple languages using Gemini's language understanding, with auto-detect 
source language support and a clean swap-to-reverse UI.
### PDF & Images (Document Q&A)
Upload multiple PDFs and/or images simultaneously and ask questions about their content, powered 
by Gemini's multimodal capabilities.
### Light & Dark Theme
Full support for both light and dark UI modes, switchable from within the app.



# Getting Started

## Prerequisites
- Flutter SDK installed (flutter.dev/docs/get-started/install)
- A Google Gemini API key (aistudio.google.com)
- A Hugging Face access token (huggingface.co/settings/tokens)

## Installation
### 1. Clone the repo
- git clone https://github.com/Akib-10/mind_chat.git
- cd mind_chat
### 2. Install Dependencies
- flutter pub get
### 3. Set up environment variables
Create a .env file in the project root:
- GEMINI_API_KEY=your_gemini_api_key_here
  HF_API_KEY=your_huggingface_token_here
### 4. Run The App
- flutter run
## Notes
- Image generation uses Hugging Face's free-tier hf-inference provider — response times may vary 
slightly on first request due to model cold-starts.
- Gemini's free tier covers chat, translation, and 
document Q&A comfortably for personal/learning use.
- This project is a work in progress and primarily intended for educational purposes.

# License 
This project is open for learning and personal use. Feel free to fork and build on it.

# Author
Built by Arafat Akib as a hands-on Flutter learning project.



