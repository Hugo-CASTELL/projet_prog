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

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Integer is
  begin
    return Person.ID;
  end GetID;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

end Genealogic_Tree;
