with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;

package body Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Integer) is
  begin
    Person := new T_Person_Fields'(ID => ID);
  end Init;

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer is
  begin
    return Person.ID;
  end GetID;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

	-- Add parent
	procedure AddParent(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean) is
  begin
    if IsFemale then
      SetRight(Tree, Person);
    else
      SetLeft(Tree, Person);
    end if;
  end AddParent;

	-- Delete persons of the tree 
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) is
  begin
    Null;
  end DeletePerson;

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Integer is
  begin
    return 0;
  end NumberAncestors;

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Integer) return T_List_Person is
    todo: T_List_Person;
  begin
    return todo;
  end AncestorsGen;

	-- Print the tree
	procedure PrintTree(Tree: in T_Genealogic_Tree) is
  begin
    Null;
  end PrintTree;

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Integer) return T_List_Person is
    todo: T_List_Person;
  begin
    return todo;
  end PersonsWithXParents;

	-- Determinates if the person is in tree
	function FindInTree(Tree: in T_Genealogic_Tree; ID: Integer) return Boolean is
    -- searched_node : T_Genealogic_Tree := Null;
    -- current_gen : T_Tab_Genealogic_Tree;
    -- next_gen : T_Tab_Genealogic_Tree;
  begin
    -- return searched_node /= Null;
    return True;
  end FindInTree;

end Genealogic_Tree;
