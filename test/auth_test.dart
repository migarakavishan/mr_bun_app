import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable([MockUser()]); // Mocking the user sign-in state.
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // Mock sign-in logic.
    return super.noSuchMethod(
      Invocation.method(
        #signInWithEmailAndPassword,
        [email, password],
      ),
      returnValue: Future.value(MockUserCredential()),
    );
  }
}

void main() {
  final mockFirebaseAuth = MockFirebaseAuth();
  final mockUserCredential = MockUserCredential();

  test(
    "AuthController should emit auth changes",
    () async {
      // Expect that the auth state changes stream emits a MockUser object.
      expectLater(
        mockFirebaseAuth.authStateChanges(),
        emitsInOrder([isA<MockUser>()]),
      );
    },
  );

  test(
    "Sign in",
    () async {
      // Mock sign-in response.
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: "migara@mail.com",
          password: "123456",
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Perform sign-in logic in your test.
      final result = await mockFirebaseAuth.signInWithEmailAndPassword(
        email: "migara@mail.com",
        password: "123456",
      );

      expect(result, isA<UserCredential>());
    },
  );

  test(
    "Sign in exception",
    () async {
      // Mock the exception for failed sign-in.
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: "migara2@mail.com",
          password: "123456",
        ),
      ).thenThrow(FirebaseAuthException(
          code: 'user-not-found', message: 'User not found'));

      // Expect the sign-in to throw an exception.
      expect(
        () async => await mockFirebaseAuth.signInWithEmailAndPassword(
          email: "migara2@mail.com",
          password: "123456",
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    },
  );
}
