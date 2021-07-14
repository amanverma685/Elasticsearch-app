import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> requestBertModel(
    String questionContext, String inputQuery) async {
  var headers = {
    'Prefer': 'respond-async, wait=59',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEtc3RnMS1rZXktMS5jZXIifQ.eyJpZCI6IjE2MjYyNDg4MTc4NjhfNDFmYzU2MjctNGQ3MS00OGFhLWI4OWMtMzVhZmFiOGU3YTMzX3VlMSIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJjcGZfcGVuX3Rlc3QiLCJ1c2VyX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJhcyI6Imltcy1uYTEtc3RnMSIsImFhX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJwYWMiOiJjcGZfcGVuX3Rlc3Rfc3RnIiwicnRpZCI6IjE2MjYyNDg4MTc4NjhfMWU4OWEyYWUtOTJmOS00M2Q0LWE5MjAtZTA3NTZhYmJhMzk1X3VlMSIsIm1vaSI6ImE0MDQ5YzI1IiwicnRlYSI6IjE2Mjc0NTg0MTc4NjgiLCJleHBpcmVzX2luIjoiODY0MDAwMDAiLCJzY29wZSI6InN5c3RlbSIsImNyZWF0ZWRfYXQiOiIxNjI2MjQ4ODE3ODY4In0.eUklcPsvxIjNz2A68xdVc5rH6-xir-wFIPKHwy4mvCQtPrk-UFD-Fna-XURKyZ_xwOdlLQNLtW1h7x-bwgybsrWu5qWRknhKjHHLxod5xAmcIra48LBAJXe8qlCY0Wea30rV-fnJUk0mCYAN5rD7DMG2E7avff--y8vnPS1lJTdKMcCHN7OxGIg0S2bu-nleaiyMdP2Ob7RdxGkcwniWz5xG_6Bck0FqAADJIH9Iq35iBBFHY1Qasax2dTN-8xq-eID2NYhF1vBvNX517UIhbGeXWglr70wrY-uo8PSHC2FVRMHY7rq1qOVK-3H4nNIZN3rxV90weE0-BCf4YAjOVQ',
    'x-api-key': 'AdobeSenseiPredictServiceStageKey'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://senseicore-stage-ue1.adobe.io/sensei-core/v2/predict?outputName=output&nonMultipart=true'));
  request.fields.addAll({
    'contentAnalyzerRequests':
        '{\n  "sensei:name": "jqgnsdmeg4r",\n  "sensei:invocation_mode": "asynchronous",\n  "sensei:invocation_batch": false,\n  "sensei:in_response": false,\n  "sensei:engines": [\n    {\n      "sensei:execution_info": {\n        "sensei:engine": "Feature:document-question-answering:Service-470f01fe55094f5e86bfec96c091baac"\n      },\n      "sensei:inputs": {\n        "dummy": {"dc:format":"application/json","sensei:multipart_field_name":"infile"}\n      },\n      "sensei:params": {\n        "question": "' +
            inputQuery +
            '",\n        "text": "' +
            questionContext +
            '"\n      },\n      "sensei:outputs": {\n        "output": {\n          "dc:format": "application/json",\n          "sensei:multipart_field_name": "outputfield"\n        }\n      }\n    }\n  ]\n}',
    'infile': 'abc'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var body = await response.stream.bytesToString();
    var responseBody = json.decode(body);
    String queryAnswer = responseBody['features'][0]['feature_value'];
    print(queryAnswer);
    return queryAnswer;
  } else {
    print(response.reasonPhrase);
    return "Answer Not Found";
  }
}
