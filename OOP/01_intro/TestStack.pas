rogram TestStack;

uses
  StackUnit;

var
  S: TStack;
  Value: Integer;

begin
  // Создаем новый стек
  S := NewStack();

  // Добавляем несколько элементов в стек
  Push(S, 10);
  Push(S, 20);
  Push(S, 30);

  // Извлекаем элементы из стека
  while not IsEmpty(S) do begin
    WriteLn(Pop(S));
  end;

  // Освобождаем память, занятую стеком
  FreeStack(S);
end.
