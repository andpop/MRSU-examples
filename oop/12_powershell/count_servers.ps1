$errcount = @{} # �������� ������ ���-�������

# ��������� ����� �� ����� � �������
get-content '.\servers.txt' | foreach {$errcount[$_]++}

$errcount | Sort-Object Name
