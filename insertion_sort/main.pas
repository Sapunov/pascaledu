uses
  DebugUnit;

const
  maxN = 100;

type
  sortable = array[0..maxN] of sortItem;
  settings = record
    shell: boolean;
    demo: boolean;
    output: boolean;
    interactive: boolean;
  end;

procedure InputSequence(var arr: sortable; n: integer; env: settings);
var
  i: integer;
begin
  if env.interactive then writeln('Ввод последовательности');
  for i := 0 to n - 1 do begin
    InputItem(arr[i], env.interactive);
  end;
end;

procedure OutputSequence(var arr: sortable; n: integer; interactive: boolean; demo: boolean);
var
  i: integer;
begin
  if interactive then writeln('Вывод последовательности');
  for i := 0 to n - 1 do begin
    PrintItem(arr[i], demo);
  end;
  if demo then writeln;
end;

procedure InsertionSort(var arr: sortable; n: integer; var comps: integer; var moves: integer; env: settings);
var
  i, j: integer;
  tmp: sortItem;
begin
  comps := 0;
  moves := 0;
  if n > 1 then begin
    for i := 1 to n - 1 do begin
      AssignItem(tmp, arr[i], moves);
      j := i;
      while ((j > 0) and (IsGreater(arr[j - 1], tmp, comps))) do begin
        AssignItem(arr[j], arr[j - 1], moves);
        j := j - 1;
      end;
      AssignItem(arr[j], tmp, moves);
      if env.demo then OutputSequence(arr, n, false, true);
    end;
  end;
end;

procedure ShellSort(var arr: sortable; n: integer; var comps: integer; var moves: integer; env: settings);
var
  i, j, step: integer;
  tmp: sortItem;
begin
  comps := 0;
  moves := 0;

  step := n div 2;
  while step > 0 do begin
    for i := step to n - 1 do begin
      AssignItem(tmp, arr[i], moves);
      j := i;
      while (j >= step) and (IsGreater(arr[j - step], tmp, comps)) do begin
        AssignItem(arr[j], arr[j - step], moves);
        j := j - step;
      end;
      AssignItem(arr[j], tmp, moves);
    end;
    step := step div 2;
    if env.demo then OutputSequence(arr, n, false, true);
  end;
end;

procedure PrintHelp();
begin
  writeln('Usage: program [OPTIONS]');
  writeln('Options:');
  writeln(' -s'#9'Использовать сортировку Шелла вместо сортировки вставками');
  writeln(' -d'#9'Включить демонстрационный режим');
  writeln(' -o'#9'Выводить отсортированные данные');
  writeln(' -i'#9'Включить интерактивный режим (выводить подсказки)');
end;

function ParseArgs(var args: settings): boolean;
var
  i: integer;
  param: string;
  help: boolean;
begin
  help := false;
  args.shell := false;
  args.demo := false;
  args.output := false;
  args.interactive := false;

  if paramcount > 0 then begin
    for i := 1 to paramcount do begin
      param := paramstr(i);
      if param = '-s' then
        args.shell := true
      else if param = '-d' then
        args.demo := true
      else if param = '-o' then
        args.output := true
      else if param = '-i' then
        args.interactive := true
      else if param = '-h' then
        help := true;
    end;
  end;

  if help then begin
    PrintHelp();
    ParseArgs := false;
  end
  else ParseArgs := true
end;

var
  n: integer;
  arr: sortable;
  comparisons, moves: integer;
  args: settings;

begin
  if ParseArgs(args) then begin
    if args.interactive then write('Введите размер последовательности: ');
    readln(n);

    InputSequence(arr, n, args);

    if args.shell then begin
      writeln('# Используется сортировка Шелла');
      ShellSort(arr, n, comparisons, moves, args);
    end
    else begin
      writeln('# Используется простая сортировка вставками');
      InsertionSort(arr, n, comparisons, moves, args);
    end;

    if args.output then OutputSequence(arr, n, args.interactive, false);

    writeln('# Сравнений: ', comparisons);
    writeln('# Перемещений: ', moves);
  end;
end.
