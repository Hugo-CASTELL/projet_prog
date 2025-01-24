with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_Genealogic_Tree is

  silent : Boolean := True;
  Genealogic_Tree : T_Genealogic_Tree;
  Test : T_Genealogic_Tree;
  Person : T_Person;
  Person2 : T_Person;
  ID : Natural;
begin
  ID := 0;

  -- 1. Create a tree with only the root
  Init(Person, ID);
  Init(Genealogic_Tree, Person);

  ID := ID + 1;
  pragma Assert(GetSize(Genealogic_Tree) = 1);
  pragma Assert(GetID(GetData(Genealogic_Tree)) = 0);

  -- 2. Add a parent to the root
  AddParentById(Genealogic_Tree, ID, True);
  ID := ID + 1;
  AddParentById(Genealogic_Tree, ID, False);
  ID := ID + 1;

  pragma Assert(GetSize(Genealogic_Tree) = 3);
  pragma Assert(FindInTree(Genealogic_Tree, 1) = True);
  pragma Assert(FindInTree(Genealogic_Tree, 2) = True);

  -- 3. Obtain the ancestors number of the root (Root included) 
  -- 4. Obtain the ancestors at a certain level from the root
  -- 5. Print the tree from a certain node 

  -- 6. Delete one node and all of its ancestors
  Test := GetLeft(Genealogic_Tree);
  AddParentById(Test, ID, True);
  ID := ID + 1;
  AddParentById(Test, ID, False);
  ID := ID + 1;
  Person2 := GetData(Test);
  pragma Assert(GetSize(Genealogic_Tree) = 5);
  DeletePerson(Genealogic_Tree, Person2);

  Put_Line("Is Empty Root Left: " & IsEmpty(GetLeft(Genealogic_Tree))'Image); -- False, it should be empty ????
  Put_Line("Data Root Left: " & GetData(GetLeft(Genealogic_Tree))'Image); -- Address but should have been freed wtf ????

  Put_Line("Is Empty Root Right: " & IsEmpty(GetRight(Genealogic_Tree))'Image);
  Put_Line("Data Root Right: " & GetData(GetRight(Genealogic_Tree))'Image);
  Put_Line(GetSize(Genealogic_Tree)'Image);
  -- pragma Assert(GetSize(Genealogic_Tree) = 2);
  Put_Line("Passage GetSize");

  pragma Assert(IsBranchEmpty(Genealogic_Tree, True) = True);
  pragma Assert(IsBranchEmpty(Genealogic_Tree, False) = False);

  -- 7. Obtain all of the ancestors with : Only one parent known 
  -- 8. Obtain all of the ancestors with : The two parents known
  -- 9. Obtain all of the ancestors with : The two parents unknown
  if (silent = False) then
    Put_Line("TODO");
  end if;

end Tests_Genealogic_Tree;
