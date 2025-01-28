unit StackUnit;

interface

type
  TStack = Pointer;  // Указатель на структуру стека, чтобы скрыть её реализацию

// Процедуры и функции для работы со стеком
procedure Push(S: TStack; Value: Integer);
function Pop(S: TStack): Integer;
function IsEmpty(S: TStack): Boolean;
function Top(S: TStack): Integer;
procedure FreeStack(var S: TStack);

implementation

type
  PNode = ^TNode;
  TNode = record
    Data: Integer;
    Next: PNode;
  end;

// Внутренняя реализация структуры стека
type
  TStackImpl = record
    Head: PNode;
  end;

// Функция создания нового стека
function NewStack(): TStack;
begin
  New(Result);
  with TStackImpl(Result)^ do
    Head := nil;
end;

// Процедура добавления элемента в стек
procedure Push(S: TStack; Value: Integer);
var
  Node: PNode;
begin
  New(Node);
  Node^.Data := Value;
  Node^.Next := TStackImpl(S)^.Head;
  TStackImpl(S)^.Head := Node;
end;

// Функция извлечения верхнего элемента из стека
function Pop(S: TStack): Integer;
var
  Node: PNode;
begin
  if not IsEmpty(S) then begin
    Node := TStackImpl(S)^.Head;
    Result := Node^.Data;
    TStackImpl(S)^.Head := Node^.Next;
    Dispose(Node);
  end else
    raise Exception.Create('Стек пуст');
end;

// Проверка, является ли стек пустым
function IsEmpty(S: TStack): Boolean;
begin
  Result := TStackImpl(S)^.Head = nil;
end;

// Получение значения верхнего элемента стека без удаления
function Top(S: TStack): Integer;
begin
  if not IsEmpty(S) then
    Result := TStackImpl(S)^.Head^.Data
  else
    raise Exception.Create('Стек пуст');
end;

// Освобождение памяти, занятой стеком
procedure FreeStack(var S: TStack);
var
  Node: PNode;
begin
  while TStackImpl(S)^.Head <> nil do begin
    Node := TStackImpl(S)^.Head;
    TStackImpl(S)^.Head := Node^.Next;
    Dispose(Node);
  end;
  Dispose(S);
  S := nil;
end;

end.
