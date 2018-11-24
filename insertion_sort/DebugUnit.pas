unit DebugUnit;

interface
type
  sortItem = record
    Digit: integer;
  end;

function IsGreater(lhs: sortItem; rhs: sortItem; var comps: integer): boolean;
procedure AssignItem(var target: sortItem; source: sortItem; var moves: integer);
procedure InputItem(var item: sortItem; interactive: boolean);
procedure PrintItem(var item: sortItem; demo: boolean);

implementation
function IsGreater(lhs: sortItem; rhs: sortItem; var comps: integer): boolean;
begin
  IsGreater := lhs.Digit > rhs.Digit;

  comps := comps + 1;
end;

procedure AssignItem(var target: sortItem; source: sortItem; var moves: integer);
begin
  target.Digit := source.Digit;

  moves := moves + 1;
end;

procedure InputItem(var item: sortItem; interactive: boolean);
begin
  read(item.Digit);
end;

procedure PrintItem(var item: sortItem; demo: boolean);
begin
  if demo then
    write(item.Digit, ' ')
  else
    writeln('DigitItem: Digit=', item.Digit);
end;

end.
