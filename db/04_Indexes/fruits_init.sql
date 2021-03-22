CREATE TABLE Fruits(
  Fruit TEXT,
  State TEXT,
  Price REAL
);

INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (1, 'Orange', 'FL', 0.85);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (2, 'Apple', 'NC', 0.45);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (4, 'Peach', 'SC', 0.6);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (5, 'Grape', 'CA', 0.8);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (18, 'Lemon', 'FL', 1.25);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (19, 'Strawberry', 'NC', 2.45);
INSERT INTO Fruits (rowid, Fruit, State, Price) VALUES (23, 'Orange', 'CA', 1.05);


CREATE INDEX Idx1 ON fruits(fruit);
CREATE INDEX Idx2 ON fruits(state);
CREATE INDEX Idx3 ON Fruits(fruit, state);
CREATE INDEX Idx4 ON Fruits(fruit, state, price);
