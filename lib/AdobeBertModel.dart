import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> requestBertModel(
    String questionContext, String inputQuery) async {
  var headers = {
    'Prefer': 'respond-async, wait=59',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEtc3RnMS1rZXktMS5jZXIifQ.eyJpZCI6IjE2MjQzNDUwOTI5ODRfMmE3YzdkNmUtMTlmNS00ODYxLWJlNDgtY2YwMGQ4YmQyOWRlX3VlMSIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJjcGZfcGVuX3Rlc3QiLCJ1c2VyX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJhcyI6Imltcy1uYTEtc3RnMSIsImFhX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJwYWMiOiJjcGZfcGVuX3Rlc3Rfc3RnIiwicnRpZCI6IjE2MjQzNDUwOTI5ODRfNGFhNDgwNWUtYmIxMy00MjNkLThjZjMtOTFmMzdkMGE1ZTM4X3VlMSIsIm1vaSI6ImMwNmZkZjU1IiwicnRlYSI6IjE2MjU1NTQ2OTI5ODQiLCJleHBpcmVzX2luIjoiODY0MDAwMDAiLCJzY29wZSI6InN5c3RlbSIsImNyZWF0ZWRfYXQiOiIxNjI0MzQ1MDkyOTg0In0.EZbP9yCF8Jft6TAkGi4Owew3yjOzMa9AjDKylU9Z9KKwrtDe2q7S7xV9Fl4SKsp-EcJnldewk_fpzuFrmfqv_gELW8vvfkV38Z0BYRyNOk6bJ7yIylQ4cxMVk4_Kef0CPGM2GlecLH6EUJyBfyYYEvRPBQGfThGt1tsfFxFCMpODlw-5pB0XCk8GafA6D5fqoHAzJG_lDpvk9l3fs5KkMMAnjWDOoUlJnorVbxqtnzidTh1yRBWirrBJq0x7MjGM0rsgzJ7cbXtQOpA2Oq8UH-sjm-mgkLskoW1oPy8l2eZk24v7sSPDeAHOf2c6qjGDSdyH1Lr92DSOoiZYLFpjmw',
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
