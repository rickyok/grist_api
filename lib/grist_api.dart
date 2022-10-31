library grist_api;

import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;


class GristAPI {
  String server;
  String apiKey;
  String docId;

  GristAPI(this.docId , this.apiKey, {this.server ='https://docs.getgrist.com'});

  Map<String,String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
  }

  Future<dynamic> fetchRecords(String tableName, {Map? filter, String? sort, int limit=0}) async {
    Map<String,String> parameters = {};
    parameters['limit'] = limit.toString();
    if (filter != null) {
      parameters["filter"] = jsonEncode(filter);
    }
    if (sort != null) {
      parameters["sort"] = sort;
    }
    String url = "$server/api/docs/$docId/tables/$tableName/records";
    final uri = Uri.parse(url);
    final uri2 = Uri.https(uri.authority, uri.path, parameters);
    final ret = await http.get(uri2, headers: getHeaders());
    return jsonDecode(ret.body)['records'];
  }
  
  Future<dynamic> addRecords(String tableName, List<Map> records) async {
    String url = "$server/api/docs/$docId/tables/$tableName/records";
    var _records = List.empty(growable: true);
    for (var v in records) {
      _records.add({'fields' : v});
    }
    var body = jsonEncode({"records": _records});
    final ret = await http.post(Uri.parse(url), headers: getHeaders(), body: body);
    return jsonDecode(ret.body)['records'];
  }
  
  Future<dynamic> updateRecords(String tableName, List<Map> records) async {
    String url = "$server/api/docs/$docId/tables/$tableName/records";
    var _records = List.empty(growable: true);
    for (var v in records) {
      var id = v['id'];
      v.remove('id');
      _records.add({'fields' : v, 'id': id});
    }
    var body = jsonEncode({"records": _records});
    print(body);
    final ret = await http.patch(Uri.parse(url), headers: getHeaders(), body: body);
    return jsonDecode(ret.body);
  }

  Future<dynamic> deleteRecords(String tableName, List<int> recordIds) async {
    String url = "$server/api/docs/$docId/tables/$tableName/data/delete";
    var body = jsonEncode(recordIds);
    final ret = await http.post(Uri.parse(url), headers: getHeaders(), body: body);
    return jsonDecode(ret.body);
  }


}
