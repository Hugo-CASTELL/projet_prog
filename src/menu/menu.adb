with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;       use Ada.Strings.Unbounded;
with Genealogic_Tree;             use Genealogic_Tree;

procedure Menu is
  Root : T_Genealogic_Tree;
  Root_Person : T_Person;
  List_Persons : T_List_Person;

  ID : Natural;
  User_Choice : Integer;
  Next : Boolean;

  procedure GetUserChoice(Choice : in out Integer) is
    Text : Unbounded_String;
  begin
    Put("Enter your choice : ");
    Text := To_Unbounded_String(Get_Line);
    if (Length(Text) > 0) then
      begin
        Choice := Integer'Value(To_String(Text));
        -- Put_Line("Text :" & Text'Image);
        -- Put_Line("Choice : "Choice'Image);
      exception
        when Constraint_Error | Data_Error =>
          Choice := -1;
      end;
    else
      Choice := -1;
    end if;
    Put_Line("");
  end GetUserChoice;

  function CreatePerson(AutoID: in out Natural) return T_Person is
    Person : T_Person;
  begin
    Put_Line("Person creation");
    Put_Line("");
    Init(Person, AutoID);
    AutoID := AutoID + 1;
    return Person;
  end CreatePerson;

  procedure DisplayWithXParents(Root: T_Genealogic_Tree; Number_of_parents: in Natural) is
  begin
    Clear(List_Persons);
    List_Persons := PersonsWithXParents(Root, Number_of_parents);
    Put_Line("There are" & GetSize(List_Persons)'Image & " persons with exactly" & Number_of_parents'Image & " parents known");
    if (GetSize(List_Persons) /= 0) then
      Put_Line("");
      for i in 1..GetSize(List_Persons) loop
        PrintPerson(Get(List_Persons, i));
        Put_Line("");
      end loop;
    end if;
  end DisplayWithXParents;

  procedure DisplayGeneration(Root: T_Genealogic_Tree) is
    Internal_User_Choice : Integer;
    Generation : Natural;
  begin
    Internal_User_Choice := 1;
    Generation := 1;

    while (Internal_User_Choice > 0) loop
      Put_Line("X. Generation number");
      Put_Line("0. Back");
      Put_Line("");
      GetUserChoice(Internal_User_Choice);
      if (Internal_User_Choice > 0) then
        Generation := Internal_User_Choice;
      else
        Generation := 0;
      end if;
      case Generation is
        when 0 =>
          Put_Line("You are leaving the generation display");
          Put_Line("");
        when others =>
          Clear(List_Persons);
          List_Persons := AncestorsGen(Root, Generation);
          Put_Line("There are" & GetSize(List_Persons)'Image & " persons in the" & Generation'Image & "th generation");
          Put_Line("");
          if (GetSize(List_Persons) /= 0) then
            for i in 1..GetSize(List_Persons) loop
              PrintPerson(Get(List_Persons, i));
              Put_Line("");
            end loop;
            Put_Line("");
          end if;
      end case;
    end loop;
  end DisplayGeneration;

  procedure BranchDeletion(Root : in out T_Genealogic_Tree; AutoID: in out Natural) is
    Selected_Node : T_Genealogic_Tree;
    Selected_Person : T_Person;
    Internal_User_Choice : Integer;
    Next : Boolean;
  begin
    Internal_User_Choice := -1;
    Next := False;

    while (Internal_User_Choice /= 0) loop
      PrintTree(Root);
      Put_Line("");
      Put_Line("X. ID of the person that you want to delete");
      Put_Line("0. Back");
      Put_Line("");
      GetUserChoice(Internal_User_Choice);
      case Internal_User_Choice is
        when 0 =>
          Put_Line("You are leaving the person deletion");
          Put_Line("");
        when others =>
          Selected_Node := FindPersonInTree(Root, Internal_User_Choice);
          if (IsEmpty(Selected_Node) = false) then
            Put_Line("Person selected :");
            Selected_Person := GetData(Selected_Node);
            PrintPerson(Selected_Person);
            Put_Line("");
            DeletePerson(Root, Selected_Person);
            Put_Line("Ancestor deleted");
            Put_Line("");
            Internal_User_Choice := 0;
          else
            Put_Line("Invalid choice");
            Put_Line("");
          end if;
      end case;
    end loop;
  end BranchDeletion;

  procedure CountAncestors(Root : in T_Genealogic_Tree) is
    Selected_Node : T_Genealogic_Tree;
    Selected_Person : T_Person;
    Count : Natural;
    Internal_User_Choice : Integer;
    Next : Boolean;
  begin
    Internal_User_Choice := -1;
    Next := False;

    while (Internal_User_Choice /= 0) loop
      PrintTree(Root);
      Put_Line("");
      Put_Line("X. ID of the person that you want to count the ancestors");
      Put_Line("0. Back");
      Put_Line("");
      GetUserChoice(Internal_User_Choice);
      case Internal_User_Choice is
        when 0 =>
          Put_Line("You are leaving the counting ancestors menu");
          Put_Line("");
        when others =>
          Selected_Node := FindPersonInTree(Root, Internal_User_Choice);
          if (IsEmpty(Selected_Node) = false) then
            Put_Line("Person selected :");
            Selected_Person := GetData(Selected_Node);
            PrintPerson(Selected_Person);
            Put_Line("");
            Put_Line("");
            Count := NumberAncestors(Root, Selected_Person);
            Put_Line("This genealogic branch contains" & Count'Image & " person(s) (selected person included)");
            Put_Line("");
          else
            Put_Line("Invalid choice");
            Put_Line("");
          end if;
      end case;
    end loop;
  end CountAncestors;

  procedure AncestorCreation(Root : in out T_Genealogic_Tree; AutoID: in out Natural) is
    Selected_Node : T_Genealogic_Tree;
    Ancestor : T_Person;
    Internal_User_Choice : Integer;
    Next : Boolean;
  begin
    Internal_User_Choice := -1;
    Next := False;

    while (Internal_User_Choice /= 0) loop
      PrintTree(Root);
      Put_Line("");
      Put_Line("X. ID of the person to whom you want to add an ancestor");
      Put_Line("0. Back");
      Put_Line("");
      GetUserChoice(Internal_User_Choice);
      case Internal_User_Choice is
        when 0 =>
          Put_Line("You are leaving the ancestor creation");
          Put_Line("");
        when others =>
          Selected_Node := FindPersonInTree(Root, Internal_User_Choice);
          if (IsEmpty(Selected_Node) = false) then
            Put_Line("Person selected :");
            PrintPerson(GetData(Selected_Node));
            Put_Line("");
            Put_Line("");
            Put_Line("Ancestor creation");
            Put_Line("");
            while (Next = False) loop
              Put_Line("1. Mother");
              Put_Line("2. Father");
              Put_Line("0. To menu");
              Put_Line("");
              GetUserChoice(Internal_User_Choice);
              case Internal_User_Choice is
                when 1 | 2 | 0 =>
                  Next := True;
                when others =>
                  Put_Line("Invalid choice");
                  Put_Line("");
              end case;
            end loop;
            Next := False;
            while (Is_Null(Ancestor)) loop
              Ancestor := CreatePerson(AutoID);
            end loop;
            case Internal_User_Choice is
              when 1 =>
                AddParentByPerson(Selected_Node, Ancestor, True);
                Next := True;
              when 2 =>
                AddParentByPerson(Selected_Node, Ancestor, False);
                Next := True;
              when 0 =>
                Next := True;
              when others =>
                Put_Line("Invalid choice");
                Put_Line("");
            end case;
            Internal_User_Choice := 0;
            Put_Line("Ancestor added");
            Put_Line("");
          else
            Put_Line("Invalid choice");
            Put_Line("");
          end if;
      end case;
    end loop;

  end AncestorCreation;

begin
  ID := 1;
  User_Choice := -1;
  Next := False;

  -- #               #
  -- # Root creation #
  -- #               #
  while (Next = False) loop

    -- #              #
    -- # Menu display #
    -- #              #
    Put_Line("1. Create the root");
    Put_Line("0. Exit");
    Put_Line("");

    GetUserChoice(User_Choice);
    case User_Choice is
      when 1 =>
        Put_Line("Root creation");
        Put_Line("");
        Init(Root, CreatePerson(ID));
        Next := True;
      when 0 =>
        Next := True;
      when others =>
        Put_Line("Invalid choice");
        Put_Line("");
    end case;

  end loop;

    -- #                   #
    -- # Tree modification #
    -- #                   #
  while (User_Choice /= 0) loop

    -- #              #
    -- # Menu display #
    -- #              #
    Put_Line("--- Menu display ---");
    Put_Line("");
    Put_Line("1. Display the tree");
    Put_Line("2. Add an ancestor to someone");
    Put_Line("3. Modify person's informations");
    Put_Line("4. Delete a person and all its ancestors");
    Put_Line("5. Obtain the number of ancestors of a person");
    Put_Line("6. List all the persons of a given generation (from the root)");
    Put_Line("7. Filter and display the persons with exactly 0 parents known");
    Put_Line("8. Filter and display the persons with exactly 1 parents known");
    Put_Line("9. Filter and display the persons with exactly 2 parents known");
    Put_Line("0. Exit");
    Put_Line("");

    GetUserChoice(User_Choice);

    case User_Choice is
      when 1 =>
        Put_Line("--- Tree display ---");
        Put_Line("");
        PrintTree(Root);
        Put_Line("");
      when 2 =>
        Put_Line("--- Adding an ancestor ---");
        Put_Line("");
        AncestorCreation(Root, ID);
        Put_Line("");
      when 3 =>
        Put_Line("--- Modify a person ---");
        Put_Line("");
        Put_Line("TODO when fields");
        Put_Line("");
      when 4 =>
        Put_Line("--- Deleting a genealogic branch ---");
        Put_Line("");
        BranchDeletion(Root, ID);
        if (IsEmpty(Root) = true) then
          User_Choice := 0; -- Exiting the program when root is deleted
        end if;
        Put_Line("");
      when 5 =>
        Put_Line("--- Count the number of ancestors  ---");
        Put_Line("");
        CountAncestors(Root);
        Put_Line("");
      when 6 =>
        Put_Line("--- Display a generation ---");
        Put_Line("");
        DisplayGeneration(Root);
        Put_Line("");
      when 7 =>
        Put_Line("--- Display the persons with exactly 0 parents known ---");
        Put_Line("");
        DisplayWithXParents(Root,0);
        Put_Line("");
      when 8 =>
        Put_Line("--- Display the persons with exactly 1 parents known ---");
        Put_Line("");
        DisplayWithXParents(Root,1);
        Put_Line("");
      when 9 =>
        Put_Line("--- Display the persons with exactly 2 parents known ---");
        Put_Line("");
        DisplayWithXParents(Root, 2);
        Put_Line("");
      when 0 =>
        Put_Line("You are leaving the program");
        Put_Line("");
      when others =>
        Put_Line("Invalid choice");
        Put_Line("");
    end case;

  end loop;

end Menu;
