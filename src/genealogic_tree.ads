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

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer; 

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

end Genealogic_Tree;
