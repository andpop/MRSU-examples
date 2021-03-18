CREATE TABLE Fruits(
  Fruit TEXT,
  State TEXT,
  Price REAL
);

INSERT INTO Fruits values('Orange', 'FL', 0.85), ('Apple', 'NC', 0.45), ('Peach', 'SC', 0.6), ('Grape', 'CA', 0.8), ('Lemon', 'FL', 1.25), ('Strawberry', 'NC', 2.45), ('Orange', 'CA', 1.05);


SELECT price FROM fruits WHERE fruit='Peach';

CREATE INDEX Idx1 ON fruits(fruit);
