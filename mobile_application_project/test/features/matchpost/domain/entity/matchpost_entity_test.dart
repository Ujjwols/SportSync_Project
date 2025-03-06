import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/matchpost/domain/entity/matchpost_entity.dart';

void main() {
  group('MatchPostEntity', () {
    // Test data
    final matchPostEntity1 = MatchPostEntity(
      matchpostId: '123',
      postedBy: 'user123',
      text: 'Looking for players!',
      img: 'https://example.com/image.jpg',
      teamName: 'Team A',
      location: 'Stadium X',
      date: '2023-10-15',
      time: '10:00 AM',
      gameType: 'Football',
      payment: 'Free',
      createdAt: DateTime(2023, 10, 1),
      updatedAt: DateTime(2023, 10, 2),
    );

    final matchPostEntity2 = MatchPostEntity(
      matchpostId: '123',
      postedBy: 'user123',
      text: 'Looking for players!',
      img: 'https://example.com/image.jpg',
      teamName: 'Team A',
      location: 'Stadium X',
      date: '2023-10-15',
      time: '10:00 AM',
      gameType: 'Football',
      payment: 'Free',
      createdAt: DateTime(2023, 10, 1),
      updatedAt: DateTime(2023, 10, 2),
    );

    final matchPostEntity3 = MatchPostEntity(
      matchpostId: '456',
      postedBy: 'user456',
      text: 'Join our team!',
      img: 'https://example.com/another-image.jpg',
      teamName: 'Team B',
      location: 'Stadium Y',
      date: '2023-10-20',
      time: '2:00 PM',
      gameType: 'Basketball',
      payment: 'Paid',
      createdAt: DateTime(2023, 10, 3),
      updatedAt: DateTime(2023, 10, 4),
    );

    // Test for equality
    test(
        'two MatchPostEntity instances with the same properties should be equal',
        () {
      expect(matchPostEntity1, equals(matchPostEntity2));
    });

    // Test for inequality
    test(
        'two MatchPostEntity instances with different properties should not be equal',
        () {
      expect(matchPostEntity1, isNot(equals(matchPostEntity3)));
    });

    // Test for props
    test('props should contain all properties of MatchPostEntity', () {
      expect(
        matchPostEntity1.props,
        equals([
          '123', // matchpostId
          'user123', // postedBy
          'Looking for players!', // text
          'https://example.com/image.jpg', // img
          'Team A', // teamName
          'Stadium X', // location
          '2023-10-15', // date
          '10:00 AM', // time
          'Football', // gameType
          'Free', // payment
          DateTime(2023, 10, 1), // createdAt
          DateTime(2023, 10, 2), // updatedAt
        ]),
      );
    });
  });
}
