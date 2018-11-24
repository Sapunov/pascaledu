unit DataUnit;

interface
type
  sortItem = record
    Name: string;
    Surname: string;
    Group: string;
    Birth: string;
  end;

function IsGreater(lhs: sortItem; rhs: sortItem; var comps: integer): boolean;
procedure AssignItem(var target: sortItem; source: sortItem; var moves: integer);
procedure InputItem(var item: sortItem; interactive: boolean);
procedure PrintItem(var item: sortItem; demo: boolean);

implementation
procedure ExtractDateParts(dateString: string; var day: integer; var month: integer; var year: integer);
var
  code: integer;
begin
  val(copy(dateString, 1, 2), day, code);
  val(copy(dateString, 4, 2), month, code);
  val(copy(dateString, 7, 4), year, code);
end;

function IsGreater(lhs: sortItem; rhs: sortItem; var comps: integer): boolean;
var
  d, m, y: integer;
  lhsIntRepr, rhsIntRepr: integer;
begin
  ExtractDateParts(lhs.Birth, d, m, y);
  lhsIntRepr := y * 1000 + m * 100 + d;

  ExtractDateParts(rhs.Birth, d, m, y);
  rhsIntRepr := y * 1000 + m * 100 + d;

  IsGreater := lhsIntRepr > rhsIntRepr;

  comps := comps + 1;
end;

procedure AssignItem(var target: sortItem; source: sortItem; var moves: integer);
begin
  target.Name := source.Name;
  target.Surname := source.Surname;
  target.Group := source.Group;
  target.Birth := source.Birth;

  moves := moves + 1;
end;

procedure InputItem(var item: sortItem; interactive: boolean);
begin
  if interactive then writeln('Ввод информации о студенте.');
  if interactive then write('Введите имя: ');
  readln(item.Name);
  if interactive then write('Введите фамилию: ');
  readln(item.Surname);
  if interactive then write('Введите номер группы: ');
  readln(item.Group);
  if interactive then write('Введите дату рождения в формате dd.mm.yyyy: ');
  readln(item.Birth);
end;

procedure PrintItem(var item: sortItem; demo: boolean);
begin
  if demo then
    writeln(item.Name, ' ', item.Surname, ' ', item.Group, ' ', item.Birth)
  else begin
    write('Студент: ', item.Name, ' ', item.Surname);
    writeln('. Группа: ', item.Group, '. Дата рождения: ', item.Birth);
  end
end;

end.
