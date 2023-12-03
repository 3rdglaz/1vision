package recipe.one

open abstract class AggregateRoot<ID: Identifier>(id: ID) : Entity<ID>(id)