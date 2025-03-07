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

  -- Prints the person
	procedure PrintPerson(Person: in T_Person) is
  begin
    if Is_Null(Person) then
      return;
    end if;

    Put("{ ");
    Put("ID: " & GetID(Person)'Image);
    -- Put("; ");
    Put(" }");
  end PrintPerson;

  -- #-------------------#
  -- # T_Genealogic_Tree #
  -- #-------------------#

	-- Returns the tree corresponding to the person or null
	function FindPersonInTree(Tree: in T_Genealogic_Tree; ID: Natural) return T_Genealogic_Tree is
    searched_node : T_Genealogic_Tree;
    current_node : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
  begin
    -- Init
    current_gen.Add(Tree);

    -- Searching by generation
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          current_node := Get(current_gen, i);
          if GetID(GetData(current_node)) = ID then
            searched_node := current_node;
          else
            if (IsBranchEmpty (current_node, True) = False) then
              Add(next_gen, GetLeft(current_node));
            end if;
            if (IsBranchEmpty (current_node, False) = False) then
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
    return searched_node;
    
  end FindPersonInTree;

	-- Add parent with an id
	procedure AddParentById(Tree: in out T_Genealogic_Tree; ID_Person: in Natural; IsFemale: in Boolean) is
    Person : T_Person;
  begin
    Init(Person, ID_Person);
    AddParentByPerson(Tree, Person, IsFemale);
  end AddParentById;

	-- Add parent with a struct
	procedure AddParentByPerson(Tree: in out T_Genealogic_Tree; Person: in T_Person; IsFemale: in Boolean) is
  begin
    if IsFemale then
      SetRight(Tree, Person);
    else
      SetLeft(Tree, Person);
    end if;
  end AddParentByPerson;

	-- Delete person and its ancestors from the tree  
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

    -- Search the child person to delete the parent with a clear
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          current_node := Get(current_gen, i);
          node_left  := GetLeft(current_node);
          node_right := GetRight(current_node);
          if (GetID(GetData(current_node)) = GetID(Person)) then
            searched_node := current_node;
          elsif (IsEmpty(node_left) = False) then
            if GetID(GetData(node_left)) = GetID(Person) then
              searched_node := current_node;
            end if;
          elsif (IsEmpty(node_right) = False) then
            if GetID(GetData(node_right)) = GetID(Person) then
              searched_node := current_node;
            end if;
          else
            if (IsBranchEmpty (current_node, True) = False) then
              Add(next_gen, GetLeft(current_node));
            end if;
            if (IsBranchEmpty (current_node, False) = False) then
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
        Delete(searched_node);
      elsif (IsEmpty(node_left) = False and GetID(GetData(node_left)) = GetID(Person)) then
        ClearLeft(searched_node);
      elsif (IsEmpty(node_right) = False and GetID(GetData(node_right)) = GetID(Person)) then
        ClearRight(searched_node);
      end if;

      -- Clear any remaining references in lists
      Clear(current_gen);
      Clear(next_gen);
    end if;

  end DeletePerson;

	-- Returns the number of ancestors of the person, him included
	function NumberAncestors(Tree: in T_Genealogic_Tree; Person: in T_Person) return Natural is
    searched_node : T_Genealogic_Tree;
  begin
    searched_node := FindPersonInTree(Tree, GetID(Person));
    if (IsEmpty(searched_node) = False) then
      return GetSize(searched_node);
    else
      return 0;
    end if;
  end NumberAncestors;

	-- Returns all the ancestors of the person at certain generation
	function AncestorsGen(Tree: in T_Genealogic_Tree; Generation: in Natural) return T_List_Person is
    current_node : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
    corresponding_persons: T_List_Person;
    current_gen_number: Natural;
  begin
    -- Init
    current_gen.Add(Tree);
    current_gen_number := 1;

    -- Stacking generation in a list until the desired generation (stop if the list is empty)
    while ((IsEmpty(current_gen) = False) and (current_gen_number /= Generation)) loop
      for i in 1..GetSize(current_gen) loop
        current_node := Get(current_gen, i);
        if (IsBranchEmpty (current_node, True) = False) then
          Add(next_gen, GetLeft(current_node));
        end if;
        if (IsBranchEmpty (current_node, False) = False) then
          Add(next_gen, GetRight(current_node));
        end if;
      end loop;

      Clear(current_gen);
      Concat (current_gen, next_gen);
      Clear(next_gen);
      current_gen_number := current_gen_number + 1;
    end loop;

    for i in 1..GetSize(current_gen) loop
      Add(corresponding_persons, GetData(Get(current_gen, i)));
    end loop;

    return corresponding_persons;

  end AncestorsGen;

	procedure Print(Tree: in T_Genealogic_Tree; Generation : in Natural) is
  begin
    if IsEmpty(Tree) then
      return;
    end if;

    for i in 1..Generation loop
      Put("    ");
    end loop;
    Put("-- ");
    PrintPerson(GetData(Tree));
    Put_Line(" ");

    -- Recursive print
    if (IsBranchEmpty (Tree, False) = False) then
      Print(GetRight(Tree), Generation + 1);
    end if;
    if (IsBranchEmpty (Tree, True) = False) then
      Print(GetLeft(Tree), Generation + 1);
    end if;

  end Print;

	-- Print the tree
	procedure PrintTree(Tree: in T_Genealogic_Tree) is
  begin
    Print(Tree, 0);
  end PrintTree;

	-- Returns the persons who don't have parents
	function PersonsWithXParents(Tree: in T_Genealogic_Tree; NumberParent: in Natural) return T_List_Person is
    searched_node : T_Genealogic_Tree;
    current_node : T_Genealogic_Tree;
    current_gen : T_List_Genealogic_Tree;
    next_gen : T_List_Genealogic_Tree;
    corresponding_persons: T_List_Person;
    number_of_parents: Natural;
  begin
    -- Init
    current_gen.Add(Tree);

    -- Search the person to delete
    while (IsEmpty(searched_node) and (IsEmpty(current_gen) = False)) loop
      for i in 1..GetSize(current_gen) loop
        if IsEmpty(searched_node) then
          number_of_parents := 0;
          current_node := Get(current_gen, i);

          if (IsBranchEmpty (current_node, True) = False) then
            number_of_parents := number_of_parents + 1;
            Add(next_gen, GetLeft(current_node));
          end if;
          if (IsBranchEmpty (current_node, False) = False) then
            number_of_parents := number_of_parents + 1;
            Add(next_gen, GetRight(current_node));
          end if;

          if number_of_parents = NumberParent then
            Add(corresponding_persons, GetData(current_node));
          end if;

        end if;
      end loop;

      Clear(current_gen);
      Concat (current_gen, next_gen);
      Clear(next_gen);
    end loop;

    return corresponding_persons;

  end PersonsWithXParents;

	-- Determinates if the person is in tree
	function FindInTree(Tree: in T_Genealogic_Tree; ID: Natural) return Boolean is
  begin
    return IsEmpty(FindPersonInTree(Tree, ID)) = False;
  end FindInTree;

end Genealogic_Tree;
