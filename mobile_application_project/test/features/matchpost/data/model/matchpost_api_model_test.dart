import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/matchpost/data/model/matchpost_api_model.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

void main() {
  group('MatchPostApiModel', () {
    final matchPostJson = {
      '_id': '456',
      'postedBy': 'user123',
      'text': 'Looking for a match!',
      'img': 'https://example.com/image.jpg',
      'teamName': 'Falcons',
      'location': 'City Arena',
      'date': '2025-03-10',
      'time': '18:00',
      'gameType': 'Futsal',
      'payment': 'Split',
      'createdAt': '2025-03-01T12:00:00.000Z',
      'updatedAt': '2025-03-02T15:30:00.000Z',
    };

    final matchPostModel = MatchPostApiModel(
      id: '456',
      postedBy: 'user123',
      text: 'Looking for a match!',
      img: 'https://example.com/image.jpg',
      teamName: 'Falcons',
      location: 'City Arena',
      date: '2025-03-10',
      time: '18:00',
      gameType: 'Futsal',
      payment: 'Split',
      createdAt: DateTime.parse('2025-03-01T12:00:00.000Z'),
      updatedAt: DateTime.parse('2025-03-02T15:30:00.000Z'),
    );

    test('should convert matchmodel from JSON correctly', () {
      final result = MatchPostApiModel.fromJson(matchPostJson);
      expect(result, equals(matchPostModel));
    });

    test('should convert matchmodel to JSON correctly', () {
      final result = matchPostModel.toJson();
      expect(result, equals(matchPostJson));
    });

    test('should convert to matchpostentity correctly', () {
      final entity = matchPostModel.toEntity();
      expect(entity, isA<MatchPostEntity>());
      expect(entity.matchpostId, equals(matchPostModel.id));
      expect(entity.postedBy, equals(matchPostModel.postedBy));
      expect(entity.text, equals(matchPostModel.text));
      expect(entity.img, equals(matchPostModel.img));
      expect(entity.teamName, equals(matchPostModel.teamName));
      expect(entity.location, equals(matchPostModel.location));
      expect(entity.date, equals(matchPostModel.date));
      expect(entity.time, equals(matchPostModel.time));
      expect(entity.gameType, equals(matchPostModel.gameType));
      expect(entity.payment, equals(matchPostModel.payment));
      expect(entity.createdAt, equals(matchPostModel.createdAt));
      expect(entity.updatedAt, equals(matchPostModel.updatedAt));
    });

    test('should create from matchpostentity correctly', () {
      final entity = matchPostModel.toEntity();
      final result = MatchPostApiModel.fromEntity(entity);
      expect(result, equals(matchPostModel));
    });
  });
}
