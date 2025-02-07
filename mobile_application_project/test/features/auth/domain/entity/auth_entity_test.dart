import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_application_project/features/auth/domain/entity/auth_entity.dart';

void main() {
  const auth1 = AuthEntity(
    teamId: "23434231231245555",
    email: "lali@gmail.com",
    teamName: "lalitpur", // Fixed typo here
    image: "image_url",
    password: "lalitpur123",
    confirmPassword: "lalitpur123",
  );

  const auth2 = AuthEntity(
    teamId: "23434231231245555",
    email: "lali@gmail.com",
    teamName: "lalitpur",
    image: "image_url",
    password: "lalitpur123",
    confirmPassword: "lalitpur123",
  );

  test('Test 2: Two AuthEntity objects with the same values should be equal',
      () {
    expect(auth1, auth2); // Should be equal now
  });
}
