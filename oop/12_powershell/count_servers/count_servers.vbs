set fso = CreateObject("Scripting.FileSystemObject")
dim errcount() ' ���������� ������� � ������������ ���������� �������
max_names = 20 ' ��������� �������������� ����� ��� 20 ����
redim errcount(2, max_names)
n_names = 0 ' ���� ���� � ������ ���
set strm = fso.OpenTextFile("servers.txt")
do while not strm.AtEndOfStream ' ������������ ���� ������� � �������
  servername = strm.ReadLine() ' ��������� ����� ������� �� ������ �������
                               ' � ����������� ��� �������� ������
  for i = 1 to n_names ' ��� ��� ���� � ������?
    if errcount(1,i) = servername then ' ��, ����� ������
      errcount(2,i) = errcount(2,i)+1 ' ���������� ��� �������� ������
      exit for
    end if
  next
  if i > n_names then ' �� �������, ����� �������� ��� ���
    if n_names = max_names then ' ������ �����, �������� ��� ������
      max_names = max_names+20
      redim preserve errcount(2,max_names)
    end if
    n_names = n_names+1 ' ���������� ������ ����� � ������
    errcount(1, n_names) = servername
    errcount(2, n_names) = 1 ' ��������� �������� ������ � 1
  end if
loop
strm.Close

' � ������ ����� ������ ���������
wscript.echo "������" & vbTab & "���������� ������ "
for i = 1 to n_names
  wscript.echo errcount(1,i) & vbTab & cstr(errcount(2,i))
next
