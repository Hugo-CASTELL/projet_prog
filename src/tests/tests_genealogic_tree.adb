with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_Genealogic_Tree is
  Genealogic_Tree : T_Genealogic_Tree;
  Test : T_Genealogic_Tree;
  Person : T_Person;
  Person2 : T_Person;
  List_Persons : T_List_Person;
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
  pragma Assert(NumberAncestors(Genealogic_Tree, GetData(Genealogic_Tree)) = 3);

  -- 4. Obtain the ancestors at a certain level from the root
  Clear(List_Persons);
  List_Persons := AncestorsGen(Genealogic_Tree, 0);
  pragma Assert(GetSize(List_Persons) = 1);
  Clear(List_Persons);
  List_Persons := AncestorsGen(Genealogic_Tree, 1);
  pragma Assert(GetSize(List_Persons) = 2);
  Clear(List_Persons);
  List_Persons := AncestorsGen(Genealogic_Tree, 2);
  pragma Assert(GetSize(List_Persons) = 0);

  -- 5. Print the tree from a certain node 
  PrintTree(Genealogic_Tree);

  -- 6. Delete one node and all of its ancestors
  Test := GetLeft(Genealogic_Tree);
  AddParentById(Test, ID, True);
  ID := ID + 1;
  AddParentById(Test, ID, False);
  ID := ID + 1;
  Person2 := GetData(Test);
  pragma Assert(GetSize(Genealogic_Tree) = 5);
  DeletePerson(Genealogic_Tree, Person2);

  pragma Assert(IsBranchEmpty(Genealogic_Tree, True) = True);
  pragma Assert(IsBranchEmpty(Genealogic_Tree, False) = False);

  -- 7. Obtain all of the ancestors with : Only one parent known 
  AddParentById(Genealogic_Tree, ID, False);
  ID := ID + 1;
  Test := GetLeft(Genealogic_Tree);
  AddParentById(Test, ID, True);
  ID := ID + 1;
  AddParentById(Test, ID, False);
  ID := ID + 1;
  Test := GetRight(Genealogic_Tree);
  AddParentById(Test, ID, True);
  ID := ID + 1;

  Clear(List_Persons);
  List_Persons := PersonsWithXParents(Genealogic_Tree, 1);
  pragma Assert(GetSize(List_Persons) = 1);

  -- 8. Obtain all of the ancestors with : The two parents known
  Clear(List_Persons);
  List_Persons := PersonsWithXParents(Genealogic_Tree, 2);
  pragma Assert(GetSize(List_Persons) = 2);

  -- 9. Obtain all of the ancestors with : The two parents unknown
  Clear(List_Persons);
  List_Persons := PersonsWithXParents(Genealogic_Tree, 0);
  pragma Assert(GetSize(List_Persons) = 3);

end Tests_Genealogic_Tree;
