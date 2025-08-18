import 'package:clima_app/features/ia/data/datasources/ia_datasource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openai_dart/openai_dart.dart';

class IADatasourceImpl implements IADatasource {


  @override
  Future<List<String?>> generateText({required prompt}) async {

    final model = dotenv.env["OPENIA_MODEL"];
    final openaiApiKey = dotenv.env["OPENIA_KEY"];

    final openAiClient = OpenAIClient(apiKey: openaiApiKey);

    final response = await openAiClient.createChatCompletion(
        request: CreateChatCompletionRequest(
          model: ChatCompletionModel.modelId('$model'),
          messages: [
            const ChatCompletionMessage.system(
              content: 'Responde únicamente con la información solicitada. No agregues saludos, despedidas ni comentarios adicionales. Formatea la respuesta lista para mostrar a un usuario final.',
            ),
            ChatCompletionMessage.user(
              content: ChatCompletionUserMessageContent.string('$prompt'),
            ),
          ],
        )
    );

    final choices =  response.choices.map((element) => element.message.content).toList();

    return choices;
  }
}