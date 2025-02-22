import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiUrl = "https://models.github.ai/inference/chat/completions";
  final String _apiKey =
      "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"; // Replace with your key

  Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": userMessage}
          ],
          "model": "gpt-4o-mini",
          "temperature": 1,
          "max_tokens": 4096,
          "top_p": 1
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Failed to connect. Error: $e";
    }
  }
}
