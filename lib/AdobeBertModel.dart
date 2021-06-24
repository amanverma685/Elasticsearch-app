import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> requestBertModel(
    String questionContext, String inputQuery) async {
  var headers = {
    'Prefer': 'respond-async, wait=59',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsIng1dSI6Imltc19uYTEtc3RnMS1rZXktMS5jZXIifQ.eyJpZCI6IjE2MjQ1MzY0NjA3NDlfN2ZlZGM5MWEtMjIxYy00YjYwLWE1YjktZTNmNjFjMjQ4NjVlX3VlMSIsInR5cGUiOiJhY2Nlc3NfdG9rZW4iLCJjbGllbnRfaWQiOiJjcGZfcGVuX3Rlc3QiLCJ1c2VyX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJhcyI6Imltcy1uYTEtc3RnMSIsImFhX2lkIjoiY3BmX3Blbl90ZXN0QEFkb2JlSUQiLCJwYWMiOiJjcGZfcGVuX3Rlc3Rfc3RnIiwicnRpZCI6IjE2MjQ1MzY0NjA3NDlfM2U0ZGFlMDgtZDIyZS00OGE0LWFiNGItYzliODc0MjdiNGQwX3VlMSIsIm1vaSI6ImYyMmQ2ODUzIiwicnRlYSI6IjE2MjU3NDYwNjA3NDkiLCJleHBpcmVzX2luIjoiODY0MDAwMDAiLCJzY29wZSI6InN5c3RlbSIsImNyZWF0ZWRfYXQiOiIxNjI0NTM2NDYwNzQ5In0.gd6U3VmhoDKyEvDnmiRzmtajMZNyE3jwX36CGYOctwPofTgTd9k5WZg2XnL6gWT-HoLAJykF95k64I6agoKdfsRPg87YCjGoxZRefu3_p-XX7I7MdM9nLbC3t9gKPqPt0JWDO6VUzY11RsRNZ1ssUA085KwHGmwEq4TAbPfKa-hVKblgAjBdgC3DWHG3Edmxpcf1FXuaST_XI3aU9vmRDY5MvxlDfv_MAY37th0t50niFKmmT-NmtNjiaUeTRkMNJIun9hSJ3kESf0CqyQf_K2Hb3PJRY6tbcGtfNChm7wsJwuEwQ0R_eNM8_0JI6MoWV4L5KoaUrqn2ZdNSqmGiIQ',
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
