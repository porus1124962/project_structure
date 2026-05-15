/// Abstract contract for all data-layer models.
///
/// Every model should:
///   • Be immutable (`final` fields, `const` constructor where possible).
///   • Implement [fromJson] as a factory constructor.
///   • Override [toJson] for serialisation.
///   • Override [==] and [hashCode] for reliable equality checks.
///   • Provide a [copyWith] method to safely update fields.
abstract class BaseModel {
  const BaseModel();

  /// Serialise to a JSON map.
  Map<String, dynamic> toJson();
}

