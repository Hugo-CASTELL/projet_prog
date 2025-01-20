with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_List is

  List : T_List_Person;

begin
  Init(List);

  -- Testing initialisation
  pragma Assert(GetSize(List) = 0);

end Tests_List;
