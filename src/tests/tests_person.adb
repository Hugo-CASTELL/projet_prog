with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_Person is

  Person : T_Person;

begin
  Init (Person, 1);

  -- Testing initialisation
  pragma Assert(GetID(Person) = 1);

end Tests_Person;
