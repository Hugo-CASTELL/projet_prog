package Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Type and Exceptions ###

	type T_Person;
	type T_Person is
		record
			ID: Integer;
		end record;

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

end Genealogic_Tree;
