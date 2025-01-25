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

  -- ### Functions ###

  -- Check if a person is null
  function Is_Null(Person : T_Person) return Boolean is
  begin
    return Person = null;
  end Is_Null;

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
	procedure DeletePerson(Tree: in out T_Genealogic_Tree; Person: in out T_Person) is
    searched_node : T_Genealogic_Tree;
    current_node : T_Genealogic_Tree;
    node_left : T_Genealogic_Tree;
    node_right : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
  begin
    -- Init
    current_gen.Add(Tree);

    -- Search the person to delete
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          Put_Line("Searching parent node");
          current_node := Get(current_gen, i);
          node_left  := GetLeft(current_node);
          node_right := GetRight(current_node);
          if ((GetID(GetData(current_node)) = GetID(Person)) or
              (IsEmpty(node_left) = False and GetID(GetData(node_left)) = GetID(Person)) or
              (IsEmpty(node_right) = False and GetID(GetData(node_right)) = GetID(Person)))
          then
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
      node_left  := GetLeft(searched_node);
      node_right := GetRight(searched_node);

      if (GetID(GetData(searched_node)) = GetID(Person)) then
        Put_Line("Deleting parent node");
        Delete(searched_node);
      elsif (IsEmpty(node_left) = False and GetID(GetData(node_left)) = GetID(Person)) then
        Put_Line("Deleting left node");
        ClearLeft(searched_node);
      elsif (IsEmpty(node_right) = False and GetID(GetData(node_right)) = GetID(Person)) then
        Put_Line("Deleting right node");
        ClearRight(searched_node);
      end if;
    Put_Line("Deleting person node with data: " & searched_node'Image);

      -- Clear any remaining references in lists
      Clear(current_gen);
      Clear(next_gen);
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
    return IsEmpty(searched_node) = False;
    
  end FindInTree;

end Genealogic_Tree;
