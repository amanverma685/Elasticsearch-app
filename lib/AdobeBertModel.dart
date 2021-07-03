import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> requestBertModel(
    String questionContext, String inputQuery) async {
  var headers = {
    'Prefer': 'respond-async, wait=59',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEtc3RnMS1rZXktMS5jZXIifQ.eyJpZCI6IjE2MjUzMzM3MDMzNTNfOTU0NTQ4NWYtZWNjNS00YzFiLTg0MmQtYzdhYjY5NzBiZjYxX3VlMSIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJjcGZfcGVuX3Rlc3QiLCJ1c2VyX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJhcyI6Imltcy1uYTEtc3RnMSIsImFhX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJwYWMiOiJjcGZfcGVuX3Rlc3Rfc3RnIiwicnRpZCI6IjE2MjUzMzM3MDMzNTNfMGJlOWNkOWMtNGU2Mi00ODhiLWIyNmEtN2Q3NjU5NWM0NTZlX3VlMSIsIm1vaSI6IjdkYjJmZjhlIiwicnRlYSI6IjE2MjY1NDMzMDMzNTMiLCJleHBpcmVzX2luIjoiODY0MDAwMDAiLCJzY29wZSI6InN5c3RlbSIsImNyZWF0ZWRfYXQiOiIxNjI1MzMzNzAzMzUzIn0.VbtvRsMeUW818jlreVsynRwkJqOXE0bOPPSV6d43_LPBWPjvKWmM_e1L8Rw2uT5ywMRqArObCREqHqpY4eX2GqhcoNa8ryCg75aCQ2DZXzST4VPp8Yw0_mvK6_GAihb4Jbz5KGWRo0B-jZmYffGIcrA59gutYA4B_3agOIkCKsVOYyixY-J7lwVGak_EKJnl3U9J5F0IaPnmqgnWsCnngNacN6iiX78p0pVuupC0Jr582t4RYpsuK5mP2LLtW84eAQB_Ybd_XYjagjjXmsXC_uC-IBASWXUo1uSRMv1AtCQz8pGoUavUUbE9b9GXnJlGJSIlBT9dJgTyA0mYYq8fog',
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
    return queryAnswer;
  } else {
    print(response.reasonPhrase);
    return "Answer Not Found";
  }
}
