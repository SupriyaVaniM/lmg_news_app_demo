import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'fetch_article_test.mocks.dart';
import 'package:lmg_news_app_demo/core/constants/constants.dart';
import 'package:lmg_news_app_demo/core/network/network_service.dart';

@GenerateMocks([http.Client])
void main() {
  group("news api testing", () {
    final client = MockClient();
    final networkService = NetworkService();

    String url =
        "https://api.thenewsapi.com/v1/news/all?api_token=$apiKey&search=$search&published_after=$publishedAfter&categories=$categories";
    final mapJson = {
      "title": "India – Britain bond",
      "description":
          "As of my last update in September 2021, the relationship between India and Britain continued to be multifaceted and significant, based on historical ties, cultu...",
      "imageUrl":
          "https://miro.medium.com/v2/resize:fit:1200/1*jv3M0IYSe9Tn9w92MX52Bw@2x.jpeg",
      "publishedAt": "2023-08-06T23:50:43.000000Z"
    };

    test("if api has value", () async {
      when(client.get(Uri.parse(url))).thenAnswer((_) async =>
          http.Response(mapJson as String, 200));
      final item = await networkService.fetchNewsArticles();

      expect(item!.length,3);

    });

    test('throws an exception if the http call completes with an error',
        () async {
      when(client.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('not found', 404));

      final item = await networkService.fetchNewsArticles();
      expect(item!.isEmpty, false);
    });
  });
}
