import 'package:uniquote/config/http.dart';

class ReportApi {
  Future<bool> reportQuote(int quoteId, int reportType, String description) async {
    final r = await dio.post('report_quote', data: {
      'reported_quote': quoteId,
      'report_type': reportType,
      'description': description
    });

    if(r.statusCode == 200) {
      return true;
    }
    return false;
  }
}
