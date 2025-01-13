
with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Tests_Genealogic_Tree is

  silent : Boolean := True;

begin

  -- 1. Create a tree with only the root
  -- 2. Add a parent to the root
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
