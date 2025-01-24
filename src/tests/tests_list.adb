with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_List is

  List : T_List_Person;
  PersonVar : T_Person;
  PersonVar2 : T_Person;
  SizeVar : Natural;
  List1 : T_List_Person;
  List2 : T_List_Person;
  SizeList1 : Natural;
  SizeList2 : Natural;

begin
  
  -- Testing initialisation
  Init(List);
  pragma Assert(GetSize(List) = 0);

  -- Test Add
  PersonVar := new T_Person_Fields'(ID => 65);
  Add(List, PersonVar);
  pragma Assert(Get(List, GetSize(List)) = PersonVar);
  PersonVar := new T_Person_Fields'(ID => 32);
  Add(List, PersonVar);
  pragma Assert(Get(List, GetSize(List)) = PersonVar);
  PersonVar := new T_Person_Fields'(ID => 21);
  Add(List, PersonVar);
  pragma Assert(Get(List, GetSize(List)) = PersonVar);

  -- Test Delete
  SizeVar := GetSize(List);
  PersonVar := Get(List, 2);
  Delete(List, 2);
  pragma Assert(GetSize(List) = SizeVar - 1);
  pragma Assert(Get(List, 2) /= PersonVar);

  -- Test Modify
  PersonVar := new T_Person_Fields'(ID => 12);
  pragma Assert(Get(List, 1) /= PersonVar);
  Modify(List, PersonVar, 1);
  pragma Assert(Get(List, 1) = PersonVar);

  -- Test Insert
  SizeVar := GetSize(List);
  PersonVar2 := Get(List, 2);
  PersonVar := new T_Person_Fields'(ID => 40);
  Insert(List, PersonVar, 2);
  pragma Assert(GetSize(List) = SizeVar + 1);
  pragma Assert(Get(List, 2) = PersonVar);
  pragma Assert(Get(List, 3) = PersonVar2);

  -- Test Concat
  Init(List1);
  Init(List2);
  Add(List1, new T_Person_Fields'(ID => 52));
  Add(List1, new T_Person_Fields'(ID => 87));
  Add(List1, new T_Person_Fields'(ID => 11));
  Add(List2, new T_Person_Fields'(ID => 38));
  Add(List2, new T_Person_Fields'(ID => 77));
  SizeList1 := GetSize(List1);
  SizeList2 := GetSize(List2);
  PersonVar := Get(List1, 2);
  Concat(List1, List2);
  pragma Assert(GetSize(List1) = (SizeList1 + SizeList2));
  pragma Assert(Get(List1, (SizeList1 + 1)) = Get(List2, 1));
  pragma Assert(Get(List1, 2) = PersonVar);

  -- Test Get
  Init(List);
  Add(List, new T_Person_Fields'(ID => 44));
  PersonVar := new T_Person_Fields'(ID => 26);
  Add(List, PersonVar);
  Add(List, new T_Person_Fields'(ID => 62));
  pragma Assert(Get(List, 2) = PersonVar);

  -- Test IsFull
  Init(List);
  for i in 1..99 loop
    Add(List, new T_Person_Fields'(ID => (100+i)));
  end loop;
  pragma Assert(IsFull(List) = False);
  Add(List, new T_Person_Fields'(ID => (90)));
  pragma Assert(IsFull(List) = True);

  -- Test IsEmpty
  Init(List);
  pragma Assert(IsEmpty(List) = True);
  Add(List, new T_Person_Fields'(ID => 27));
  pragma Assert(IsEmpty(List) = False);

  -- Test GetSize
  Init(List);
  pragma Assert(GetSize(List) = 0);
  for i in 1..23 loop
    Add(List, new T_Person_Fields'(ID => (100+i)));
  end loop;
  pragma Assert(GetSize(List) = 23);

  -- Test Clear
  Init(List);
  for i in 1..48 loop
    Add(List, new T_Person_Fields'(ID => (100+i)));
  end loop;
  pragma Assert(GetSize(List) /= 0);
  Clear(List);
  pragma Assert(GetSize(List) = 0);

end Tests_List;
