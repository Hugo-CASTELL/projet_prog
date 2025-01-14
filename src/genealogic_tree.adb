with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

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

	-- Add parent
	procedure AddParent(Tree: in out T_Genealogic_Tree; ID: in Integer; IsFemale : in Boolean) is
  begin
    Null;
  end AddParent;

	-- Delete persons of the tree
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) is
  begin
    Null;
  end DeletePerson;

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer is
  begin
    return Person.ID;
  end GetID;

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) is
  begin
    return Integer;
  end NumberAncestors;

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Integer) is
  begin
    return T_Tab_Person;
  end AncestorsGen;

	-- Print the tree
	procedure PrintTree(Tree: in out T_Genealogic_Tree) is
  begin
    Null;
  end PrintTree;

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Integer) is
  begin
    return T_Tab_Person;
  end PersonsWithXParents;



  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

end Genealogic_Tree;
