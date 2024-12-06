// Mocks generated by Mockito 5.4.4 from annotations
// in afarscape/test/post_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:afarscape/features/features/posts/data/datasources/post_datasource.dart'
    as _i3;
import 'package:afarscape/features/features/posts/domain/entities/post.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePost_0 extends _i1.SmartFake implements _i2.Post {
  _FakePost_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PostDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostDataSource extends _i1.Mock implements _i3.PostDataSource {
  MockPostDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.Post>> getAllPosts() => (super.noSuchMethod(
        Invocation.method(
          #getAllPosts,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Post>>.value(<_i2.Post>[]),
      ) as _i4.Future<List<_i2.Post>>);

  @override
  _i4.Future<List<_i2.Post>> getPaginatedPosts(
    int? offset,
    int? limit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPaginatedPosts,
          [
            offset,
            limit,
          ],
        ),
        returnValue: _i4.Future<List<_i2.Post>>.value(<_i2.Post>[]),
      ) as _i4.Future<List<_i2.Post>>);

  @override
  _i4.Future<_i2.Post> createPost(_i2.Post? postToAdd) => (super.noSuchMethod(
        Invocation.method(
          #createPost,
          [postToAdd],
        ),
        returnValue: _i4.Future<_i2.Post>.value(_FakePost_0(
          this,
          Invocation.method(
            #createPost,
            [postToAdd],
          ),
        )),
      ) as _i4.Future<_i2.Post>);

  @override
  _i4.Future<_i2.Post> updatePost(_i2.Post? updatedPost) => (super.noSuchMethod(
        Invocation.method(
          #updatePost,
          [updatedPost],
        ),
        returnValue: _i4.Future<_i2.Post>.value(_FakePost_0(
          this,
          Invocation.method(
            #updatePost,
            [updatedPost],
          ),
        )),
      ) as _i4.Future<_i2.Post>);

  @override
  _i4.Future<void> deletePost(String? postId) => (super.noSuchMethod(
        Invocation.method(
          #deletePost,
          [postId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
