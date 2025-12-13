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

class UserProgress extends Table
    with TableInfo<UserProgress, UserProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  UserProgress(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT',
  );
  late final GeneratedColumn<int> currency = GeneratedColumn<int>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> lastResetDate = GeneratedColumn<int>(
    'last_reset_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NULL',
  );
  late final GeneratedColumn<int> loginQuestDone = GeneratedColumn<int>(
    'login_quest_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (login_quest_done IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> loginQuestClaimed = GeneratedColumn<int>(
    'login_quest_claimed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (login_quest_claimed IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> learnQuestDone = GeneratedColumn<int>(
    'learn_quest_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (learn_quest_done IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> learnQuestClaimed = GeneratedColumn<int>(
    'learn_quest_claimed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (learn_quest_claimed IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> cardsLearnedToday = GeneratedColumn<int>(
    'cards_learned_today',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> reviewQuestDone = GeneratedColumn<int>(
    'review_quest_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (review_quest_done IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> reviewQuestClaimed = GeneratedColumn<int>(
    'review_quest_claimed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (review_quest_claimed IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> allDailyQuestsDone = GeneratedColumn<int>(
    'all_daily_quests_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (all_daily_quests_done IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> allDailyQuestsClaimed = GeneratedColumn<int>(
    'all_daily_quests_claimed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints:
        'NOT NULL DEFAULT 0 CHECK (all_daily_quests_claimed IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedGreen = GeneratedColumn<int>(
    'unlocked_green',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_green IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedBlue = GeneratedColumn<int>(
    'unlocked_blue',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_blue IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedYellow = GeneratedColumn<int>(
    'unlocked_yellow',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_yellow IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedPink = GeneratedColumn<int>(
    'unlocked_pink',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_pink IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedOrange = GeneratedColumn<int>(
    'unlocked_orange',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_orange IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<int> unlockedPurple = GeneratedColumn<int>(
    'unlocked_purple',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL DEFAULT 0 CHECK (unlocked_purple IN (0, 1))',
    defaultValue: const CustomExpression('0'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currency,
    lastResetDate,
    loginQuestDone,
    loginQuestClaimed,
    learnQuestDone,
    learnQuestClaimed,
    cardsLearnedToday,
    reviewQuestDone,
    reviewQuestClaimed,
    allDailyQuestsDone,
    allDailyQuestsClaimed,
    unlockedGreen,
    unlockedBlue,
    unlockedYellow,
    unlockedPink,
    unlockedOrange,
    unlockedPurple,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}currency'],
      )!,
      lastResetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_reset_date'],
      ),
      loginQuestDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}login_quest_done'],
      )!,
      loginQuestClaimed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}login_quest_claimed'],
      )!,
      learnQuestDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}learn_quest_done'],
      )!,
      learnQuestClaimed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}learn_quest_claimed'],
      )!,
      cardsLearnedToday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cards_learned_today'],
      )!,
      reviewQuestDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_quest_done'],
      )!,
      reviewQuestClaimed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_quest_claimed'],
      )!,
      allDailyQuestsDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}all_daily_quests_done'],
      )!,
      allDailyQuestsClaimed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}all_daily_quests_claimed'],
      )!,
      unlockedGreen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_green'],
      )!,
      unlockedBlue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_blue'],
      )!,
      unlockedYellow: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_yellow'],
      )!,
      unlockedPink: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_pink'],
      )!,
      unlockedOrange: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_orange'],
      )!,
      unlockedPurple: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unlocked_purple'],
      )!,
    );
  }

  @override
  UserProgress createAlias(String alias) {
    return UserProgress(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class UserProgressData extends DataClass
    implements Insertable<UserProgressData> {
  final int id;
  final int currency;
  final int? lastResetDate;
  final int loginQuestDone;
  final int loginQuestClaimed;
  final int learnQuestDone;
  final int learnQuestClaimed;
  final int cardsLearnedToday;
  final int reviewQuestDone;
  final int reviewQuestClaimed;
  final int allDailyQuestsDone;
  final int allDailyQuestsClaimed;
  final int unlockedGreen;
  final int unlockedBlue;
  final int unlockedYellow;
  final int unlockedPink;
  final int unlockedOrange;
  final int unlockedPurple;
  const UserProgressData({
    required this.id,
    required this.currency,
    this.lastResetDate,
    required this.loginQuestDone,
    required this.loginQuestClaimed,
    required this.learnQuestDone,
    required this.learnQuestClaimed,
    required this.cardsLearnedToday,
    required this.reviewQuestDone,
    required this.reviewQuestClaimed,
    required this.allDailyQuestsDone,
    required this.allDailyQuestsClaimed,
    required this.unlockedGreen,
    required this.unlockedBlue,
    required this.unlockedYellow,
    required this.unlockedPink,
    required this.unlockedOrange,
    required this.unlockedPurple,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency'] = Variable<int>(currency);
    if (!nullToAbsent || lastResetDate != null) {
      map['last_reset_date'] = Variable<int>(lastResetDate);
    }
    map['login_quest_done'] = Variable<int>(loginQuestDone);
    map['login_quest_claimed'] = Variable<int>(loginQuestClaimed);
    map['learn_quest_done'] = Variable<int>(learnQuestDone);
    map['learn_quest_claimed'] = Variable<int>(learnQuestClaimed);
    map['cards_learned_today'] = Variable<int>(cardsLearnedToday);
    map['review_quest_done'] = Variable<int>(reviewQuestDone);
    map['review_quest_claimed'] = Variable<int>(reviewQuestClaimed);
    map['all_daily_quests_done'] = Variable<int>(allDailyQuestsDone);
    map['all_daily_quests_claimed'] = Variable<int>(allDailyQuestsClaimed);
    map['unlocked_green'] = Variable<int>(unlockedGreen);
    map['unlocked_blue'] = Variable<int>(unlockedBlue);
    map['unlocked_yellow'] = Variable<int>(unlockedYellow);
    map['unlocked_pink'] = Variable<int>(unlockedPink);
    map['unlocked_orange'] = Variable<int>(unlockedOrange);
    map['unlocked_purple'] = Variable<int>(unlockedPurple);
    return map;
  }

  UserProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgressCompanion(
      id: Value(id),
      currency: Value(currency),
      lastResetDate: lastResetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastResetDate),
      loginQuestDone: Value(loginQuestDone),
      loginQuestClaimed: Value(loginQuestClaimed),
      learnQuestDone: Value(learnQuestDone),
      learnQuestClaimed: Value(learnQuestClaimed),
      cardsLearnedToday: Value(cardsLearnedToday),
      reviewQuestDone: Value(reviewQuestDone),
      reviewQuestClaimed: Value(reviewQuestClaimed),
      allDailyQuestsDone: Value(allDailyQuestsDone),
      allDailyQuestsClaimed: Value(allDailyQuestsClaimed),
      unlockedGreen: Value(unlockedGreen),
      unlockedBlue: Value(unlockedBlue),
      unlockedYellow: Value(unlockedYellow),
      unlockedPink: Value(unlockedPink),
      unlockedOrange: Value(unlockedOrange),
      unlockedPurple: Value(unlockedPurple),
    );
  }

  factory UserProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressData(
      id: serializer.fromJson<int>(json['id']),
      currency: serializer.fromJson<int>(json['currency']),
      lastResetDate: serializer.fromJson<int?>(json['lastResetDate']),
      loginQuestDone: serializer.fromJson<int>(json['loginQuestDone']),
      loginQuestClaimed: serializer.fromJson<int>(json['loginQuestClaimed']),
      learnQuestDone: serializer.fromJson<int>(json['learnQuestDone']),
      learnQuestClaimed: serializer.fromJson<int>(json['learnQuestClaimed']),
      cardsLearnedToday: serializer.fromJson<int>(json['cardsLearnedToday']),
      reviewQuestDone: serializer.fromJson<int>(json['reviewQuestDone']),
      reviewQuestClaimed: serializer.fromJson<int>(json['reviewQuestClaimed']),
      allDailyQuestsDone: serializer.fromJson<int>(json['allDailyQuestsDone']),
      allDailyQuestsClaimed: serializer.fromJson<int>(
        json['allDailyQuestsClaimed'],
      ),
      unlockedGreen: serializer.fromJson<int>(json['unlockedGreen']),
      unlockedBlue: serializer.fromJson<int>(json['unlockedBlue']),
      unlockedYellow: serializer.fromJson<int>(json['unlockedYellow']),
      unlockedPink: serializer.fromJson<int>(json['unlockedPink']),
      unlockedOrange: serializer.fromJson<int>(json['unlockedOrange']),
      unlockedPurple: serializer.fromJson<int>(json['unlockedPurple']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currency': serializer.toJson<int>(currency),
      'lastResetDate': serializer.toJson<int?>(lastResetDate),
      'loginQuestDone': serializer.toJson<int>(loginQuestDone),
      'loginQuestClaimed': serializer.toJson<int>(loginQuestClaimed),
      'learnQuestDone': serializer.toJson<int>(learnQuestDone),
      'learnQuestClaimed': serializer.toJson<int>(learnQuestClaimed),
      'cardsLearnedToday': serializer.toJson<int>(cardsLearnedToday),
      'reviewQuestDone': serializer.toJson<int>(reviewQuestDone),
      'reviewQuestClaimed': serializer.toJson<int>(reviewQuestClaimed),
      'allDailyQuestsDone': serializer.toJson<int>(allDailyQuestsDone),
      'allDailyQuestsClaimed': serializer.toJson<int>(allDailyQuestsClaimed),
      'unlockedGreen': serializer.toJson<int>(unlockedGreen),
      'unlockedBlue': serializer.toJson<int>(unlockedBlue),
      'unlockedYellow': serializer.toJson<int>(unlockedYellow),
      'unlockedPink': serializer.toJson<int>(unlockedPink),
      'unlockedOrange': serializer.toJson<int>(unlockedOrange),
      'unlockedPurple': serializer.toJson<int>(unlockedPurple),
    };
  }

  UserProgressData copyWith({
    int? id,
    int? currency,
    Value<int?> lastResetDate = const Value.absent(),
    int? loginQuestDone,
    int? loginQuestClaimed,
    int? learnQuestDone,
    int? learnQuestClaimed,
    int? cardsLearnedToday,
    int? reviewQuestDone,
    int? reviewQuestClaimed,
    int? allDailyQuestsDone,
    int? allDailyQuestsClaimed,
    int? unlockedGreen,
    int? unlockedBlue,
    int? unlockedYellow,
    int? unlockedPink,
    int? unlockedOrange,
    int? unlockedPurple,
  }) => UserProgressData(
    id: id ?? this.id,
    currency: currency ?? this.currency,
    lastResetDate: lastResetDate.present
        ? lastResetDate.value
        : this.lastResetDate,
    loginQuestDone: loginQuestDone ?? this.loginQuestDone,
    loginQuestClaimed: loginQuestClaimed ?? this.loginQuestClaimed,
    learnQuestDone: learnQuestDone ?? this.learnQuestDone,
    learnQuestClaimed: learnQuestClaimed ?? this.learnQuestClaimed,
    cardsLearnedToday: cardsLearnedToday ?? this.cardsLearnedToday,
    reviewQuestDone: reviewQuestDone ?? this.reviewQuestDone,
    reviewQuestClaimed: reviewQuestClaimed ?? this.reviewQuestClaimed,
    allDailyQuestsDone: allDailyQuestsDone ?? this.allDailyQuestsDone,
    allDailyQuestsClaimed: allDailyQuestsClaimed ?? this.allDailyQuestsClaimed,
    unlockedGreen: unlockedGreen ?? this.unlockedGreen,
    unlockedBlue: unlockedBlue ?? this.unlockedBlue,
    unlockedYellow: unlockedYellow ?? this.unlockedYellow,
    unlockedPink: unlockedPink ?? this.unlockedPink,
    unlockedOrange: unlockedOrange ?? this.unlockedOrange,
    unlockedPurple: unlockedPurple ?? this.unlockedPurple,
  );
  UserProgressData copyWithCompanion(UserProgressCompanion data) {
    return UserProgressData(
      id: data.id.present ? data.id.value : this.id,
      currency: data.currency.present ? data.currency.value : this.currency,
      lastResetDate: data.lastResetDate.present
          ? data.lastResetDate.value
          : this.lastResetDate,
      loginQuestDone: data.loginQuestDone.present
          ? data.loginQuestDone.value
          : this.loginQuestDone,
      loginQuestClaimed: data.loginQuestClaimed.present
          ? data.loginQuestClaimed.value
          : this.loginQuestClaimed,
      learnQuestDone: data.learnQuestDone.present
          ? data.learnQuestDone.value
          : this.learnQuestDone,
      learnQuestClaimed: data.learnQuestClaimed.present
          ? data.learnQuestClaimed.value
          : this.learnQuestClaimed,
      cardsLearnedToday: data.cardsLearnedToday.present
          ? data.cardsLearnedToday.value
          : this.cardsLearnedToday,
      reviewQuestDone: data.reviewQuestDone.present
          ? data.reviewQuestDone.value
          : this.reviewQuestDone,
      reviewQuestClaimed: data.reviewQuestClaimed.present
          ? data.reviewQuestClaimed.value
          : this.reviewQuestClaimed,
      allDailyQuestsDone: data.allDailyQuestsDone.present
          ? data.allDailyQuestsDone.value
          : this.allDailyQuestsDone,
      allDailyQuestsClaimed: data.allDailyQuestsClaimed.present
          ? data.allDailyQuestsClaimed.value
          : this.allDailyQuestsClaimed,
      unlockedGreen: data.unlockedGreen.present
          ? data.unlockedGreen.value
          : this.unlockedGreen,
      unlockedBlue: data.unlockedBlue.present
          ? data.unlockedBlue.value
          : this.unlockedBlue,
      unlockedYellow: data.unlockedYellow.present
          ? data.unlockedYellow.value
          : this.unlockedYellow,
      unlockedPink: data.unlockedPink.present
          ? data.unlockedPink.value
          : this.unlockedPink,
      unlockedOrange: data.unlockedOrange.present
          ? data.unlockedOrange.value
          : this.unlockedOrange,
      unlockedPurple: data.unlockedPurple.present
          ? data.unlockedPurple.value
          : this.unlockedPurple,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressData(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('lastResetDate: $lastResetDate, ')
          ..write('loginQuestDone: $loginQuestDone, ')
          ..write('loginQuestClaimed: $loginQuestClaimed, ')
          ..write('learnQuestDone: $learnQuestDone, ')
          ..write('learnQuestClaimed: $learnQuestClaimed, ')
          ..write('cardsLearnedToday: $cardsLearnedToday, ')
          ..write('reviewQuestDone: $reviewQuestDone, ')
          ..write('reviewQuestClaimed: $reviewQuestClaimed, ')
          ..write('allDailyQuestsDone: $allDailyQuestsDone, ')
          ..write('allDailyQuestsClaimed: $allDailyQuestsClaimed, ')
          ..write('unlockedGreen: $unlockedGreen, ')
          ..write('unlockedBlue: $unlockedBlue, ')
          ..write('unlockedYellow: $unlockedYellow, ')
          ..write('unlockedPink: $unlockedPink, ')
          ..write('unlockedOrange: $unlockedOrange, ')
          ..write('unlockedPurple: $unlockedPurple')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currency,
    lastResetDate,
    loginQuestDone,
    loginQuestClaimed,
    learnQuestDone,
    learnQuestClaimed,
    cardsLearnedToday,
    reviewQuestDone,
    reviewQuestClaimed,
    allDailyQuestsDone,
    allDailyQuestsClaimed,
    unlockedGreen,
    unlockedBlue,
    unlockedYellow,
    unlockedPink,
    unlockedOrange,
    unlockedPurple,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressData &&
          other.id == this.id &&
          other.currency == this.currency &&
          other.lastResetDate == this.lastResetDate &&
          other.loginQuestDone == this.loginQuestDone &&
          other.loginQuestClaimed == this.loginQuestClaimed &&
          other.learnQuestDone == this.learnQuestDone &&
          other.learnQuestClaimed == this.learnQuestClaimed &&
          other.cardsLearnedToday == this.cardsLearnedToday &&
          other.reviewQuestDone == this.reviewQuestDone &&
          other.reviewQuestClaimed == this.reviewQuestClaimed &&
          other.allDailyQuestsDone == this.allDailyQuestsDone &&
          other.allDailyQuestsClaimed == this.allDailyQuestsClaimed &&
          other.unlockedGreen == this.unlockedGreen &&
          other.unlockedBlue == this.unlockedBlue &&
          other.unlockedYellow == this.unlockedYellow &&
          other.unlockedPink == this.unlockedPink &&
          other.unlockedOrange == this.unlockedOrange &&
          other.unlockedPurple == this.unlockedPurple);
}

class UserProgressCompanion extends UpdateCompanion<UserProgressData> {
  final Value<int> id;
  final Value<int> currency;
  final Value<int?> lastResetDate;
  final Value<int> loginQuestDone;
  final Value<int> loginQuestClaimed;
  final Value<int> learnQuestDone;
  final Value<int> learnQuestClaimed;
  final Value<int> cardsLearnedToday;
  final Value<int> reviewQuestDone;
  final Value<int> reviewQuestClaimed;
  final Value<int> allDailyQuestsDone;
  final Value<int> allDailyQuestsClaimed;
  final Value<int> unlockedGreen;
  final Value<int> unlockedBlue;
  final Value<int> unlockedYellow;
  final Value<int> unlockedPink;
  final Value<int> unlockedOrange;
  final Value<int> unlockedPurple;
  const UserProgressCompanion({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.lastResetDate = const Value.absent(),
    this.loginQuestDone = const Value.absent(),
    this.loginQuestClaimed = const Value.absent(),
    this.learnQuestDone = const Value.absent(),
    this.learnQuestClaimed = const Value.absent(),
    this.cardsLearnedToday = const Value.absent(),
    this.reviewQuestDone = const Value.absent(),
    this.reviewQuestClaimed = const Value.absent(),
    this.allDailyQuestsDone = const Value.absent(),
    this.allDailyQuestsClaimed = const Value.absent(),
    this.unlockedGreen = const Value.absent(),
    this.unlockedBlue = const Value.absent(),
    this.unlockedYellow = const Value.absent(),
    this.unlockedPink = const Value.absent(),
    this.unlockedOrange = const Value.absent(),
    this.unlockedPurple = const Value.absent(),
  });
  UserProgressCompanion.insert({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.lastResetDate = const Value.absent(),
    this.loginQuestDone = const Value.absent(),
    this.loginQuestClaimed = const Value.absent(),
    this.learnQuestDone = const Value.absent(),
    this.learnQuestClaimed = const Value.absent(),
    this.cardsLearnedToday = const Value.absent(),
    this.reviewQuestDone = const Value.absent(),
    this.reviewQuestClaimed = const Value.absent(),
    this.allDailyQuestsDone = const Value.absent(),
    this.allDailyQuestsClaimed = const Value.absent(),
    this.unlockedGreen = const Value.absent(),
    this.unlockedBlue = const Value.absent(),
    this.unlockedYellow = const Value.absent(),
    this.unlockedPink = const Value.absent(),
    this.unlockedOrange = const Value.absent(),
    this.unlockedPurple = const Value.absent(),
  });
  static Insertable<UserProgressData> custom({
    Expression<int>? id,
    Expression<int>? currency,
    Expression<int>? lastResetDate,
    Expression<int>? loginQuestDone,
    Expression<int>? loginQuestClaimed,
    Expression<int>? learnQuestDone,
    Expression<int>? learnQuestClaimed,
    Expression<int>? cardsLearnedToday,
    Expression<int>? reviewQuestDone,
    Expression<int>? reviewQuestClaimed,
    Expression<int>? allDailyQuestsDone,
    Expression<int>? allDailyQuestsClaimed,
    Expression<int>? unlockedGreen,
    Expression<int>? unlockedBlue,
    Expression<int>? unlockedYellow,
    Expression<int>? unlockedPink,
    Expression<int>? unlockedOrange,
    Expression<int>? unlockedPurple,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currency != null) 'currency': currency,
      if (lastResetDate != null) 'last_reset_date': lastResetDate,
      if (loginQuestDone != null) 'login_quest_done': loginQuestDone,
      if (loginQuestClaimed != null) 'login_quest_claimed': loginQuestClaimed,
      if (learnQuestDone != null) 'learn_quest_done': learnQuestDone,
      if (learnQuestClaimed != null) 'learn_quest_claimed': learnQuestClaimed,
      if (cardsLearnedToday != null) 'cards_learned_today': cardsLearnedToday,
      if (reviewQuestDone != null) 'review_quest_done': reviewQuestDone,
      if (reviewQuestClaimed != null)
        'review_quest_claimed': reviewQuestClaimed,
      if (allDailyQuestsDone != null)
        'all_daily_quests_done': allDailyQuestsDone,
      if (allDailyQuestsClaimed != null)
        'all_daily_quests_claimed': allDailyQuestsClaimed,
      if (unlockedGreen != null) 'unlocked_green': unlockedGreen,
      if (unlockedBlue != null) 'unlocked_blue': unlockedBlue,
      if (unlockedYellow != null) 'unlocked_yellow': unlockedYellow,
      if (unlockedPink != null) 'unlocked_pink': unlockedPink,
      if (unlockedOrange != null) 'unlocked_orange': unlockedOrange,
      if (unlockedPurple != null) 'unlocked_purple': unlockedPurple,
    });
  }

  UserProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? currency,
    Value<int?>? lastResetDate,
    Value<int>? loginQuestDone,
    Value<int>? loginQuestClaimed,
    Value<int>? learnQuestDone,
    Value<int>? learnQuestClaimed,
    Value<int>? cardsLearnedToday,
    Value<int>? reviewQuestDone,
    Value<int>? reviewQuestClaimed,
    Value<int>? allDailyQuestsDone,
    Value<int>? allDailyQuestsClaimed,
    Value<int>? unlockedGreen,
    Value<int>? unlockedBlue,
    Value<int>? unlockedYellow,
    Value<int>? unlockedPink,
    Value<int>? unlockedOrange,
    Value<int>? unlockedPurple,
  }) {
    return UserProgressCompanion(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      lastResetDate: lastResetDate ?? this.lastResetDate,
      loginQuestDone: loginQuestDone ?? this.loginQuestDone,
      loginQuestClaimed: loginQuestClaimed ?? this.loginQuestClaimed,
      learnQuestDone: learnQuestDone ?? this.learnQuestDone,
      learnQuestClaimed: learnQuestClaimed ?? this.learnQuestClaimed,
      cardsLearnedToday: cardsLearnedToday ?? this.cardsLearnedToday,
      reviewQuestDone: reviewQuestDone ?? this.reviewQuestDone,
      reviewQuestClaimed: reviewQuestClaimed ?? this.reviewQuestClaimed,
      allDailyQuestsDone: allDailyQuestsDone ?? this.allDailyQuestsDone,
      allDailyQuestsClaimed:
          allDailyQuestsClaimed ?? this.allDailyQuestsClaimed,
      unlockedGreen: unlockedGreen ?? this.unlockedGreen,
      unlockedBlue: unlockedBlue ?? this.unlockedBlue,
      unlockedYellow: unlockedYellow ?? this.unlockedYellow,
      unlockedPink: unlockedPink ?? this.unlockedPink,
      unlockedOrange: unlockedOrange ?? this.unlockedOrange,
      unlockedPurple: unlockedPurple ?? this.unlockedPurple,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(currency.value);
    }
    if (lastResetDate.present) {
      map['last_reset_date'] = Variable<int>(lastResetDate.value);
    }
    if (loginQuestDone.present) {
      map['login_quest_done'] = Variable<int>(loginQuestDone.value);
    }
    if (loginQuestClaimed.present) {
      map['login_quest_claimed'] = Variable<int>(loginQuestClaimed.value);
    }
    if (learnQuestDone.present) {
      map['learn_quest_done'] = Variable<int>(learnQuestDone.value);
    }
    if (learnQuestClaimed.present) {
      map['learn_quest_claimed'] = Variable<int>(learnQuestClaimed.value);
    }
    if (cardsLearnedToday.present) {
      map['cards_learned_today'] = Variable<int>(cardsLearnedToday.value);
    }
    if (reviewQuestDone.present) {
      map['review_quest_done'] = Variable<int>(reviewQuestDone.value);
    }
    if (reviewQuestClaimed.present) {
      map['review_quest_claimed'] = Variable<int>(reviewQuestClaimed.value);
    }
    if (allDailyQuestsDone.present) {
      map['all_daily_quests_done'] = Variable<int>(allDailyQuestsDone.value);
    }
    if (allDailyQuestsClaimed.present) {
      map['all_daily_quests_claimed'] = Variable<int>(
        allDailyQuestsClaimed.value,
      );
    }
    if (unlockedGreen.present) {
      map['unlocked_green'] = Variable<int>(unlockedGreen.value);
    }
    if (unlockedBlue.present) {
      map['unlocked_blue'] = Variable<int>(unlockedBlue.value);
    }
    if (unlockedYellow.present) {
      map['unlocked_yellow'] = Variable<int>(unlockedYellow.value);
    }
    if (unlockedPink.present) {
      map['unlocked_pink'] = Variable<int>(unlockedPink.value);
    }
    if (unlockedOrange.present) {
      map['unlocked_orange'] = Variable<int>(unlockedOrange.value);
    }
    if (unlockedPurple.present) {
      map['unlocked_purple'] = Variable<int>(unlockedPurple.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressCompanion(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('lastResetDate: $lastResetDate, ')
          ..write('loginQuestDone: $loginQuestDone, ')
          ..write('loginQuestClaimed: $loginQuestClaimed, ')
          ..write('learnQuestDone: $learnQuestDone, ')
          ..write('learnQuestClaimed: $learnQuestClaimed, ')
          ..write('cardsLearnedToday: $cardsLearnedToday, ')
          ..write('reviewQuestDone: $reviewQuestDone, ')
          ..write('reviewQuestClaimed: $reviewQuestClaimed, ')
          ..write('allDailyQuestsDone: $allDailyQuestsDone, ')
          ..write('allDailyQuestsClaimed: $allDailyQuestsClaimed, ')
          ..write('unlockedGreen: $unlockedGreen, ')
          ..write('unlockedBlue: $unlockedBlue, ')
          ..write('unlockedYellow: $unlockedYellow, ')
          ..write('unlockedPink: $unlockedPink, ')
          ..write('unlockedOrange: $unlockedOrange, ')
          ..write('unlockedPurple: $unlockedPurple')
          ..write(')'))
        .toString();
  }
}

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final Decks decks = Decks(this);
  late final Flashcards flashcards = Flashcards(this);
  late final Reviews reviews = Reviews(this);
  late final UserProgress userProgress = UserProgress(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    decks,
    flashcards,
    reviews,
    userProgress,
  ];
  @override
  int get schemaVersion => 2;
}
