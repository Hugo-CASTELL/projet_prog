with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_Genealogic_Tree is

  silent : Boolean := True;
  Genealogic_Tree : T_Genealogic_Tree;
  Person : T_Person;
  ID : Natural;
begin
  ID := 0;

  -- 1. Create a tree with only the root
  Init(Person, ID);
  Init(Genealogic_Tree, Person);

  ID := ID + 1;
  pragma Assert(GetSize(Genealogic_Tree) = 1);

  -- 2. Add a parent to the root
  AddParentById(Genealogic_Tree, ID, True);
  ID := ID + 1;
  AddParentById(Genealogic_Tree, ID, False);
  ID := ID + 1;

  pragma Assert(GetSize(Genealogic_Tree) = 3);

  -- 3. Obtain the ancestors number of the root (Root included) 
  -- 4. Obtain the ancestors at a certain level from the root
  -- 5. Print the tree from a certain node 
  -- 6. Delete one node and all of its ancestors 
  -- 7. Obtain all of the ancestors with : Only one parent known 
  -- 8. Obtain all of the ancestors with : The two parents known
  -- 9. Obtain all of the ancestors with : The two parents unknown
  if (silent = False) then
    Put_Line("TODO");
  end if;

end Tests_Genealogic_Tree;
