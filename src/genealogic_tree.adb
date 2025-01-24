with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body Genealogic_Tree is

  -- #----------#
  -- # T_Person #
  -- #----------#

  -- ### Constructor ###

	-- Initializes a person
	procedure Init(Person: in out T_Person; ID: in Natural) is
  begin
    Person := new T_Person_Fields'(ID => ID);
  end Init;

  -- ### Getters / Setters ###

	-- Returns the id of the person
	function GetID (Person: in T_Person) return Natural is
  begin
    return Person.ID;
  end GetID;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

	-- Add parent
	procedure AddParentById(Tree: in out T_Genealogic_Tree; ID_Person: in Natural; IsFemale: in Boolean) is
    Person : T_Person;
  begin
    Init(Person, ID_Person);
    AddParentByPerson(Tree, Person, IsFemale);
  end AddParentById;

	-- Add parent
	procedure AddParentByPerson(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean) is
  begin
    if IsFemale then
      SetRight(Tree, Person);
    else
      SetLeft(Tree, Person);
    end if;
  end AddParentByPerson;

	-- Delete persons of the tree 
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in T_Person) is
    searched_node : T_Genealogic_Tree;
    current_node : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
  begin
    -- Init
    current_gen.Add(Tree);

    -- Search the person to delete
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          current_node := Get(current_gen, i);
          if GetID(GetData(current_node)) = GetID(Person) then
            searched_node := current_node;
          else
            if (IsBranchEmpty (current_node, False) = False) then
              Add(next_gen, GetLeft(current_node));
            end if;
            if (IsBranchEmpty (current_node, True) = False) then
              Add(next_gen, GetRight(current_node));
            end if;
          end if;
        end if;
      end loop;

      Clear(current_gen);
      Concat (current_gen, next_gen);
      Clear(next_gen);
    end loop;

    -- if the person was found
    if (IsEmpty(searched_node) = False) then
      Delete(searched_node);
      if IsEmpty(searched_node) then
        Put_Line("TestDelete");
      end if;
    end if;

  end DeletePerson;

	-- Returns the number of ancestors of the person, him included
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Natural is
  begin
    return 0;
  end NumberAncestors;

	-- Returns all the ID of the ancestors of the person
	function AncestorsGen(Tree: in T_Genealogic_Tree; Person: in T_Person; Generation: in Natural) return T_List_Person is
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
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Natural) return T_List_Person is
    todo: T_List_Person;
  begin
    return todo;
  end PersonsWithXParents;

	-- Determinates if the person is in tree
	function FindInTree(Tree: in T_Genealogic_Tree; ID: Natural) return Boolean is
    searched_node : T_Genealogic_Tree;
    current_node : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
  begin
    -- Init
    current_gen.Add(Tree);

    -- Search the person to delete
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          current_node := Get(current_gen, i);
          if GetID(GetData(current_node)) = ID then
            searched_node := current_node;
          else
            if (IsBranchEmpty (current_node, False) = False) then
              Add(next_gen, GetLeft(current_node));
            end if;
            if (IsBranchEmpty (current_node, True) = False) then
              Add(next_gen, GetRight(current_node));
            end if;
          end if;
        end if;
      end loop;

      Clear(current_gen);
      Concat (current_gen, next_gen);
      Clear(next_gen);
    end loop;

    -- if the person was found
    return IsEmpty(searched_node);
    
  end FindInTree;

end Genealogic_Tree;
