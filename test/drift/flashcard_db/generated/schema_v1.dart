// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class Decks extends Table with TableInfo<Decks, DecksData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Decks(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> cardCount = GeneratedColumn<int>(
    'card_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, cardCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DecksData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DecksData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_count'],
      )!,
    );
  }

  @override
  Decks createAlias(String alias) {
    return Decks(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DecksData extends DataClass implements Insertable<DecksData> {
  final int id;
  final String name;
  final int cardCount;
  const DecksData({
    required this.id,
    required this.name,
    required this.cardCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['card_count'] = Variable<int>(cardCount);
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      name: Value(name),
      cardCount: Value(cardCount),
    );
  }

  factory DecksData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DecksData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cardCount: serializer.fromJson<int>(json['cardCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'cardCount': serializer.toJson<int>(cardCount),
    };
  }

  DecksData copyWith({int? id, String? name, int? cardCount}) => DecksData(
    id: id ?? this.id,
    name: name ?? this.name,
    cardCount: cardCount ?? this.cardCount,
  );
  DecksData copyWithCompanion(DecksCompanion data) {
    return DecksData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      cardCount: data.cardCount.present ? data.cardCount.value : this.cardCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DecksData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cardCount: $cardCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, cardCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DecksData &&
          other.id == this.id &&
          other.name == this.name &&
          other.cardCount == this.cardCount);
}

class DecksCompanion extends UpdateCompanion<DecksData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> cardCount;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cardCount = const Value.absent(),
  });
  DecksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.cardCount = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DecksData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? cardCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cardCount != null) 'card_count': cardCount,
    });
  }

  DecksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? cardCount,
  }) {
    return DecksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cardCount: cardCount ?? this.cardCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cardCount.present) {
      map['card_count'] = Variable<int>(cardCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cardCount: $cardCount')
          ..write(')'))
        .toString();
  }
}

class Flashcards extends Table with TableInfo<Flashcards, FlashcardsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Flashcards(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> deckId = GeneratedColumn<int>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES decks(id)',
  );
  late final GeneratedColumn<String> front = GeneratedColumn<String>(
    'front',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<String> back = GeneratedColumn<String>(
    'back',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> nextReviewDate = GeneratedColumn<int>(
    'next_review_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<int> lastReviewDate = GeneratedColumn<int>(
    'last_review_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<int> state = GeneratedColumn<int>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
    'stability',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deckId,
    front,
    back,
    nextReviewDate,
    lastReviewDate,
    state,
    step,
    stability,
    difficulty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'flashcards';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FlashcardsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FlashcardsData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deck_id'],
      )!,
      front: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front'],
      )!,
      back: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}back'],
      )!,
      nextReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_review_date'],
      ),
      lastReviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_review_date'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}state'],
      )!,
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      ),
      stability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stability'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}difficulty'],
      ),
    );
  }

  @override
  Flashcards createAlias(String alias) {
    return Flashcards(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class FlashcardsData extends DataClass implements Insertable<FlashcardsData> {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final int? nextReviewDate;
  final int? lastReviewDate;
  final int state;
  final int? step;
  final double? stability;
  final double? difficulty;
  const FlashcardsData({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
    this.nextReviewDate,
    this.lastReviewDate,
    required this.state,
    this.step,
    this.stability,
    this.difficulty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deck_id'] = Variable<int>(deckId);
    map['front'] = Variable<String>(front);
    map['back'] = Variable<String>(back);
    if (!nullToAbsent || nextReviewDate != null) {
      map['next_review_date'] = Variable<int>(nextReviewDate);
    }
    if (!nullToAbsent || lastReviewDate != null) {
      map['last_review_date'] = Variable<int>(lastReviewDate);
    }
    map['state'] = Variable<int>(state);
    if (!nullToAbsent || step != null) {
      map['step'] = Variable<int>(step);
    }
    if (!nullToAbsent || stability != null) {
      map['stability'] = Variable<double>(stability);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    return map;
  }

  FlashcardsCompanion toCompanion(bool nullToAbsent) {
    return FlashcardsCompanion(
      id: Value(id),
      deckId: Value(deckId),
      front: Value(front),
      back: Value(back),
      nextReviewDate: nextReviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewDate),
      lastReviewDate: lastReviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewDate),
      state: Value(state),
      step: step == null && nullToAbsent ? const Value.absent() : Value(step),
      stability: stability == null && nullToAbsent
          ? const Value.absent()
          : Value(stability),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
    );
  }

  factory FlashcardsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FlashcardsData(
      id: serializer.fromJson<int>(json['id']),
      deckId: serializer.fromJson<int>(json['deckId']),
      front: serializer.fromJson<String>(json['front']),
      back: serializer.fromJson<String>(json['back']),
      nextReviewDate: serializer.fromJson<int?>(json['nextReviewDate']),
      lastReviewDate: serializer.fromJson<int?>(json['lastReviewDate']),
      state: serializer.fromJson<int>(json['state']),
      step: serializer.fromJson<int?>(json['step']),
      stability: serializer.fromJson<double?>(json['stability']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deckId': serializer.toJson<int>(deckId),
      'front': serializer.toJson<String>(front),
      'back': serializer.toJson<String>(back),
      'nextReviewDate': serializer.toJson<int?>(nextReviewDate),
      'lastReviewDate': serializer.toJson<int?>(lastReviewDate),
      'state': serializer.toJson<int>(state),
      'step': serializer.toJson<int?>(step),
      'stability': serializer.toJson<double?>(stability),
      'difficulty': serializer.toJson<double?>(difficulty),
    };
  }

  FlashcardsData copyWith({
    int? id,
    int? deckId,
    String? front,
    String? back,
    Value<int?> nextReviewDate = const Value.absent(),
    Value<int?> lastReviewDate = const Value.absent(),
    int? state,
    Value<int?> step = const Value.absent(),
    Value<double?> stability = const Value.absent(),
    Value<double?> difficulty = const Value.absent(),
  }) => FlashcardsData(
    id: id ?? this.id,
    deckId: deckId ?? this.deckId,
    front: front ?? this.front,
    back: back ?? this.back,
    nextReviewDate: nextReviewDate.present
        ? nextReviewDate.value
        : this.nextReviewDate,
    lastReviewDate: lastReviewDate.present
        ? lastReviewDate.value
        : this.lastReviewDate,
    state: state ?? this.state,
    step: step.present ? step.value : this.step,
    stability: stability.present ? stability.value : this.stability,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
  );
  FlashcardsData copyWithCompanion(FlashcardsCompanion data) {
    return FlashcardsData(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      front: data.front.present ? data.front.value : this.front,
      back: data.back.present ? data.back.value : this.back,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      lastReviewDate: data.lastReviewDate.present
          ? data.lastReviewDate.value
          : this.lastReviewDate,
      state: data.state.present ? data.state.value : this.state,
      step: data.step.present ? data.step.value : this.step,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsData(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deckId,
    front,
    back,
    nextReviewDate,
    lastReviewDate,
    state,
    step,
    stability,
    difficulty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FlashcardsData &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.front == this.front &&
          other.back == this.back &&
          other.nextReviewDate == this.nextReviewDate &&
          other.lastReviewDate == this.lastReviewDate &&
          other.state == this.state &&
          other.step == this.step &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty);
}

class FlashcardsCompanion extends UpdateCompanion<FlashcardsData> {
  final Value<int> id;
  final Value<int> deckId;
  final Value<String> front;
  final Value<String> back;
  final Value<int?> nextReviewDate;
  final Value<int?> lastReviewDate;
  final Value<int> state;
  final Value<int?> step;
  final Value<double?> stability;
  final Value<double?> difficulty;
  const FlashcardsCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.front = const Value.absent(),
    this.back = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.lastReviewDate = const Value.absent(),
    this.state = const Value.absent(),
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
  });
  FlashcardsCompanion.insert({
    this.id = const Value.absent(),
    required int deckId,
    required String front,
    required String back,
    this.nextReviewDate = const Value.absent(),
    this.lastReviewDate = const Value.absent(),
    required int state,
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
  }) : deckId = Value(deckId),
       front = Value(front),
       back = Value(back),
       state = Value(state);
  static Insertable<FlashcardsData> custom({
    Expression<int>? id,
    Expression<int>? deckId,
    Expression<String>? front,
    Expression<String>? back,
    Expression<int>? nextReviewDate,
    Expression<int>? lastReviewDate,
    Expression<int>? state,
    Expression<int>? step,
    Expression<double>? stability,
    Expression<double>? difficulty,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (front != null) 'front': front,
      if (back != null) 'back': back,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (lastReviewDate != null) 'last_review_date': lastReviewDate,
      if (state != null) 'state': state,
      if (step != null) 'step': step,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
    });
  }

  FlashcardsCompanion copyWith({
    Value<int>? id,
    Value<int>? deckId,
    Value<String>? front,
    Value<String>? back,
    Value<int?>? nextReviewDate,
    Value<int?>? lastReviewDate,
    Value<int>? state,
    Value<int?>? step,
    Value<double?>? stability,
    Value<double?>? difficulty,
  }) {
    return FlashcardsCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      front: front ?? this.front,
      back: back ?? this.back,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      state: state ?? this.state,
      step: step ?? this.step,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<int>(deckId.value);
    }
    if (front.present) {
      map['front'] = Variable<String>(front.value);
    }
    if (back.present) {
      map['back'] = Variable<String>(back.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<int>(nextReviewDate.value);
    }
    if (lastReviewDate.present) {
      map['last_review_date'] = Variable<int>(lastReviewDate.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(state.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FlashcardsCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('front: $front, ')
          ..write('back: $back, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate, ')
          ..write('state: $state, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty')
          ..write(')'))
        .toString();
  }
}

class Reviews extends Table with TableInfo<Reviews, ReviewsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Reviews(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES flashcards(id)',
  );
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  late final GeneratedColumn<int> reviewDate = GeneratedColumn<int>(
    'review_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [cardId, rating, reviewDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  Set<GeneratedColumn> get $primaryKey => {cardId, reviewDate};
  @override
  ReviewsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewsData(
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      reviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_date'],
      )!,
    );
  }

  @override
  Reviews createAlias(String alias) {
    return Reviews(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'PRIMARY KEY(card_id, review_date)',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class ReviewsData extends DataClass implements Insertable<ReviewsData> {
  final int cardId;
  final int rating;
  final int reviewDate;
  const ReviewsData({
    required this.cardId,
    required this.rating,
    required this.reviewDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<int>(cardId);
    map['rating'] = Variable<int>(rating);
    map['review_date'] = Variable<int>(reviewDate);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      cardId: Value(cardId),
      rating: Value(rating),
      reviewDate: Value(reviewDate),
    );
  }

  factory ReviewsData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewsData(
      cardId: serializer.fromJson<int>(json['cardId']),
      rating: serializer.fromJson<int>(json['rating']),
      reviewDate: serializer.fromJson<int>(json['reviewDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<int>(cardId),
      'rating': serializer.toJson<int>(rating),
      'reviewDate': serializer.toJson<int>(reviewDate),
    };
  }

  ReviewsData copyWith({int? cardId, int? rating, int? reviewDate}) =>
      ReviewsData(
        cardId: cardId ?? this.cardId,
        rating: rating ?? this.rating,
        reviewDate: reviewDate ?? this.reviewDate,
      );
  ReviewsData copyWithCompanion(ReviewsCompanion data) {
    return ReviewsData(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewDate: data.reviewDate.present
          ? data.reviewDate.value
          : this.reviewDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsData(')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewDate: $reviewDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cardId, rating, reviewDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewsData &&
          other.cardId == this.cardId &&
          other.rating == this.rating &&
          other.reviewDate == this.reviewDate);
}

class ReviewsCompanion extends UpdateCompanion<ReviewsData> {
  final Value<int> cardId;
  final Value<int> rating;
  final Value<int> reviewDate;
  final Value<int> rowid;
  const ReviewsCompanion({
    this.cardId = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewsCompanion.insert({
    required int cardId,
    required int rating,
    required int reviewDate,
    this.rowid = const Value.absent(),
  }) : cardId = Value(cardId),
       rating = Value(rating),
       reviewDate = Value(reviewDate);
  static Insertable<ReviewsData> custom({
    Expression<int>? cardId,
    Expression<int>? rating,
    Expression<int>? reviewDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (rating != null) 'rating': rating,
      if (reviewDate != null) 'review_date': reviewDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewsCompanion copyWith({
    Value<int>? cardId,
    Value<int>? rating,
    Value<int>? reviewDate,
    Value<int>? rowid,
  }) {
    return ReviewsCompanion(
      cardId: cardId ?? this.cardId,
      rating: rating ?? this.rating,
      reviewDate: reviewDate ?? this.reviewDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (reviewDate.present) {
      map['review_date'] = Variable<int>(reviewDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewDate: $reviewDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final Decks decks = Decks(this);
  late final Flashcards flashcards = Flashcards(this);
  late final Reviews reviews = Reviews(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    decks,
    flashcards,
    reviews,
  ];
  @override
  int get schemaVersion => 1;
}
