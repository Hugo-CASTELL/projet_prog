package Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Type and Exceptions ###

	type T_Person is limited private;

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Integer) with
		Post => GetID(Person) = ID;

	-- Add parent
	procedure AddParent(Tree: in out T_Genealogic_Tree; ID: in Integer; IsFemale : in Boolean) with

	-- Delete persons of the tree
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) with

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer;

	-- Returns the number of ancestors of the person
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Integer;

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Integer) return T_Tab_Person;

	-- Print the tree
	procedure PrintTree(Tree: in out T_Genealogic_Tree) with

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Integer) return T_Tab_Person;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

  -- ### Type and Exceptions ###

	package Genealogic_Tree_Of_Persons is
	  new Binary_Tree (T_Data => T_Person);
	use Genealogic_Tree_Of_Persons;

	subtype T_Genealogic_Tree is Genealogic_Tree_Of_Persons.T_Tree;

  -- ### Functions ###

  private

	type T_Person_Fields;
	type T_Person is access T_Person_Fields;
	type T_Person_Fields is
		record
			ID: Integer;
		end record;
	type T_Tab_Person is array (1..100) of T_Person;

end Genealogic_Tree;
