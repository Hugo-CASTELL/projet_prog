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

  procedure GetUserChoice is
    Text : Unbounded_String;
  begin
    Put_Line("");
    Put("Enter your choice : ");
    Text := To_Unbounded_String(Get_Line);
    if (Length(Text) > 0) then
      begin
        User_Choice := Integer'Value(To_String(Text));
        -- Put_Line("Text :" & Text'Image);
        -- Put_Line("User_Choice : "User_Choice'Image);
      exception
        when Constraint_Error | Data_Error =>
          User_Choice := -1;
      end;
    else
      User_Choice := -1;
    end if;
    Put_Line("");
  end GetUserChoice;

  function CreatePerson(AutoID: in Natural) return T_Person is
    Person : T_Person;
  begin
    Put_Line("Person creation");
    Init(Person, AutoID);
    return Person;
  end CreatePerson;

begin
  ID := 0;
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

    GetUserChoice;
    case User_Choice is
      when 1 =>
        Put_Line("Root creation");
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
    Put_Line("1. Add a person");
    Put_Line("2. Add an ancestor to a certain person");
    Put_Line("3. Display the tree");
    Put_Line("4. Display the tree with the children");
    Put_Line("5. Display the tree with the parents");
    Put_Line("6. Display the tree with the parents and the children");
    Put_Line("7. Display the tree with the parents and the children (with the ID)");
    Put_Line("8. Display the tree with the parents and the children (with the");
    Put_Line("0. Exit");

    GetUserChoice;

    case User_Choice is
      when 1 =>
        Put_Line("Person creation");
      when 3 =>
        Put_Line("Display the tree");
        PrintTree(Root);
      when others =>
        Put_Line("Invalid choice");
        Put_Line("");
    end case;

  end loop;

end Menu;
